//
//  TabBar.swift
//  CoffeHouse
//
//  Created by MacOs on 13/11/2024.
//

import Foundation
import UIKit

enum Tabbar: String {
    case home
    case favorite
    case cart
    case profile

    func icon(isSelected: Bool) -> UIImage? {
        let iconName = "ic_\(self.rawValue)_\(isSelected ? "selected" : "unselected")"
        return UIImage(named: iconName)
    }

    func name() -> String {
        return self.rawValue.capitalized
    }
}
