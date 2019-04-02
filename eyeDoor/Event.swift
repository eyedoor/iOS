//
//  Event.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 4/1/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

struct Event {
    var eventID: Int
    var timeSent: String
    
    init(_ dictionary: [String: Any]) {
        self.eventID = dictionary["EventID"] as! Int
        self.timeSent = dictionary["Timesent"] as! String
        //self.personID = dictionary["FriendID"] as! Int
        //self.image = dictionary["completed"] as? Bool ?? false
    }
}
