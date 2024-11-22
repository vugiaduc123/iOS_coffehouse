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
        // create file
        UserDataManager.shared.CheckDataBaseOnPathorNot()
        Cart.shared.CheckDataBaseOnPathorNot()
        self.window = UIWindow()
        var navigationVC = UINavigationController()
        UserDataManager.shared.userMobile { result in
            switch result{
            case .value(let user):
                print(user)
                let Cusbar = CustomTabBarController()
                self.window?.rootViewController = Cusbar
                self.window?.makeKeyAndVisible()
            case .error(_):
                let loginVC = LoginViewController()
                navigationVC = UINavigationController(rootViewController: loginVC)
                self.window?.rootViewController = navigationVC
                self.window?.makeKeyAndVisible()
            }
        }
        return true
    }
}


