//
//  ProfileViewController.swift
//  CoffeHouse
//
//  Created by Macbook on 14/11/24.
//

import UIKit

class ProfileViewController: UIViewController {
    var loggedInUser: UserEntity?
    
    @IBOutlet weak var usernameLb: UILabel!
    @IBOutlet weak var phonenumberLb: UILabel!
    @IBOutlet weak var addressLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userData = UserDefaults.standard.data(forKey: "loggedInUser"),
                   let user = try? JSONDecoder().decode(UserEntity.self, from: userData) {
                    self.loggedInUser = user
                }
        if let user = loggedInUser {
            usernameLb.text = user.name
            phonenumberLb.text = user.phone
            addressLb.text = user.address
            }
    }
    
    @IBAction func logOutBt(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isActive")
        let loginVC = LoginViewController()
        let naviController = UINavigationController(rootViewController: loginVC)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = naviController
            appDelegate.window?.makeKeyAndVisible()
        }
    }
}



