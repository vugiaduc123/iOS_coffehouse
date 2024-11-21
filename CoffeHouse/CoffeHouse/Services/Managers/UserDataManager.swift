//
//  UserDataManager.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 21/11/24.
//

import Foundation
import UIKit

struct UserDataManager{
    enum Result{
        case value( UserEntity )
        case error (String)
    }
    
    let userKet = "loggedInUser"
    
    func userMobile(completion: @escaping( ( Result ) -> Void) ) {
        if let userData = UserDefaults.standard.data(forKey: userKet), let user = try? JSONDecoder().decode(UserEntity.self, from: userData) {
            completion(.value(user))
        }else{
            completion(.error("error getting data. Please log in again"))
        }
    }
    
    func removeUser(completion: ( (Bool) -> Void ) ) -> String {
        var console = ""
        if let userData = UserDefaults.standard.data(forKey: userKet), let user = try? JSONDecoder().decode(UserEntity.self, from: userData) {
            UserDefaults.standard.removeObject(forKey: userKet)
            console = "Success remove User"
            return console
        }else{
            console = "False remove User. Because It's not have user in local!"
            return console
        }
    }
}
