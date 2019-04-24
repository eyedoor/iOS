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
                emailLabel.text = data.value(forKey: "email") as! String
            }
        } catch {
            print("Failed")
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentUser")
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
               context.delete(data)
            }
            //log user out
            //if successful, then go back to start
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "LoggedIn")
            defaults.set(nil, forKey: "token")
        } catch {
            print("Failed")
        }
        //self.performSegue(withIdentifier: "accountToStart", sender: self)
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
