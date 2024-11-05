//
//  LoginViewController.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 4/11/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func btLogin(_ sender: Any) {
        if username.text == "admin1" && password.text == "123"{
            print("Đăng nhập thành công")
        } else {
            print("Đăng nhập thất bại")
        }
    }
    
}

// MARK Layout - Config
extension LoginViewController{
    
    }


// MARK Method
extension LoginViewController{
    
}

// MARK Protocol
extension LoginViewController{
    
}
