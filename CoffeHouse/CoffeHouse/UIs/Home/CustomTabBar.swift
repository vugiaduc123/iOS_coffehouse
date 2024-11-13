//
//  CustomTabBar.swift
//  CoffeHouse
//
//  Created by MacOs on 13/11/2024.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    var movingView: UIView!
    var movingViewCenterXConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let homeVC = HomeViewController()
        let homeNavigationVC = UINavigationController(rootViewController: homeVC)
        let tab1 = Tabbar.home
        homeNavigationVC.tabBarItem = UITabBarItem(title: tab1.name(),
                                                   image: tab1.icon(isSelected: false),
                                                   selectedImage: tab1.icon(isSelected: true))

       

        
        self.viewControllers = [homeNavigationVC]
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .CB_8_A_58

        self.movingView = UIView()
        self.movingView.translatesAutoresizingMaskIntoConstraints = false
        self.movingView.backgroundColor = .CB_8_A_58
        self.view.addSubview(self.movingView)
        NSLayoutConstraint.activate([
            self.movingView.heightAnchor.constraint(equalToConstant: 3),
            self.movingView.widthAnchor.constraint(equalToConstant: 33),
            self.movingView.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: -10),
        ])
        self.movingViewCenterXConstraint = self.movingView.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor)
        self.movingViewCenterXConstraint.isActive = true
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            let tabBarWidth = tabBarController.tabBar.frame.width / CGFloat(tabBarController.viewControllers!.count)
            let centerX = tabBarWidth * CGFloat(selectedIndex) + tabBarWidth / 2
            self.movingViewCenterXConstraint.constant = centerX - tabBarController.tabBar.frame.width / 2
        }
    }
}

