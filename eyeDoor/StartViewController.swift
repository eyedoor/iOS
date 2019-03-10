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
            //validateFace()
            self.performSegue(withIdentifier: "startToHome", sender: self)
        }

        // Do any additional setup after loading the view.
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
                            // User authenticated successfully, take appropriate action
                            //self.successLabel.text = "Awesome!!... User authenticated successfully"
                        } else {
                            
                            // User did not authenticate successfully, look at error and take appropriate action
                            //self.successLabel.text = "Sorry!!... User did not authenticate successfully"
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                //successLabel.text = "Sorry!!.. Could not evaluate policy."
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
