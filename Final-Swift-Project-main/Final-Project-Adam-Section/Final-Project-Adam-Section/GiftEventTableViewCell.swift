//
//  GiftEventTableViewCell.swift
//  Final-Project-Adam-Section
//
//  Created by Adam Mcnown on 2020-12-12.
//  Copyright © 2020 Adam McNown. All rights reserved.
//

import UIKit

class GiftEventTableViewCell: UITableViewCell {
    
    // cell varaibles
    @IBOutlet weak var EventLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
