//
//  EventTableViewCell.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 4/2/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventDateTimeLabel: UILabel!
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventMessageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
