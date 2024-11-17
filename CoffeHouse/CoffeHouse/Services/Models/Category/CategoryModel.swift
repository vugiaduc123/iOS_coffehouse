//
//  CategoryModel.swift
//  CoffeHouse
//
//  Created by MacOs on 15/11/24.
//

import Foundation
import UIKit

struct CategoryModel: Codable{
    var idCategory: Int
    var name: String
    var urlImage : String
    
    enum CodingKeys: String, CodingKey {
        case idCategory = "id"
        case name = "name"
        case urlImage = "full_path"
    }
}
