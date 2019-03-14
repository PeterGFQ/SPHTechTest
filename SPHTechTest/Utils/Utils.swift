//
//  Utils.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    static var userDefaults: UserDefaults = UserDefaults.standard
    static var loadingAlert: UIAlertController? = nil

    static func saveUserDefaults(key:String, value:String){
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    static func loadUserDefaults(key:String) -> String{
        let value = userDefaults.object(forKey: key) as? String
        return value ?? ""
    }
    
//    static func removeUserDefaults(key: String) {
//        userDefaults.removeObject(forKey: key)
//        userDefaults.synchronize()
//    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 && (cString.count) != 8 {
            return UIColor.lightGray
        }
        
        if (cString.count) == 6 {
            cString = "FF" + cString
        }
        
        var rgbaValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbaValue)
        
        return UIColor(
            red: CGFloat((rgbaValue & 0x00FF0000) >> 16) / 255.0,
            green: CGFloat((rgbaValue & 0x0000FF00) >> 8) / 255.0,
            blue: CGFloat(rgbaValue & 0x000000FF) / 255.0,
            alpha: CGFloat((rgbaValue & 0xFF000000) >> 24) / 255.0
        )
    }
    
    //loading spinner
    static func showLoading(message: String) -> UIAlertController {
        loadingAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        //        alert?.view.tintColor = UIColor.ApplicationTheme.greenSuccess
        loadingAlert?.view.layer.cornerRadius = 40
        
        //set message
        let attributedString = NSAttributedString(string: message, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : UIColor.ApplicationTheme.greenSuccess
            ])
        loadingAlert?.setValue(attributedString, forKey: "attributedMessage")
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.color = UIColor.ApplicationTheme.greenSuccess
        loadingIndicator.startAnimating();
        
        loadingAlert?.view.addSubview(loadingIndicator)
        return loadingAlert!
    }
    
    static func dismissLoading(){
        if loadingAlert != nil {
            loadingAlert!.dismiss(animated: true, completion: nil)
            loadingAlert = nil
        }
    }
}
