//
//  NewPersonViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 3/18/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

class NewPersonViewController: UIViewController {

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        [firstNameTextField, lastNameTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })

        personImageView.roundedImage()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showImagePicker(_ sender: UIButton) {
         self.imagePicker.present(from: sender)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
        let image = personImageView.image!
        let reducedImage = image.resized(withPercentage: 0.1)
        
        
        let imageData = reducedImage!.pngData()
        print(imageData)
        let strBase64 = imageData?.base64EncodedString()
        print(strBase64)
        QueryService.createPerson(firstname: firstNameTextField.text!, lastname: lastNameTextField.text!, image: strBase64!, completion: {(success: Bool) -> Void in
            print("success is \(success)")
            if(success == true){
                self.performSegue(withIdentifier: "cancel", sender: self)
            } else {
                let alertController = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }

        })

        //print(strBase64)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
            
        case "cancel":
            print("cancel bar button item tapped")
            
        default:
            print("unexpected segue identifier")
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
            let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty,
            let image = personImageView.image, image != nil
            else {
                saveButton.isEnabled = false
                return
        }
        saveButton.isEnabled = true
        
    }

}



extension NewPersonViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.personImageView.image = image
    }
}

extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
