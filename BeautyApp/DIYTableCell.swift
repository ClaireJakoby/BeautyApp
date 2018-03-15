//
//  DIYTableCell.swift
//  BeautyApp
//
//  Created by  Sayed on 11-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit

class DIYTableCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

