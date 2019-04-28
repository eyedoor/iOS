//
//  SignUpViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 2/19/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController,UITextFieldDelegate  {
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstnameTextField.delegate = self
        lastnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPassTextField.delegate = self
        confirmPassTextField.keyboardType = UIKeyboardType.alphabet
        //firstnameTextField.tag = 0
        signupButton.isEnabled = false
        [firstnameTextField, lastnameTextField, emailTextField, passwordTextField, confirmPassTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            textField.resignFirstResponder()
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    @IBAction func signupAction(_ sender: Any) {
        
        //if passwords dont match, send alert to user
        if passwordTextField.text != confirmPassTextField.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            //create user
            QueryService.createUser(email: emailTextField.text!, password: passwordTextField.text!, firstname: firstnameTextField.text!, lastname: lastnameTextField.text!, completion: {(auth: Bool) -> Void in
                
                if (auth == true) {
                    QueryService.loginUser(email: self.emailTextField.text!, password: self.passwordTextField.text!, completion: {(auth: Bool, newUser: User) -> Void in
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
                                self.performSegue(withIdentifier: "signupToHome", sender: self)
                            } catch {
                                print("Failed saving")
                            }
                        } else {
                            let alertController = UIAlertController(title: "Error", message: "Could not log into new account", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    })
                } else {
                    let alertController = UIAlertController(title: "Error", message: "User not created", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
            
        }
    }
    
    
    
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text!.count == 1 {
            if textField.text!.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let first = firstnameTextField.text, !first.isEmpty,
            let last = lastnameTextField.text, !last.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let confirmPass = confirmPassTextField.text, !confirmPass.isEmpty
            else {
                signupButton.isEnabled = false
                return
        }
        signupButton.isEnabled = true
        
    }
}
