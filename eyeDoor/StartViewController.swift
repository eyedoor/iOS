//
//  StartViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 2/19/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit
import LocalAuthentication

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let isLoggedIn = defaults.bool(forKey: "LoggedIn")
        if (isLoggedIn == true){
            let token = defaults.string(forKey: "token")
            //call api for token verification
            QueryService.verifyUser(completion: {(auth: Bool) -> Void in
                if(auth == true){
                    self.validateFace()
                } else {
                    let alertController = UIAlertController(title: "Error", message: "You have been signed out.  Please login again.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            })
            
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
                        }
                    }
                }
            } else {
            }
        }
    }
    
    @IBAction func restartWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
}
