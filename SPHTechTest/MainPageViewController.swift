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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkInternetReachability()
    }
    
    fileprivate func checkInternetReachability(){
        if NetworkManager.sharedInstance.isConnectedToNetwork() {
            fetchRemoteData()
        } else {
            if Utils.loadUserDefaults(key: OFFLINE_DATA) != "" {
                loadLocalData()
            }
        }
    }
    
    fileprivate func fetchRemoteData() {
        present(Utils.showLoading(message: "Fetching data remotely"), animated: true, completion: {
            RestfulServices.getInstance().fetchData(fetchDataCompletionHandler: { ( quarterlyMobileDataUsages ) in
                Utils.dismissLoading()
                
            }, failure: { (exception) in
                Utils.dismissLoading()
                AlertManager.shared.showBottomMessage(viewController: self, message: exception.error?.userInfo["message"] as! String)
            })
        })
    }
    
    fileprivate func loadLocalData() {
        
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
        cell.lbl_year.text = String(data.year!)
        cell.lbl_volume_annual.text = String(data.volumeOfMobileData!)
        for element in data.quarterlyVolume! {
            let quarter = element.key.substring(from: 5)
            switch quarter {
            case Q1:
                cell.lbl_q1.text = element.key
                cell.lbl_volume_q1.text = String(element.value)
            case Q2:
                cell.lbl_q2.text = element.key
                cell.lbl_volume_q2.text = String(element.value)
            case Q3:
                cell.lbl_q3.text = element.key
                cell.lbl_volume_q3.text = String(element.value)
            case Q4:
                cell.lbl_q4.text = element.key
                cell.lbl_volume_q4.text = String(element.value)
            default: break
            }
        }
        return cell
    }

}

