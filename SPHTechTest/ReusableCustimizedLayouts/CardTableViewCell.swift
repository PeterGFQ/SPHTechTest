//
//  CardTableViewCell.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import UIKit

class CardTableViewCell: UITableViewCell {
    
    @IBOutlet var lbl_year: UILabel!
    @IBOutlet var lbl_volume_annual: UILabel!
    @IBOutlet var lbl_volume_q1: UILabel!
    @IBOutlet var lbl_volume_q2: UILabel!
    @IBOutlet var lbl_volume_q3: UILabel!
    @IBOutlet var lbl_volume_q4: UILabel!
    @IBOutlet var lbl_q1: UILabel!
    @IBOutlet var lbl_q2: UILabel!
    @IBOutlet var lbl_q3: UILabel!
    @IBOutlet var lbl_q4: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
