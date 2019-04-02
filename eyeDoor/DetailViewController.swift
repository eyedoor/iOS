//
//  DetailViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 4/1/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var friendImageView: UIImageView!
    var firstName: String = ""
    var lastName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(firstName) \(lastName)"
        friendImageView.roundedImage()
        print(friendImageView.image)
        

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
