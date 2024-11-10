//
//  ProductCart.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 10/11/24.
//

import Foundation
import UIKit

struct ProductMain: Codable{
    var id: Int
    var idCategory: Int
    var name: String
    var price: Double
    var rate: Double
    var full_path: String
    
    enum CodingKeys: String, CodingKey{
        case id = "product_id"
        case idCategory = "category_id"
        case name = "product_name"
        case price = "product_price"
        case rate
        case full_path
    }
    
}
