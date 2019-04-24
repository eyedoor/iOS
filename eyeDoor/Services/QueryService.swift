//
//  QueryService.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 2/19/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import UIKit
import CoreData

class QueryService {
    
    static func createUser(email: String, password: String, firstname: String, lastname: String, completion: @escaping (_ auth: Bool) -> Void){
        //var didCreate = false
        let url = URL(string: "https://joseph-frank.com/api/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json: [String:Any] = [
            "email" : email,
            "password" : password,
            "firstname" : firstname,
            "lastname" : lastname
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async{
                    completion(false)
                }
                return
            }
            
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            DispatchQueue.main.async{
                completion(true)
            }
           // didCreate = true
        }
        task.resume()
        
        //print(didCreate)
        return
    }
    
    static func loginUser(email: String, password: String, completion: @escaping (_ auth: Bool, _ newUser: User) -> Void) {
        var jsonAuth = false
        
    
        let url = URL(string: "https://joseph-frank.com/api/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json: [String:Any] = [
            "email" : email,
            "password" : password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("beginning of task")
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async{
                    completion(false, User())
                }
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: [])
                //print("jsonResponse is \(jsonResponse)")
                guard let jsonArray = jsonResponse as? [String: Any] else {
                    return
                }
                
                let currentUser = User(jsonArray)
                
                jsonAuth = currentUser.auth
                let jsonToken = currentUser.token
                
                if (jsonAuth == true) {
                    let defaults = UserDefaults.standard
                    defaults.set(jsonToken, forKey: "token")
                    
                    print(currentUser)
                }
                
                DispatchQueue.main.async{
                    completion(jsonAuth, currentUser)
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
            
//            let responseString = String(data: data, encoding: .utf8)
//
//            do {
//                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
//                jsonAuth = jsonResponse!["auth"] as! Bool
//                let jsonToken = jsonResponse!["token"] as! String
//
//                //if user is validated, assign token
//                if (jsonAuth == true) {
//                    let defaults = UserDefaults.standard
//                    defaults.set(jsonToken, forKey: "token")
//                }
//                print("responseString = \(responseString)")
//                print(jsonAuth)
//                DispatchQueue.main.async{
//                    completion(jsonAuth)
//                }
//            } catch {
//                return
//            }
        }
        task.resume()
    }
    
    static func createPerson(firstname: String, lastname: String, image: String, completion: @escaping (_ success: Bool) -> Void){
        //var didCreate = false
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        print(token)
        
        let url = URL(string: "https://joseph-frank.com/api/friends")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        let json: [String: Any] = ["firstname":firstname, "lastname":lastname, "image":image]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async{
                    completion(false)
                }
                return
            }
            
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            DispatchQueue.main.async{
                completion(true)
            }
            // didCreate = true
        }
        task.resume()
        
        //print(didCreate)
        return
    }
    
    static func getFriendNames(completion: @escaping (_ friends: Array<Any>) -> Void){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        
        let url = URL(string: "https://joseph-frank.com/api/friends")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        
        var friends = [Person]()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: [])
                //print("jsonResponse is \(jsonResponse)")
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                
                for dic in jsonArray {
                    friends.append(Person(dic))
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
            DispatchQueue.main.async{
                completion(friends)
            }
        }
        task.resume()
        return
    }
    
    static func getFriendImage(friendID: Int, completion: @escaping (_ base64Image: String) -> Void){
        //var didCreate = false
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        print("friend ID is \(friendID)")
        
        var url = URLComponents(string: "https://joseph-frank.com/api/friendImage")!
        url.queryItems = [
            URLQueryItem(name: "friendId", value: "\(friendID)")
        ]
       
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        request.setValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "x-access-token")
  
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(responseString)")
            DispatchQueue.main.async{
                completion(responseString!)
            }
        }
        task.resume()
        
        return
    }
    
    static func getEvents(completion: @escaping (_ events: Array<Any>) -> Void){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        
        let url = URL(string: "https://joseph-frank.com/api/events")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var events = [Event]()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: [])
                print("jsonResponse is \(jsonResponse)")
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                
                for dic in jsonArray {
                    events.append(Event(dic))
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
            DispatchQueue.main.async{
                completion(events)
            }
        }
        task.resume()
        return
    }
    
    static func getEventImage(eventID: Int, completion: @escaping (_ base64Image: String) -> Void){
        //var didCreate = false
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        print("friend ID is \(eventID)")
        
        var url = URLComponents(string: "https://joseph-frank.com/api/images")!
        url.queryItems = [
            URLQueryItem(name: "eventId", value: "\(eventID)")
        ]
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        request.setValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(responseString)")
            DispatchQueue.main.async{
                completion(responseString!)
            }
        }
        task.resume()
        
        return
    }
    
    static func verifyUser(completion: @escaping (_ auth: Bool) -> Void) {
        var jsonAuth = false
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        
        let url = URL(string: "https://joseph-frank.com/api/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("beginning of task")
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async{
                    completion(false)
                }
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                jsonAuth = jsonResponse!["auth"] as! Bool
            
                print("responseString = \(responseString)")
                print(jsonAuth)
                DispatchQueue.main.async{
                    completion(jsonAuth)
                }
            } catch {
                return
            }
        }
        task.resume()
    }
    
    static func getFriendEvents(friendID: Int, completion: @escaping (_ events: Array<Any>) -> Void){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        
        var url = URLComponents(string: "https://joseph-frank.com/api/friends/events")!
        url.queryItems = [
            URLQueryItem(name: "friendId", value: "\(friendID)")
        ]
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var events = [Event]()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: [])
                print("jsonResponse is \(jsonResponse)")
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                
                for dic in jsonArray {
                    events.append(Event(dic))
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
            DispatchQueue.main.async{
                completion(events)
            }
        }
        task.resume()
        return
    }
    
    static func deleteFriend(friendID: Int, completion: @escaping (_ success: Bool) -> Void) {
        var jsonAuth = false
        
        //let url = URL(string: "https://joseph-frank.com/api/friends")!
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        
        var url = URLComponents(string: "https://joseph-frank.com/api/friends")!
        url.queryItems = [
            URLQueryItem(name: "friendId", value: "\(friendID)")
        ]
        var request = URLRequest(url: url.url!)
        request.httpMethod = "DELETE"
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("beginning of task")
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async{
                    completion(false)
                }
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print(responseString)
            completion(true)
//            do {
//                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
//                jsonAuth = jsonResponse!["auth"] as! Bool
//                let jsonToken = jsonResponse!["token"] as! String
//
//                //if user is validated, assign token
//                if (jsonAuth == true) {
//                    let defaults = UserDefaults.standard
//                    defaults.set(jsonToken, forKey: "token")
//                }
//                print("responseString = \(responseString)")
//                print(jsonAuth)
//                DispatchQueue.main.async{
//                    completion(jsonAuth)
//                }
//            } catch {
//                return
//            }
        }
        task.resume()
    }
    
}

