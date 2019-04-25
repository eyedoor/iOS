//
//  Event.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 4/1/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

struct EventStruct {
    var eventID: Int
    var timeSent: String
    var image: UIImage!
    var imageString: NSData!
    
    init(_ dictionary: [String: Any]) {
        self.eventID = dictionary["EventID"] as! Int
        self.timeSent = dictionary["Timesent"] as! String
        //self.personID = dictionary["FriendID"] as! Int
        //self.image = dictionary["completed"] as? Bool ?? false
    }
    
    init(eventID: Int, timeSent: String, imageString: NSData?){
        self.eventID = eventID
        self.timeSent = timeSent
        
        self.imageString = imageString
        
        if (imageString != nil){
            //            let dataDecoded:NSData = NSData(base64Encoded: imageString!, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let decodedimage:UIImage = UIImage(data: imageString! as Data)!
            self.image = decodedimage
        }
    }
}
