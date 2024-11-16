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
    private var users: [UserEntity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func btLogin(_ sender: Any) {
        loadData()
        guard let enterEmail = emailText.text,
              let enterPassword = passwordText.text,
              !enterEmail.isEmpty, !enterPassword.isEmpty else {
            lbMissInfomation.isHidden = false
            return
        }
            var isLoginSuccessful = false
                    for user in users {
                        if user.email == enterEmail && user.password == enterPassword {
                            isLoginSuccessful = true
                            lbMissInfomation.isHidden = true
                            UserDefaults.standard.set(true, forKey: "isActive")
                            if let encodedUser = try? JSONEncoder().encode(user) {
                                        UserDefaults.standard.set(encodedUser, forKey: "loggedInUser")
                                    }
                            let homeVC = HomeViewController()
                            self.navigationController?.pushViewController(homeVC, animated: true)
                            break
                        }

                    if !isLoginSuccessful {
                        lbMissInfomation.isHidden = true
                        alertLogin()
                        }
                    }
    }

    @IBAction func btRegister(_ sender: Any) {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}

// MARK: Layout - Config
extension LoginViewController{
    
    private func setupView() {
        emailText.spellCheckingType = .no
        passwordText.isSecureTextEntry = true
        lbMissInfomation.isHidden = true
    }
    
    func alertLogin() {
        let alertController = UIAlertController(title: "Wrong email or password", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - Load Jsonfile
extension LoginViewController{
    class JSONLoader {
        static func load<T: Decodable>(fileName: String, fileType: String = "json", type: T.Type) -> T? {
            guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
                print("File not found")
                return nil
            }
            do {
                let data = try Data(contentsOf: fileURL)
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                print("Error loading JSON: \(error)")
                return nil
            }
        }
    }
        private func loadData() {
            if let loadedUsers: [UserEntity] = JSONLoader.load(fileName: "User", type: [UserEntity].self) {
                self.users = loadedUsers
            } else {
                print("Failed to load user data")
            }
        }
}


