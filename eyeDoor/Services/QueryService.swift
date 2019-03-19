//
//  QueryService.swift
//  eyeDoor
//
//  Created by Nathan Schlechte on 2/19/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import Foundation

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
    
    static func loginUser(email: String, password: String, completion: @escaping (_ auth: Bool) -> Void) {
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
                    completion(false)
                }
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                jsonAuth = jsonResponse!["auth"] as! Bool
                let jsonToken = jsonResponse!["token"] as! String
                
                //if user is validated, assign token
                if (jsonAuth == true) {
                    let defaults = UserDefaults.standard
                    defaults.set(jsonToken, forKey: "token")
                }
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
    
    static func createPerson(firstname: String, lastname: String, image: String, completion: @escaping (_ success: Bool) -> Void){
        //var didCreate = false
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        print(token)
        
        let url = URL(string: "https://joseph-frank.com/api/friends")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        let jsonData = "firstname=\(firstname)&lastname=\(lastname)&image=\(image)".data(using: String.Encoding.ascii, allowLossyConversion: false)
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
                print("jsonResponse is \(jsonResponse)")
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
    
}

