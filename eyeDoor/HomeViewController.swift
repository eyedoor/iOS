//
//  HomeViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 1/31/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var eventsTableView: UITableView!
    
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        QueryService.getEvents{ (events) in
            //print("friends list is \(friends)")
            //self.friends = friends as! [Person]
            DispatchQueue.main.async {
                self.events = events as! [Event]
                self.eventsTableView.reloadData()
                
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewIdentifier") as! EventTableViewCell
        
        var dateString = events[indexPath.row].timeSent
        
//        print(dateString)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "YYYY-MM-DDTHH:MI:SS Z"
//        let date = dateFormatter.date(from: dateString)
//        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        cell.eventDateTimeLabel.text = dateString//events[indexPath.row].timeSent
        
        return cell
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
