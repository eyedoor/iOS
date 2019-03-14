//
//  MyPeopleViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 3/9/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

class MyPeopleViewController: UIViewController {

    @IBOutlet weak var person1ImageView: UIImageView!
    @IBOutlet weak var person2ImageView: UIImageView!
    @IBOutlet weak var person3ImageView: UIImageView!
    @IBOutlet weak var person4ImageView: UIImageView!
    @IBOutlet weak var person5ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        person1ImageView.roundedImage()
        person2ImageView.roundedImage()
        person3ImageView.roundedImage()
        person4ImageView.roundedImage()
        person5ImageView.roundedImage()

        // Do any additional setup after loading the view.
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
