//
//  AppDelegate.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 1/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let loginVC = Storyboard.Login.registerVC
        let navigationVC = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        
        return true
    }
    


}

