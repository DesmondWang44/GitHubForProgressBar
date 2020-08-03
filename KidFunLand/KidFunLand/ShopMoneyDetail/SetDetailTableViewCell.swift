//
//  SetDetailTableViewCell.swift
//  KidFunLand
//
//  Created by WANG YAO-KUAN on 2020/7/28.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//

import UIKit

class SetDetailTableViewCell: UITableViewCell {

    
    

    @IBOutlet weak var IOStatsImage: UIImageView!
    @IBOutlet weak var sysRemarkLabel: UILabel!
    @IBOutlet weak var moneyDateLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
