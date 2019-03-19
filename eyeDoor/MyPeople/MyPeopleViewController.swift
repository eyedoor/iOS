//
//  MyPeopleViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 3/9/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

class MyPeopleViewController: UIViewController, UIGestureRecognizerDelegate {

    //@IBOutlet weak var person1ImageView: UIImageView!
    @IBOutlet weak var person1Button: UIButton!
    @IBOutlet weak var person2ImageView: UIImageView!
    @IBOutlet weak var person3ImageView: UIImageView!
    @IBOutlet weak var person4ImageView: UIImageView!
    @IBOutlet weak var person5ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //person1ImageView.roundedImage()
        person2ImageView.roundedImage()
        person3ImageView.roundedImage()
        person4ImageView.roundedImage()
        person5ImageView.roundedImage()
        
        person1Button.roundedImage()
        
        person1Button.setImage(UIImage(named: "8ZDF%t1cQ16%2wz3eQBwwg_thumb_10d4"), for: UIControl.State.normal)
        person1Button.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
        
//        var UITapRecognizer = UITapGestureRecognizer(target: self, action: Selector(("imageTapped:")))
//        UITapRecognizer.delegate = self
//        self.person1ImageView.addGestureRecognizer(UITapRecognizer)
//        self.person1ImageView.isUserInteractionEnabled = true
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MyPeopleViewController.imageTapped(gesture:)))
//
//        // add it to the image view;
//        person1ImageView.addGestureRecognizer(tapGesture)
//        // make sure imageView can be interacted with by user
//        person1ImageView.isUserInteractionEnabled = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
//    func imageTapped(sender: AnyObject) {
//        // if the tapped view is a UIImageView then set it to imageview
//        
//            print("Image Tapped")
//            //Here you can initiate your new ViewController
//            
//        
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
