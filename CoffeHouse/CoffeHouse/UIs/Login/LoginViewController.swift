//
//  LoginViewController.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 4/11/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var lbMissInfomation: UILabel!
    private var users: [User_Entity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordText.isSecureTextEntry = true
        lbMissInfomation.isHidden = true
        
    }
    
    
    
    @IBAction func btLogin(_ sender: Any) {
        loadData()
        guard let enterEmail = emailText.text,
              let enterPassword = passwordText.text,
              !enterEmail.isEmpty, !enterPassword.isEmpty else {
            lbMissInfomation.isHidden = false
            return
        }
        do {
            var isLoginSuccessful = false
                    for user in users {
                        if user.email == enterEmail && user.password == enterPassword {
                            isLoginSuccessful = true
                            lbMissInfomation.isHidden = true
                            UserDefaults.standard.set(true, forKey: "isActive")
                            let homeVC = HomeViewController()
                            self.navigationController?.pushViewController(homeVC, animated: true)
                            break
                        }
                    }
                    
                    if !isLoginSuccessful {
                        lbMissInfomation.isHidden = true
                        wrongNotificationLogin()
                    }
            }
    }

    @IBAction func btRegister(_ sender: Any) {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}

// MARK Layout - Config
extension LoginViewController{
    
    func wrongNotificationLogin() {
        let wrongNotificationController = UIAlertController(title: "Wrong email or password", message: "", preferredStyle: .alert)
        wrongNotificationController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(wrongNotificationController, animated: true, completion: nil)
    }
}


// MARK Method
extension LoginViewController{
    
}

// MARK Protocol
extension LoginViewController{
    private func loadData(){
        guard let fileURL = Bundle.main.url(forResource: "User", withExtension: "json") else {
            print("File not found")
            return
        }
        do {
            let userData = try Data(contentsOf: fileURL)
            self.users = try JSONDecoder().decode([User_Entity].self, from: userData)
        } catch {
            print(String(describing: error))
        }
    }
}
