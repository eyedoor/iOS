//
//  HomeViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 1/31/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    var events = [EventStruct]()
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        _ = NSEntityDescription.entity(forEntityName: "Event", in: context)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let newEvent = EventStruct(eventID: data.value(forKey: "eventID") as! Int, timeSent: data.value(forKey: "date") as! String, imageString: data.value(forKey: "image") as? NSData, eventMessage: data.value(forKey: "eventMessage") as? String ?? "Someone visited")
                if !self.events.contains(where: {$0.eventID == newEvent.eventID}){
                    self.events.append(newEvent)
                }
            }
            self.eventsTableView.reloadData()
            
        } catch {
            print("Failed")
        }
        
        if (self.events.count == 0){
            print("loading events")
            loadEvents()
            
        } else {
            self.eventImageView.image = events[0].image
            let indexPath = IndexPath.init(row: 0, section: 0)
            self.eventsTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventsTableView.addSubview(self.refreshControl)
    }
    
    func saveEvents(events: Any){
        ///only add person if they dont exist******
        
        for event in events as! [EventStruct] {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "Event")
            request.predicate = NSPredicate(format: "eventID = %d", event.eventID)
            
            var results: [NSManagedObject] = []
            
            do {
                results = try context.fetch(request)
                
            }
            catch {
                print("error executing fetch request: \(error)")
            }
            
            if (results.count == 0){
                let createNewEvent = NSManagedObject(entity: entity!, insertInto: context)
                createNewEvent.setValue(event.eventID, forKey: "eventID")
                createNewEvent.setValue(event.timeSent, forKey: "date")
                createNewEvent.setValue(event.eventMessage, forKey: "eventMessage")
            }
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            
        }
    }
    func loadEvents(){
        QueryService.getEvents{ (events) in
            DispatchQueue.main.async {
                
                self.saveEvents(events: events)
                
                self.events = events as! [EventStruct]
                
                if (events.count != 0){
                    for (index, event) in self.events.enumerated(){
                        QueryService.getEventImage(eventID: event.eventID) { (base64Image) in
                            let dataDecoded:NSData = NSData(base64Encoded: base64Image, options: NSData.Base64DecodingOptions(rawValue: 0))!
                            
                            let decodedimage:UIImage = UIImage(data: dataDecoded as Data) ?? UIImage(named: "Person")!
                            self.events[index].image = decodedimage
                            
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            let context = appDelegate.persistentContainer.viewContext
                            _ = NSEntityDescription.entity(forEntityName: "Event", in: context)
                            
                            let request = NSFetchRequest<NSManagedObject>(entityName: "Event")
                            request.predicate = NSPredicate(format: "eventID = %d", event.eventID)
                            
                            var results: [NSManagedObject] = []
                            
                            do {
                                results = try context.fetch(request)
                                for data in results {
                                    data.setValue(dataDecoded, forKey: "image")
                                }
                                try context.save()
                            }
                            catch {
                                print("error executing fetch request: \(error)")
                            }
                            
                            self.eventsTableView.reloadData()
                            self.eventImageView.image = self.events[0].image
                            let indexPath = IndexPath.init(row: 0, section: 0)
                            self.eventsTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
                            
                        }
                    }
                    
                }
                
            }
            
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.white
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("refreshing")
        //not full load events   just like the onviewappear
        self.deleteAllData(entity: "Event")
        self.loadEvents()
                
        self.eventsTableView.reloadData()
        
        
        refreshControl.endRefreshing()
    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewIdentifier") as! EventTableViewCell
        
        let dateString = events[indexPath.row].timeSent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "hh:mm a 'on' MMM d, yyyy"
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        cell.selectedBackgroundView = backgroundView
        
        cell.eventImageView.roundedImage()
        cell.eventImageView.image = events[indexPath.row].image
        cell.eventMessageLabel.text = events[indexPath.row].eventMessage
        cell.eventDateTimeLabel.text = dateFormatter.string(from: date!)//events[indexPath.row].timeSent
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.eventImageView.image = events[indexPath.row].image
    }
    
}
