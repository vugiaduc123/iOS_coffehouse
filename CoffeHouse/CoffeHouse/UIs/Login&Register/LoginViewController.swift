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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadListUser()
    }
    @IBAction func btLogin(_ sender: Any) {
        guard let enterPhone = emailText.text,
              let enterPassword = passwordText.text,
              !enterPhone.isEmpty, !enterPassword.isEmpty else {
            lbMissInfomation.isHidden = false
            return
        }
        if let user = users.first(where: { $0.phone == enterPhone && $0.password == enterPassword }) {
            lbMissInfomation.isHidden = true
            UserDefaults.standard.set(true, forKey: "isActive")
            if let encodedUser = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(encodedUser, forKey: "loggedInUser")
            }
            let tabBarController = CustomTabBarController()
//            self.navigationController?.setViewControllers([tabBarController], animated: true)
            tabBarController.modalTransitionStyle = .crossDissolve
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: false)
        }
        
        else {
            lbMissInfomation.isHidden = true
            alertLogin()
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
        let alertController = UIAlertController(title: "Wrong Phone or password", message: "", preferredStyle: .alert)
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
    
    private func loadListUser() {
        UserDataManager.shared.getListUser { listUser in
            self.users = listUser
            print("user===>\(users)")
            return
        }
    }
}
//aaaaa

