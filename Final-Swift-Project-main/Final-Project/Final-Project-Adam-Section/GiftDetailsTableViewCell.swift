//
//  GiftDetailsTableViewCell.swift
//  Final-Project-Adam-Section
//
//  Created by Parth Bhavesh Kumar Bhatt on 2020-12-13.
//  Copyright © 2020 Adam McNown. All rights reserved.
//

import UIKit

class GiftDetailsTableViewCell: UITableViewCell {
    
    //outlet connections
    @IBOutlet weak var ideaLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

