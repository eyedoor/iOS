//
//  Person.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 3/18/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

struct Person {
    var firstName: String
    var lastName: String
    var personID: Int
    var image: UIImage!
    
    init(_ dictionary: [String: Any]) {
        self.firstName = dictionary["FriendFirst"] as! String
        self.lastName = dictionary["FriendLast"] as! String
        self.personID = dictionary["FriendID"] as! Int
        //self.image = dictionary["completed"] as? Bool ?? false
    }
}
