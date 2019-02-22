//
//  SignUpViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 2/19/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate  {

    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPassTextField.delegate = self
        emailTextField.tag = 0
        signupButton.isEnabled = false
        [firstnameTextField, lastnameTextField, emailTextField, passwordTextField, confirmPassTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        // Do any additional setup after loading the view.
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
    
    @IBAction func signupAction(_ sender: Any) {
        
        //if passwords dont match, send alert to user
        if passwordTextField.text != confirmPassTextField.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            //create user
            print("creating user")
            if (QueryService.createUser(email: emailTextField.text!, password: passwordTextField.text!, firstname: firstnameTextField.text!, lastname: lastnameTextField.text!) == true) {
                self.performSegue(withIdentifier: "signupToHome", sender: self)
            } else {
                let alertController = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        //print(textField)
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
                //print("signup not enabled")
                signupButton.isEnabled = false
                return
        }
        //print("signup enabled")
        signupButton.isEnabled = true
        
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
