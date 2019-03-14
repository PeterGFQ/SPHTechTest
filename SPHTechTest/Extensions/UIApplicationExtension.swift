//
//  UIApplicationExtension.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}
