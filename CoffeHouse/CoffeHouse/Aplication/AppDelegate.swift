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
        window = UIWindow()
        let view = Storyboard.Login.registerVC
        let navigationVC = UINavigationController(rootViewController: view)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        print("Register Layout")
        return true
    }




}

