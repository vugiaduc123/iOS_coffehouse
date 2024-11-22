//
//  UserDataManager.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 21/11/24.
//

import Foundation
import UIKit

class UserDataManager{
    static var shared = UserDataManager()
    enum Result{
        case value( UserEntity )
        case error (String)
    }
    let userKey = "loggedInUser"
    private var file_path = ""
    
    func loadUser() -> [UserEntity]?{
        let pathAsURL = URL(fileURLWithPath: file_path) // link path
        if FileManager.default.fileExists(atPath: file_path) {
            do {
                let cartData = try Data(contentsOf: pathAsURL)
                let cartArray = try! JSONDecoder().decode([UserEntity].self, from: cartData)
                return cartArray
                
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }else{
            print(" Does not exist file path: \(file_path)")
            return nil
        }
        
    }
    
    func getListUser(completion: ( ([UserEntity]) -> Void) ) {
        let pathAsURL = URL(fileURLWithPath: file_path) // link path
        if FileManager.default.fileExists(atPath: file_path) {
            do {
                let cartData = try Data(contentsOf: pathAsURL)
                let cartArray = try! JSONDecoder().decode([UserEntity].self, from: cartData)
                completion(cartArray)
            } catch {
                print(error.localizedDescription)
            }
        }else{
            print(" Does not exist file path: \(file_path)")
        }
        
    }
    
    func userMobile(completion: @escaping( ( Result ) -> Void) ) {
        if let userData = UserDefaults.standard.data(forKey: userKey), let user = try? JSONDecoder().decode(UserEntity.self, from: userData) {
            completion(.value(user))
        }else{
            completion(.error("error getting data. Please log in again"))
        }
    }
    
    func removeUser(completion: ( (Bool) -> Void ) ) {
        var console = ""
        if let userData = UserDefaults.standard.data(forKey: userKey) {
            UserDefaults.standard.removeObject(forKey: userKey)
            console = "Success remove User"
        }else{
            console = "False remove User. Because It's not have user in local!"
        }
    }
    
    func CheckDataBaseOnPathorNot() {
        // coppy file json bundle to documentation
        let bundlePath = Bundle.main.path(forResource: "User", ofType: ".json")
        print(bundlePath ?? "", "\n") //prints the correct path
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent("User.json")
        let fullDestPathString = fullDestPath!.path
        print(fileManager.fileExists(atPath: bundlePath!)) // prints true
        if fileManager.fileExists(atPath: fullDestPathString) {
            print("File is available \(fullDestPathString)")
            file_path = fullDestPathString
        }else{
            do{
                file_path = fullDestPathString
                try fileManager.copyItem(atPath: bundlePath!, toPath: fullDestPathString)
            }catch{
                print("\n")
                print(error)
                
            }
        }
        
    }
    
    func addUserToFileUser(user: UserEntity, completion: ( (Bool) -> Void )) {
        // get data
        var arrayItem:[UserEntity] = []
        getListUser(completion: { array in
            arrayItem = array
        })
        do {
            if arrayItem.count == 0{
                let user = UserEntity(id: 0, name: user.name, email: user.email, phone: user.phone, password: user.password, address: "", latitude: 0.0, longitude: 0.0, fullPath: "", isActive: false)
                arrayItem.append(user)
            }else{
                let user = UserEntity(id: arrayItem.count, name: user.name, email: user.email, phone: user.phone, password: user.password, address: "", latitude: 0.0, longitude: 0.0, fullPath: "", isActive: false)
                arrayItem.append(user)
            }
            
            let Data = try? JSONEncoder().encode(arrayItem)
            let pathAsURL = URL(fileURLWithPath: self.file_path) // use save local file
            try Data?.write(to: pathAsURL)
            completion(true)
        }catch{
            print("404 Add User to Json!!!")
            completion(false)
        }
        
    }
    
    func filterUser(phone: String, name: String, email:String, address: String, completion: ( (Bool) -> Void )) {
        // get data
        var arrayItem:[UserEntity] = []
        getListUser(completion: { array in
            arrayItem = array
        })
        do {
            if let userData = UserDefaults.standard.data(forKey: "loggedInUser"),
               let user = try? JSONDecoder().decode(UserEntity.self, from: userData) {
                for i in arrayItem.indices{
                    if arrayItem[i].id == user.id{
                        arrayItem[i].name = name
                        arrayItem[i].phone = phone
                        arrayItem[i].email = email
                        arrayItem[i].address = address
                        if let encodedUser = try? JSONEncoder().encode(arrayItem[i]) {
                            UserDefaults.standard.set(encodedUser, forKey: "loggedInUser")
                        }

                    }
                }
            }
            let Data = try? JSONEncoder().encode(arrayItem)
            let pathAsURL = URL(fileURLWithPath: self.file_path) // use save local file
            try Data?.write(to: pathAsURL)
            completion(true)
        }catch{
            print("404 Add User to Json!!!")
            completion(false)
        }
        
    }
    
    func updateUser(phone: String, name: String, email:String, address:String, completion: ( (Bool) -> Void ) ) {
        filterUser(phone: phone, name: name, email: email, address: address) { result in
            completion(result)
        }
    }
    
}
