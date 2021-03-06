//
//  LoginViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 2/19/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.tag = 0
        loginButton.isEnabled = false
        [emailTextField, passwordTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    @IBAction func loginAction(_ sender: Any) {
        //login user
        
        QueryService.loginUser(email: emailTextField.text!, password: passwordTextField.text!, completion: {(auth: Bool, newUser: User)  -> Void in
            if(auth == true){
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "CurrentUser", in: context)
                let createNewUser = NSManagedObject(entity: entity!, insertInto: context)
                
                createNewUser.setValue(newUser.deviceToken, forKey: "deviceToken")
                createNewUser.setValue(newUser.email, forKey: "email")
                createNewUser.setValue(newUser.firstName, forKey: "firstname")
                createNewUser.setValue(newUser.lastName, forKey: "lastname")
                
                do {
                    try context.save()
                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: "LoggedIn")
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                } catch {
                    print("Failed saving")
                }
                
                
            } else {
                let alertController = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        })
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text!.count == 1 {
            if textField.text!.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
            else {
                loginButton.isEnabled = false
                return
        }
        loginButton.isEnabled = true
        
    }
    
}
