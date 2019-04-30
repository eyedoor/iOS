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
    var eventMessage: String
    
    init(_ dictionary: [String: Any]) {
        self.eventID = dictionary["EventID"] as! Int
        self.timeSent = dictionary["Timesent"] as! String
        self.eventMessage = dictionary["EventMessage"] as! String
    }
    
    init(eventID: Int, timeSent: String, imageString: NSData?, eventMessage: String){
        self.eventID = eventID
        self.timeSent = timeSent
        self.eventMessage = eventMessage
        
        self.imageString = imageString
        
        if (imageString != nil){
            let decodedimage:UIImage = UIImage(data: imageString! as Data) ?? UIImage(named: "Person")!
            self.image = decodedimage
        }
    }
}
