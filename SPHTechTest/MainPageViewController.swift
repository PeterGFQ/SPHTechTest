//
//  MainPageTableViewController.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import UIKit
import Bond

class MainPageTableViewController: UITableViewController {
    
    var datas: [AnnuallyMobileDataUsage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        
        let bbi_refresh = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItems = [bbi_refresh]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkInternetReachability()
    }
    
    @objc func refresh() {
        checkInternetReachability()
    }
    
    fileprivate func checkInternetReachability(){
        if NetworkManager.sharedInstance.isConnectedToNetwork() {
            fetchRemoteData()
        } else {
            loadLocalData()
        }
    }
    
    fileprivate func fetchRemoteData() {
        present(Utils.showLoading(message: "Fetching data remotely"), animated: true, completion: {
            RestfulServices.getInstance().fetchData(fetchDataCompletionHandler: { ( quarterlyMobileDataUsages ) in
                Utils.dismissLoading()
                self.datas = DataMappingServices.getInstance().mapFromQMDsUToAMDUs(qMDUs: quarterlyMobileDataUsages)
                OfflineDataServices.getInstance().writeDataToJsonFile(datas: self.datas)
                AlertManager.shared.showBottomMessage(viewController: self, message: "Load data from internet")
                self.tableView.reloadData()
            }, failure: { (exception) in
                Utils.dismissLoading()
                AlertManager.shared.showBottomMessage(viewController: self, message: exception.error?.userInfo["message"] as! String)
            })
        })
    }
    
    fileprivate func loadLocalData() {
        self.datas = OfflineDataServices.getInstance().readFromJsonFile()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas.item(at: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnnuallyDataCell", for: indexPath) as? CardTableViewCell else {
            return UITableViewCell()
        }
        [cell.lbl_year, cell.lbl_volume_annual, cell.lbl_q1, cell.lbl_q2, cell.lbl_q3, cell.lbl_q4, cell.lbl_volume_q1, cell.lbl_volume_q2, cell.lbl_volume_q3, cell.lbl_volume_q4].forEach({
            $0?.text = ""
        })
        cell.lbl_year.text = String(data.year!)
        cell.lbl_volume_annual.text = data.volumeOfMobileData!.substring(to: 6)
        for element in data.quarterlyVolume! {
            let quarter = element.key.substring(from: 5)
            switch quarter {
            case Q1:
                cell.lbl_q1.text = element.key
                cell.lbl_volume_q1.text = element.value.substring(to: 6)
            case Q2:
                cell.lbl_q2.text = element.key
                cell.lbl_volume_q2.text = element.value.substring(to: 6)
            case Q3:
                cell.lbl_q3.text = element.key
                cell.lbl_volume_q3.text = element.value.substring(to: 6)
            case Q4:
                cell.lbl_q4.text = element.key
                cell.lbl_volume_q4.text = element.value.substring(to: 6)
            default: break
            }
        }
        return cell
    }

}

