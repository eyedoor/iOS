//
//  HomeViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 1/31/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        QueryService.getEvents{ (events) in
            //print("friends list is \(friends)")
            //self.friends = friends as! [Person]
            DispatchQueue.main.async {
                self.events = events as! [Event]
                self.eventsTableView.reloadData()
                
                QueryService.getEventImage(eventID: self.events[0].eventID) { (base64Image) in
                    //print("friends list is \(friends)")
                    //self.friends = friends as! [Person]
                    DispatchQueue.main.async {
                        //self.events = events as! [Event]
                        //self.eventsTableView.reloadData()
                        let dataDecoded:NSData = NSData(base64Encoded: base64Image, options: NSData.Base64DecodingOptions(rawValue: 0))!
                        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                        self.eventImageView.image = decodedimage
                        //self.eventsTableView.reloadData()
                    }
                }
                
            }
        }
        
//        QueryService.getEventImage(eventID: events.last!.eventID) { (base64Image) in
//            //print("friends list is \(friends)")
//            //self.friends = friends as! [Person]
//            DispatchQueue.main.async {
//                //self.events = events as! [Event]
//                //self.eventsTableView.reloadData()
//                let dataDecoded:NSData = NSData(base64Encoded: base64Image, options: NSData.Base64DecodingOptions(rawValue: 0))!
//                let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
//                self.eventImageView.image = decodedimage
//                //self.eventsTableView.reloadData()
//            }
//        }
        
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewIdentifier") as! EventTableViewCell
        
        var dateString = events[indexPath.row].timeSent
        
        print(dateString)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "hh:mm a - MMM d, yyyy"
        print(date)
        
        
        cell.eventDateTimeLabel.text = dateFormatter.string(from: date!)//events[indexPath.row].timeSent
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        var currentEventID = events[indexPath.row].eventID
        print(currentEventID)
        QueryService.getEventImage(eventID: currentEventID) { (base64Image) in
            //print("friends list is \(friends)")
            //self.friends = friends as! [Person]
            DispatchQueue.main.async {
                //self.events = events as! [Event]
                //self.eventsTableView.reloadData()
                
                let dataDecoded:NSData = NSData(base64Encoded: base64Image, options: NSData.Base64DecodingOptions(rawValue: 0))!
                if let decodedimage:UIImage = UIImage(data: dataDecoded as Data) {
                    self.eventImageView.image = decodedimage
                } else {
                    self.eventImageView.image = nil
                }
                //self.eventImageView.image = decodedimage
                //self.eventsTableView.reloadData()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
