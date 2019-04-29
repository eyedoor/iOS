//
//  StartViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 2/19/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit
import LocalAuthentication
import CoreData

class StartViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        signUpButton.isEnabled = false
        let defaults = UserDefaults.standard
        let isLoggedIn = defaults.bool(forKey: "LoggedIn")
        if (isLoggedIn == true){
            //call api for token verification
            QueryService.verifyUser(completion: {(auth: Bool) -> Void in
                if(auth == true){
                    self.validateFace()
                } else {
                    let alertController = UIAlertController(title: "Error", message: "You have been signed out.  Please login again.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    
                    self.deleteAllData(entity: "CurrentUser")
                    self.deleteAllData(entity: "Friend")
                    self.deleteAllData(entity: "Event")
                    
                    let defaults = UserDefaults.standard
                    defaults.set(false, forKey: "LoggedIn")
                    defaults.set(nil, forKey: "token")
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            })
            
        } else {
            loginButton.isEnabled = true
            signUpButton.isEnabled = true
        }
        
    }
    
    
    func validateFace(){
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authentication"
        
        var authError: NSError?
        
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                            self.performSegue(withIdentifier: "startToHome", sender: self)
                        } else {
                            self.loginButton.isEnabled = true
                        }
                    }
                }
            } else {
            }
        }
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
    
    @IBAction func restartWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
}
