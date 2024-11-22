//
//  ProfileViewController.swift
//  CoffeHouse
//
//  Created by Macbook on 14/11/24.
//

import UIKit

class ProfileViewController: UIViewController {
    var loggedInUser: UserEntity?
    

    @IBOutlet weak var lbCart: UIButton!
    @IBOutlet weak var usernameLb: UITextField!
    @IBOutlet weak var phonenumberLb: UITextField!
    @IBOutlet weak var addressLb: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        loadUser()
    }
    
    @IBAction func logOutBt(_ sender: Any) {
        showAlertLogOut(on: self)
    }
    @IBAction func updatePhone(_ sender: Any) {
        updateInfo(name: loggedInUser!.name, phone: phonenumberLb.text ?? "", Address: loggedInUser?.address ?? "Chưa có")
    }
    
    @IBAction func updateAddress(_ sender: Any) {
        updateInfo(name: loggedInUser!.name , phone: loggedInUser!.phone, Address: addressLb?.text ?? "Chưa có")
    }
    
    
    @IBAction func updateName(_ sender: Any) {
        updateInfo(name: usernameLb.text ?? "", phone: loggedInUser!.phone, Address: loggedInUser?.address ?? "Chưa có")
    }
    
    @IBAction func goCart(_ sender: Any) {
    }
    
}


extension ProfileViewController{
    func config(){
        lbCart.titleLabel?.font = FontFamily.Montserrat.regular.font(size: 14)
        usernameLb.font = FontFamily.Montserrat.bold.font(size: 17)
        phonenumberLb.font = FontFamily.Montserrat.regular.font(size: 14)
        addressLb.font = FontFamily.Montserrat.regular.font(size: 14)
    }
}

extension ProfileViewController{
    func loadUser(){
        if let userData = UserDefaults.standard.data(forKey: "loggedInUser"),
           let user = try? JSONDecoder().decode(UserEntity.self, from: userData) {
            self.loggedInUser = user
        }
        if let user = loggedInUser {
            usernameLb.text = user.name
            phonenumberLb.text = user.phone
            if user.address != "" {
                addressLb.text = user.address
            }else{
                addressLb.text = "Cật nhật"
            }
        }
    }
    
    func updateInfo(name: String, phone: String, Address: String){
        let name = name
        let phone = phone
        let address = Address
        if name.count == 0 {
            showAlertFail(faileString: "Họ tên đầy đủ", on: self)
            return
        }
        
        if phone.count == 0 {
            showAlertFail(faileString: "SĐT", on: self)
            return
        }
        
        if phone.count < 9 {
            showAlertFail(faileString: "hơn 10 số", on: self)
            return
        }
        
        if address.count == 0 {
            showAlertFail(faileString: "địa chỉ", on: self)
            return
        }
        UserDataManager.shared.updateUser(phone: phone, name: name, email: "", address: address, completion: { result in
            if result {
                showAlertSuccess(on: self)
            }else{
                showAlertFailUpdate(on: self)
            }
        })
    }
    
}

extension ProfileViewController{
    private func showAlertLogOut(on viewController: UIViewController) {
        let alert = UIAlertController(title: "Đăng xuất", message: "Bạn có chắc muốn đăng xuất?", preferredStyle: .alert)
        viewController.present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "Huỷ", style: .destructive))
        alert.addAction(UIAlertAction(title: "Có", style: .cancel, handler: { _ in
            UserDataManager.shared.removeUser { result in}
            let loginVC = LoginViewController()
            let naviController = UINavigationController(rootViewController: loginVC)
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController = naviController
                appDelegate.window?.makeKeyAndVisible()
            }
        }))
    }
    
    private func showAlertSuccess(on viewController: UIViewController) {
        let alert = UIAlertController(title: "Cật nhật thành công", message: "", preferredStyle: .alert)
        viewController.present(alert, animated: true)
        alert.dismiss(animated: true)
    }
    
    private func showAlertFailUpdate(on viewController: UIViewController) {
        let alert = UIAlertController(title: "Cật nhật thất bại", message: "", preferredStyle: .alert)
        viewController.present(alert, animated: true)
        alert.dismiss(animated: true)
    }
    
    private func showAlertFail(faileString: String,on viewController: UIViewController) {
        let alert = UIAlertController(title: "Vui lòng điền \(faileString)", message: "", preferredStyle: .alert)
        viewController.present(alert, animated: true)
        alert.dismiss(animated: true)
    }
}

