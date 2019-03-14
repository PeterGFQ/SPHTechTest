//
//  UIColorExtension.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    struct ApplicationTheme {
        static var greenSuccess: UIColor { return Utils.hexStringToUIColor(hex: "4BB543") }
        static var redWarning: UIColor { return Utils.hexStringToUIColor(hex: "CC0000") }
//        static var greyDisabled : UIColor { return Utils.hexStringToUIColor(hex: "7C7C7C") }
    }
}
