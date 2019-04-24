//
//  User.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 4/24/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

struct User {
    var auth : Bool
    var token : String
    var firstName: String
    var lastName: String
    var email: String
    var deviceToken: String
    
    init(_ dictionary: [String: Any]) {
        self.auth = dictionary["auth"] as! Bool
        self.token = dictionary["token"] as! String
        self.firstName = dictionary["firstname"] as! String
        self.lastName = dictionary["lastname"] as! String
        self.email = dictionary["email"] as! String
        self.deviceToken = dictionary["deviceToken"] as! String
        //self.image = dictionary["completed"] as? Bool ?? false
    }
    
    init(){
        self.auth = false
        self.token = ""
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.deviceToken = ""
    }
}
