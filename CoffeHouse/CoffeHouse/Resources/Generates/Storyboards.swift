//
//  Storyboards.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 4/11/24.
//

import Foundation
import UIKit

// Storyboard Indentifier
enum Storyboard {
    
     enum Login{
         static var loginVC = LoginViewController()
         static var registerVC = RegisterViewController()
     }
    
    enum Home{
        static var homeVC = HomeViewController()
    }
    
    enum Favourite{
        static var favourite = FavouriteViewController()
        
    }
    
    enum Cart{
        
    }
    
    enum Profile{
        
    }
    
}


