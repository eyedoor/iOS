//
//  DetailViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 4/1/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var friendImageView: UIImageView!
    var firstName: String = ""
    var lastName: String = ""
    var friendID: Int = -1
    
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(firstName) \(lastName)"
        friendImageView.roundedImage()
        print("friendID =  \(self.friendID)")
        
        QueryService.getFriendEvents(friendID: self.friendID, completion: {(events) in
            //print("friends list is \(friends)")
            //self.friends = friends as! [Person]
            DispatchQueue.main.async {
                self.events = events as! [Event]
                self.eventTableView.reloadData()
                print(events)
                if (events.count > 0){
                    QueryService.getEventImage(eventID: self.events[0].eventID) { (base64Image) in
                        //print("friends list is \(friends)")
                        //self.friends = friends as! [Person]
                        DispatchQueue.main.async {
                            //self.events = events as! [Event]
                            //self.eventsTableView.reloadData()
                            let dataDecoded:NSData = NSData(base64Encoded: base64Image, options: NSData.Base64DecodingOptions(rawValue: 0))!
                            let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                            self.friendImageView.image = decodedimage
                            //self.eventsTableView.reloadData()
                            let indexPath = IndexPath.init(row: 0, section: 0)
                            self.eventTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
                        }
                    }
                }
                
            }
            
        })
            
            
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteFriend(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete", message: "Are you sure you want to permanently delete your friend?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: { action in
            QueryService.deleteFriend(friendID: self.friendID, completion: {(success) in
                //print("friends list is \(friends)")
                //self.friends = friends as! [Person]
                DispatchQueue.main.async {
                    if (success){
                        //go back
                        self.performSegue(withIdentifier: "cancel", sender: self)
                    } else {
                        let alertController = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
                
            })
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendEventTableViewIdentifier") as! FriendEventTableViewCell
        
        let dateString = events[indexPath.row].timeSent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "hh:mm a 'on' MMM d, yyyy"
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        cell.selectedBackgroundView = backgroundView
        
        cell.dateTimeLabel.text = dateFormatter.string(from: date!)//events[indexPath.row].timeSent
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("selected")
        var currentEventID = events[indexPath.row].eventID
        //print(currentEventID)
        QueryService.getEventImage(eventID: currentEventID) { (base64Image) in
            //print("friends list is \(friends)")
            //self.friends = friends as! [Person]
            DispatchQueue.main.async {
                //self.events = events as! [Event]
                //self.eventsTableView.reloadData()
                
                let dataDecoded:NSData = NSData(base64Encoded: base64Image, options: NSData.Base64DecodingOptions(rawValue: 0))!
                if let decodedimage:UIImage = UIImage(data: dataDecoded as Data) {
                    self.friendImageView.image = decodedimage
                } else {
                    self.friendImageView.image = nil
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
