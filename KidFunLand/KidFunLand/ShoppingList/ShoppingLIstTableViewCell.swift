//
//  ShoppingLIstTableViewCell.swift
//  KidFunLand
//
//  Created by WANG YAO-KUAN on 2020/7/26.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//

import UIKit

class ShoppingLIstTableViewCell: UITableViewCell {

    


    @IBOutlet weak var productQTY: UILabel!
    @IBOutlet weak var isArriveLabel: UILabel!
    @IBOutlet weak var isTakeLabel: UILabel!
    @IBOutlet weak var isPayLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        productPic.layer.cornerRadius = 15
        
    }
    
}
