//
//  NavigationItem.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 15/11/24.
//

import Foundation
import UIKit

class NavigationItem{
    // Configure
    func itemBarbtn(icon: String, target: Any?, selector: Selector, sizeIcon: CGFloat) -> UIBarButtonItem{
        let moreButton = UIButton(frame: CGRect(x: 0, y: 0, width: sizeIcon, height: sizeIcon))
        let image = UIImageView()
        image.image = UIImage(named: icon)
        image.contentMode = .scaleAspectFit
        moreButton.setBackgroundImage( image.image, for: .normal)
        moreButton.addTarget(target, action: selector, for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: moreButton)
        return menuBarItem
    }
    
    func itemBarbtnSystem(icon: String, color: UIColor?, target: Any?, selector: Selector, sizeIcon: CGFloat) -> UIBarButtonItem {
        let moreButton = UIButton(frame: CGRect(x: 0, y: 0, width: sizeIcon, height: sizeIcon))
        let image = UIImageView()
        image.image = UIImage(systemName: icon)?.imageWithColor(color: color != nil ? color! : .tintColor)
        moreButton.setBackgroundImage(image.image, for: .normal)
        moreButton.addTarget(target, action: selector, for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: moreButton)
        return menuBarItem
    }
    
}
