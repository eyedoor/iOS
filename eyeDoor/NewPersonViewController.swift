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
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showImagePicker(_ sender: UIButton) {
         self.imagePicker.present(from: sender)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        
        let image = personImageView.image!
        let reducedImage = image.resized(withPercentage: 0.3)
        
        let imageData = reducedImage!.pngData()
        print(imageData)
        let strBase64 = imageData?.base64EncodedString()
        print(strBase64)
        QueryService.createPerson(firstname: firstNameTextField.text!, lastname: lastNameTextField.text!, image: strBase64!, completion: {(auth: Bool) -> Void in
            print("auth is \(auth)")
//            if(auth == true){
//                let defaults = UserDefaults.standard
//                defaults.set(true, forKey: "LoggedIn")
//                self.performSegue(withIdentifier: "loginToHome", sender: self)
//            } else {
//                let alertController = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
//                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//
//                alertController.addAction(defaultAction)
//                self.present(alertController, animated: true, completion: nil)
//            }

        })
        
        //print(strBase64)
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
