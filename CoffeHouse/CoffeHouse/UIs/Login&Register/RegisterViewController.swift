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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnRegister.layer.cornerRadius = 17
        
        configTextField()
        
        updatePasswordVisibilityButton(button: btnShowPassword, isSecure: tfPassword.isSecureTextEntry)
        updatePasswordVisibilityButton(button: btnReShowPassword, isSecure: tfPassword.isSecureTextEntry)
    }
    
    @IBAction func changePasswordVisibility(_ sender: UIButton) {
        tfPassword.isSecureTextEntry.toggle()
        updatePasswordVisibilityButton(button: btnShowPassword, isSecure: tfPassword.isSecureTextEntry)
    }
    
    @IBAction func changeRePasswordVisibility(_ sender: UIButton) {
        tfRePassword.isSecureTextEntry.toggle()
        updatePasswordVisibilityButton(button: btnReShowPassword, isSecure: tfRePassword.isSecureTextEntry)
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
    }
}




