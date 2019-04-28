//
//  AccountViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 1/31/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit
import CoreData

class AccountViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentUser")
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                nameLabel.text = "\(data.value(forKey: "firstname") as! String)\(data.value(forKey: "lastname") as! String)"
                emailLabel.text = (data.value(forKey: "email") as! String)
            }
        } catch {
            print("Failed")
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        deleteAllData(entity: "CurrentUser")
        deleteAllData(entity: "Friend")
        deleteAllData(entity: "Event")
        
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "LoggedIn")
        defaults.set(nil, forKey: "token")
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
    
}
