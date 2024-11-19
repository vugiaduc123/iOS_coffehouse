//
//  RegisterViewController.swift
//  CoffeHouse
//
//  Created by Apple on 4/11/24.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var scView: UIScrollView!
    @IBOutlet weak var mView: UIView!
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRePassword: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnShowPassword: UIButton!
    @IBOutlet weak var btnReShowPassword: UIButton!
    
    @IBOutlet weak var lbErrorUserName: UILabel!
    @IBOutlet weak var lbErrorPhone: UILabel!
    @IBOutlet weak var lbErrorPassword: UILabel!
    @IBOutlet weak var lbErrorRePassword: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnRegister.layer.cornerRadius = 17
        
        config()
        
        updatePasswordVisibilityButton(button: btnShowPassword, isSecure: tfPassword.isSecureTextEntry)
        updatePasswordVisibilityButton(button: btnReShowPassword, isSecure: tfPassword.isSecureTextEntry)
    }
    
    func config() {
        configTextField()
        configErrorLabel()
    }
    
    @IBAction func changePasswordVisibility(_ sender: UIButton) {
        tfPassword.isSecureTextEntry.toggle()
        updatePasswordVisibilityButton(button: btnShowPassword, isSecure: tfPassword.isSecureTextEntry)
    }
    
    @IBAction func changeRePasswordVisibility(_ sender: UIButton) {
        tfRePassword.isSecureTextEntry.toggle()
        updatePasswordVisibilityButton(button: btnReShowPassword, isSecure: tfRePassword.isSecureTextEntry)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func registerAccount(_ sender: UIButton) {
        saveUserData()
    }
    
    //MARK: - Load user data
    private func loadUserData() -> [UserEntity]? {
        guard let fileURL = Bundle.main.url(forResource: "User", withExtension: "json") else {
            print("file not found.")
            return nil
        }
        
        do {
            let userData = try Data(contentsOf: fileURL)
            let users =  try JSONDecoder().decode([UserEntity].self, from: userData)
            return users
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    //MARK: - Save user data
    private func saveUserData() {
        if validateFields() {
            var existingUsers: [UserEntity] = []
            
            if let loadedUsers =  loadUserData() {
                existingUsers = loadedUsers
            }
            
            let maxId = existingUsers.map { $0.id }.max() ?? 0
            let newId = maxId + 1
            
            let newUser: UserEntity = .init(id: newId,
                                            name: tfUsername.text ?? "",
                                            email: "",
                                            phone: tfPhone.text ?? "",
                                            password: tfPassword.text ?? "",
                                            address: "",
                                            latitude: 0.0,
                                            longitude: 0.0,
                                            fullPath: "",
                                            isActive: false)
            if existingUsers.contains(where: { $0.phone == newUser.phone })  {
                print("phone number has already existed. Choose another.")
                lbErrorPhone.text = "This phone number has already existed"
                lbErrorPhone.isHidden = false
                return
            }
            
            existingUsers.append(newUser)
            
            let filePath = "/Users/apple/Documents/ios/iOS_coffehouse/CoffeHouse/CoffeHouse/Services/JsonLocal/User.json"
            
            do {
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .prettyPrinted
                
                let encodedUsers = try? jsonEncoder.encode(existingUsers)
                let pathAsURL = URL(fileURLWithPath: filePath)
                
                try encodedUsers?.write(to: pathAsURL)
                print("User data save successfully")
                print(pathAsURL.path)
                showAlert(on: self)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func showAlert(on viewController: UIViewController) {
        let alert = UIAlertController(title: "Success", message: "Register successfully", preferredStyle: .alert)
        
        viewController.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true) {
                let loginVC = LoginViewController()
                viewController.navigationController?.pushViewController(loginVC, animated: true)
            }
        }
    }
}

// MARK: - Check constraint textFiels
extension RegisterViewController {
    func validateFields() -> Bool {
        //username
        guard let username = tfUsername.text, !username.isEmpty else {
            lbErrorUserName.text = "Username cannot be empty"
            lbErrorUserName.isHidden = false
            return false
        }
        
        if !validateUsername(username) {
            lbErrorUserName.text = "Username must be at least 3 characters"
            lbErrorUserName.isHidden = false
            return false
        } else {
            lbErrorUserName.isHidden = true
        }
        
        //phone number
        guard let phone = tfPhone.text, !phone.isEmpty else {
            lbErrorPhone.text = "Phone cannot be empty"
            lbErrorPhone.isHidden = false
            return false
        }
        
        if !validatePhone(phone) {
            lbErrorPhone.text = "Invalid phone number"
            lbErrorPhone.isHidden = false
            return false
        } else {
            lbErrorPhone.isHidden = true
        }
        
        //password
        guard let password = tfPassword.text, !password.isEmpty else {
            lbErrorPassword.text = "Password cannot be empty"
            lbErrorPassword.isHidden = false
            return false
        }
        
        if !validatePassword(password) {
            lbErrorPassword.text = "Password minimun 5 characters"
            lbErrorPassword.isHidden = false
            return false
        } else {
            lbErrorPassword.isHidden = true
        }
        
        //confirm password
        guard let confirmPassword = tfRePassword.text, !confirmPassword.isEmpty else {
            lbErrorRePassword.text = "Confirn password cannot be empty"
            lbErrorRePassword.isHidden = false
            return false
        }
        
        if confirmPassword != password {
            lbErrorRePassword.text = "Password don't match"
            lbErrorRePassword.isHidden = false
            return false
        } else {
            lbErrorRePassword.isHidden = true
        }
        return true
    }
}

//MARK: - Update password visibility button
extension RegisterViewController {
    private func updatePasswordVisibilityButton(button: UIButton, isSecure: Bool) {
        let imageName = isSecure ? "eye.slash" : "eye"
        if let image = UIImage(systemName: imageName) {
            button.setImage(image, for: .normal)
        }
    }
}

//MARK:  - Config TextField
extension RegisterViewController {
    func configTextField() {
        self.tfUsername.layer.cornerRadius = 5
        self.tfUsername.layer.borderColor = UIColor.brown.cgColor
        self.tfUsername.layer.borderWidth = 1
        
        self.tfPhone.layer.cornerRadius = 5
        self.tfPhone.layer.borderColor = UIColor.brown.cgColor
        self.tfPhone.layer.borderWidth = 1
        
        self.tfPassword.layer.cornerRadius = 5
        self.tfPassword.layer.borderColor = UIColor.brown.cgColor
        self.tfPassword.layer.borderWidth = 1
        
        self.tfRePassword.layer.cornerRadius = 5
        self.tfRePassword.layer.borderColor = UIColor.brown.cgColor
        self.tfRePassword.layer.borderWidth = 1
        
        tfPassword.isSecureTextEntry = true
        tfRePassword.isSecureTextEntry = true
        
        tfUsername.delegate = self
        tfPhone.delegate = self
        tfPassword.delegate = self
        tfRePassword.delegate = self
    }
}

extension RegisterViewController {
    func configErrorLabel() {
        lbErrorUserName.isHidden = true
        lbErrorPhone.isHidden = true
        lbErrorPassword.isHidden = true
        lbErrorRePassword.isHidden = true
    }
}

// MARK: - Validate username, phone, password, confirm password
extension RegisterViewController {
    func validateUsername(_ username: String) -> Bool {
        let usernameRegex = "^[a-zA-Z0-9]{3,}$"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernameTest.evaluate(with: username)
    }
    
    func validatePhone(_ phone: String) -> Bool {
        let phoneRegex = "^(03|05|07|08|09|01[2|6|8|9])+([0-9]{8})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    func validatePassword(_ password: String) -> Bool {
        return password.count >= 5
    }
}

// MARK: - Textfield Delegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        //username
        if textField == tfUsername, let text = textField.text, !text.isEmpty {
            if !validateUsername(text) {
                lbErrorUserName.text  = "Username must be at least 3 characters"
                lbErrorUserName.isHidden = false
            } else {
                lbErrorUserName.isHidden = true
            }
        } else {
            lbErrorUserName.isHidden = true
        }
        
        //phone
        if textField == tfPhone, let text = textField.text, !text.isEmpty {
            if !validatePhone(text) {
                lbErrorPhone.text = "Invalid phone number"
                lbErrorPhone.isHidden = false
            } else {
                lbErrorPhone.isHidden = true
            }
        } else {
            lbErrorPhone.isHidden = true
        }
        
        //password
        if textField == tfPassword, let text = textField.text, !text.isEmpty {
            if !validatePassword(text) {
                lbErrorPassword.text = "Password minimun 5 characters"
                lbErrorPassword.isHidden = false
            } else {
                lbErrorPassword.isHidden = true
            }
        } else {
            lbErrorPassword.isHidden = true
        }
        
        //Confirm password
        if textField == tfRePassword {
            guard let text = textField.text, text == tfPassword.text else {
                lbErrorRePassword.text = "Password don't match"
                lbErrorRePassword.isHidden = false
                return
            }
            
            lbErrorRePassword.isHidden = true
        } else {
            lbErrorRePassword.isHidden = true
        }
    }
}




