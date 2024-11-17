//
//  ProductModel.swift
//  CoffeHouse
//
//  Created by MacOs on 15/11/24.
//

import Foundation
import UIKit

struct ProductModel: Codable{
    var idProduct: Int
    var idCategory: Int
    var nameProduct: String
    var productContent: String
    var urlImage: String
    var price: Double
    var rate: Double
    var isSold: Bool
    var size : [SizeModelMain]
    var topping : [ToppingModelMain]
    
    enum CodingKeys: String, CodingKey{
        case idProduct = "id"
        case idCategory = "category_id"
        case nameProduct = "product_name"
        case productContent = "product_content"
        case urlImage = "full_path"
        case price = "price"
        case rate = "rate"
        case isSold = "isSold"
        case size = "size"
        case topping = "topping"
    }
    
}
