//
//  SaleProductDetailTableViewCell.swift
//  KidFunLand
//
//  Created by WANG YAO-KUAN on 2020/8/2.
//  Copyright © 2020 WANG YAO-KUAN. All rights reserved.
//

import UIKit

class SaleProductDetailTableViewCell: UITableViewCell {

   
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var ProductNmae: UILabel!
    @IBOutlet weak var ProductPic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        ProductPic.layer.cornerRadius = 15
        
        
        
        // Configure the view for the selected state
    }
    
}
