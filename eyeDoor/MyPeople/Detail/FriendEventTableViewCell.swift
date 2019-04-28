//
//  FriendEventTableViewCell.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 4/23/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

class FriendEventTableViewCell: UITableViewCell {

    @IBOutlet weak var dateTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
