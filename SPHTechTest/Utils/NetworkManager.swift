//
//  NetworkManager.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import SystemConfiguration
import Reachability

class NetworkManager: NSObject{
    
    var reachability: Reachability?
    
    static let sharedInstance: NetworkManager = {
        return NetworkManager()
    }()
    
    override init() {
        super.init()
        // Initialise reachability
        reachability = Reachability()!
        // Register an observer for the network status
        startMonitoring()
    }
    
    func startMonitoring() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(notification:)),
            name: .reachabilityChanged,
            object: reachability
        )
        do {
            // Start the network status notifier
            try reachability!.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func stopMonitoring() {
        do {
            // Stop the network status notifier
            try (NetworkManager.sharedInstance.reachability)!.startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    @objc func networkStatusChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        let topMostViewController = UIApplication.shared.topMostViewController()
        switch reachability.connection {
        case .none:
            AlertManager.shared.showOfflineMessage(viewController: topMostViewController!)
        case .wifi: break
//            AlertManager.shared.showToastMessage(viewController: topMostViewController!, message: "Network reachable through WiFi")
//            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
//                AlertManager.shared.toastContainer.alpha = 0.0
//            }, completion: {_ in
//                AlertManager.shared.toastContainer.removeFromSuperview()
//            })
        case .cellular: break
//            AlertManager.shared.showToastMessage(viewController: topMostViewController!, message: "Network reachable through Cellular Data")
//            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
//                AlertManager.shared.toastContainer.alpha = 0.0
//            }, completion: {_ in
//                AlertManager.shared.toastContainer.removeFromSuperview()
//            })
        }
    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
    
}
