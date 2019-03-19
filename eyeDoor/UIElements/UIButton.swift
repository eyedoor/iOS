//
//  UIButton.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 3/18/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

extension UIButton {
    
    func roundedImage() {
        self.layer.cornerRadius = 33
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
}
