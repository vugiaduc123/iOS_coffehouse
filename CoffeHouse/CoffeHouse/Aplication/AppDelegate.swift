//
//  AppDelegate.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 5/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        let loginVC = LoginViewController()
        let loginNavigationVC = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = loginNavigationVC
        window?.makeKeyAndVisible()
        
        return true
    }
}


