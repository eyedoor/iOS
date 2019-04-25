//
//  MyPeopleCollectionViewController.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 3/19/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit
import CoreData

final class MyPeopleCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    private let reuseIdentifier = "MyPeopleCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    private let itemsPerRow: CGFloat = 2
    
    var friends = [Person]()
    
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Friend", in: context)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                var newPerson = Person(firstname: data.value(forKey: "firstname") as! String, lastname: data.value(forKey: "lastname") as! String, personID: data.value(forKey: "friendID") as! Int, imageString: data.value(forKey: "image") as? NSData)
                if !self.friends.contains(where: {$0.personID == newPerson.personID}){
                    //print(newPerson.image)
                    self.friends.append(newPerson)
                }
                
                //print(newPerson)
            }
            self.collectionView.reloadData()
        } catch {
            print("Failed")
        }
        
        if (self.friends.count == 0){
            print("loading friends")
            loadFriends()
        }
    }
    
    
    override func viewDidLoad() {
        
    }
    
    func saveFriends(friends: Any){
        ///only add person if they dont exist******
        for friend in friends as! [Person] {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Friend", in: context)
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "Friend")
            request.predicate = NSPredicate(format: "friendID = %d", friend.personID)
            
            var results: [NSManagedObject] = []
            
            do {
                results = try context.fetch(request)
                
            }
            catch {
                print("error executing fetch request: \(error)")
            }
            
            if (results.count == 0){
                let createNewFriend = NSManagedObject(entity: entity!, insertInto: context)
                createNewFriend.setValue(friend.firstName, forKey: "firstname")
                createNewFriend.setValue(friend.lastName, forKey: "lastname")
                createNewFriend.setValue(friend.personID, forKey: "friendID")
            }
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        deleteAllData(entity: "Friend")
        loadFriends()
    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    func loadFriends(){
        QueryService.getFriendNames { (friends) in
            //print("friends list is \(friends)")
            //self.friends = friends as! [Person]
            DispatchQueue.main.async {
                
                self.saveFriends(friends: friends)
                
                self.friends = friends as! [Person]
                //self.collectionView.reloadData()
                for (index, friend) in self.friends.enumerated(){
                    QueryService.getFriendImage(friendID: friend.personID) { (base64Image) in
                        //print("attempting to get image")
                        let dataDecoded:NSData = NSData(base64Encoded: base64Image, options: NSData.Base64DecodingOptions(rawValue: 0))!
                        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                        self.friends[index].image = decodedimage
                        ///
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let context = appDelegate.persistentContainer.viewContext
                        let entity = NSEntityDescription.entity(forEntityName: "Friend", in: context)
                        
                        let request = NSFetchRequest<NSManagedObject>(entityName: "Friend")
                        request.predicate = NSPredicate(format: "friendID = %d", friend.personID)
                        
                        var results: [NSManagedObject] = []
                        
                        do {
                            results = try context.fetch(request)
                            //results as! [NSManagedObject]
                            for data in results as! [NSManagedObject]{
                                data.setValue(dataDecoded, forKey: "image")
                            }
                            try context.save()
                        }
                        catch {
                            print("error executing fetch request: \(error)")
                        }
                        self.collectionView.reloadData()
                        
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPersonDetail" {
            
            let detailsVC = segue.destination as! DetailViewController
            let cell = sender as! MyPeopleCollectionViewCell
            let indexPaths = self.collectionView.indexPath(for: cell)
            let person = self.friends[indexPaths!.row] as Person
            detailsVC.firstName = person.firstName
            detailsVC.lastName = person.lastName
            detailsVC.friendID = person.personID
            if let image = person.image{
                print("not nil")
                detailsVC.friendImageView?.image = image
                print(image)
            }
            print(person.image)
            
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
//            detailsVC.pinArray = self.pinArray
//            detailsVC.userStamp = self.userStamps[indexPaths!.row]
        }
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
        cell.personImageView.backgroundColor = UIColor.white
        if let personPhoto = friends[indexPath.row].image {
            cell.personImageView.image = personPhoto
        } else {
            cell.personImageView.image = UIImage(named: "Person")
        }
        
        var name = ""
        if (friends.count != 0 && friends.count > indexPath.row){
            name = friends[indexPath.row].firstName
        }
    
        
        //3
        //cell.imageView.image = personPhoto.thumbnail
       // cell.personImageView.image = personPhoto
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


