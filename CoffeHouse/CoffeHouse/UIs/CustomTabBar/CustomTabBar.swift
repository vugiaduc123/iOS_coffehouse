//
//  CustomTabBar.swift
//  CoffeHouse
//
//  Created by MacOs on 13/11/2024.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    var movingViewCenterXConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setUpTabBar()
    }
    // UITabBarControllerDelegate method
    func setUpTabBar() {
        let homeVC = HomeViewController()
        let homeNavigationVC = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_home_unselected"), selectedImage: UIImage(named: "ic_home_selected"))
        
        let favourtieVC = FavouriteViewController()
        let favourtieNavigationVC = UINavigationController(rootViewController: favourtieVC)
        favourtieVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_favorite_unselected"), selectedImage: UIImage(named: "ic_favorite_selected"))
        
        let cartVC = CartViewController()
        let cartNavigationVC = UINavigationController(rootViewController: cartVC)
        cartVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_cart_unselected"), selectedImage: UIImage(named: "ic_cart_selected"))
        
        let profileVC = ProfileViewController()
        let profileNavigationVC = UINavigationController(rootViewController: profileVC)
            profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_profile_unselected"), selectedImage: UIImage(named: "ic_profile_selected"))
        
        self.viewControllers = [homeNavigationVC, favourtieNavigationVC, cartNavigationVC, profileNavigationVC]
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .colorCustomBrown
        setUpMovingView()
    }
    func setUpMovingView() {
        let movingView = UIView()
        movingView.translatesAutoresizingMaskIntoConstraints = false
        movingView.backgroundColor = .colorCustomBrown
        self.view.addSubview(movingView)
        NSLayoutConstraint.activate([
            movingView.heightAnchor.constraint(equalToConstant: 3),
            movingView.widthAnchor.constraint(equalToConstant: 33),
            movingView.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: -10),
        ])
        self.movingViewCenterXConstraint = movingView.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor)
        self.movingViewCenterXConstraint.isActive = true
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            let tabBarWidth = tabBarController.tabBar.frame.width / CGFloat(tabBarController.viewControllers!.count)
            let centerX = tabBarWidth * CGFloat(selectedIndex) + tabBarWidth / 2
            self.movingViewCenterXConstraint.constant = centerX - tabBarController.tabBar.frame.width / 2
        }
    }
}
