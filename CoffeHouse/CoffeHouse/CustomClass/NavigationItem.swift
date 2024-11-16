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
    func itemBarbtn(target: Any?, selector: Selector, sizeIcon: CGFloat) -> UIBarButtonItem {
        let moreButton = UIButton(frame: CGRect(x: 0, y: 0, width: sizeIcon, height: sizeIcon))
        moreButton.setBackgroundImage(UIImage(named: Asset.CartIcon.ic_orderNav), for: .normal)
        moreButton.addTarget(target, action: selector, for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: moreButton)
        return menuBarItem
    }
    
}

