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
    var imageString: NSData!
    
    init(_ dictionary: [String: Any]) {
        self.firstName = dictionary["FriendFirst"] as! String
        self.lastName = dictionary["FriendLast"] as! String
        self.personID = dictionary["FriendID"] as! Int
        //self.image = dictionary["completed"] as? Bool ?? false
    }
    
    init(firstname: String, lastname: String, personID: Int, imageString: NSData?){
        self.firstName = firstname
        self.lastName = lastname
        self.personID = personID
        self.imageString = imageString
        
        if (imageString != nil){
//            let dataDecoded:NSData = NSData(base64Encoded: imageString!, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let decodedimage:UIImage = UIImage(data: imageString! as Data)!
            self.image = decodedimage
        }
    }
}
