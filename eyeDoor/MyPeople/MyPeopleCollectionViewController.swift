//
//  MyPeopleCollectionViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 3/19/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit

final class MyPeopleCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    private let reuseIdentifier = "MyPeopleCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    private let itemsPerRow: CGFloat = 2
    
    
    
    var images: [UIImage] = [
        UIImage(named: "Girl1.png")!,
        UIImage(named: "Boy1.png")!,
        UIImage(named: "Girl2.png")!,
        UIImage(named: "Girl1.png")!,
        UIImage(named: "Boy1.png")!,
        UIImage(named: "Girl1.png")!,
        UIImage(named: "Boy1.png")!,
        UIImage(named: "Girl2.png")!,
        UIImage(named: "Girl1.png")!,
        UIImage(named: "Boy1.png")!,
        UIImage(named: "Girl1.png")!,
        UIImage(named: "Boy1.png")!,
        UIImage(named: "Girl2.png")!,
        UIImage(named: "Girl1.png")!,
        UIImage(named: "Boy1.png")!,
    ]
    
    var friends = [Person]()
    
    override func viewDidAppear(_ animated: Bool) {
        QueryService.getFriendNames { (friends) in
            //print("friends list is \(friends)")
            //self.friends = friends as! [Person]
            DispatchQueue.main.async {
                self.friends = friends as! [Person]
                self.collectionView.reloadData()
                for (index, friend) in self.friends.enumerated(){
                    QueryService.getFriendImage(friendID: friend.personID) { (base64Image) in
                        //print("attempting to get image")
                        let dataDecoded:NSData = NSData(base64Encoded: base64Image, options: NSData.Base64DecodingOptions(rawValue: 0))!
                        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                        self.friends[index].image = decodedimage
                        //print(self.friends[index].image)
                        //print("trying to reload")
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
//        QueryService.getFriendNames { (friends) in
//            //print("friends list is \(friends)")
//            //self.friends = friends as! [Person]
//            DispatchQueue.main.async {
//                self.friends = friends as! [Person]
//                //self.collectionView.reloadData()
//                for (index, friend) in self.friends.enumerated(){
//                    QueryService.getFriendImage(friendID: friend.personID) { (base64Image) in
//                        //print("attempting to get image")
//                        let dataDecoded:NSData = NSData(base64Encoded: base64Image, options: NSData.Base64DecodingOptions(rawValue: 0))!
//                        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
//                        self.friends[index].image = decodedimage
//                        //print(self.friends[index].image)
//                        //print("trying to reload")
//                        self.collectionView.reloadData()
//                    }
//                }
//            }
//        }
        
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
}

// MARK: - UICollectionViewDataSource
extension MyPeopleCollectionViewController {
    //1
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    //3
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! MyPeopleCollectionViewCell
        
        //let cell = MyPeopleCollectionViewCell()
        //2
        if let personPhoto = friends[indexPath.row].image {
            cell.personImageView.image = personPhoto
        }
        
        var name = ""
        if (friends.count != 0 && friends.count > indexPath.row){
            name = friends[indexPath.row].firstName
        }
        
        //3
        //cell.imageView.image = personPhoto.thumbnail
       // cell.personImageView.image = personPhoto
        cell.personImageView.backgroundColor = UIColor.black
        cell.nameLabel.text = name
        cell.personImageView.roundedImage()
        return cell
    }
    
}

// MARK: - Collection View Flow Layout Delegate
extension MyPeopleCollectionViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


