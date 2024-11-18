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
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idProduct = try container.decode(Int.self, forKey: .idProduct)
        self.idCategory = try container.decode(Int.self, forKey: .idCategory)
        self.nameProduct = try container.decode(String.self, forKey: .nameProduct)
        self.productContent = try container.decode(String.self, forKey: .productContent)
        self.urlImage = try container.decode(String.self, forKey: .urlImage)
        self.price = try container.decode(Double.self, forKey: .price)
        self.rate = try container.decode(Double.self, forKey: .rate)
        self.isSold = try container.decode(Bool.self, forKey: .isSold)
        self.size = try container.decode([SizeModelMain].self, forKey: .size)
        self.topping = try container.decode([ToppingModelMain].self, forKey: .topping)
    }
    
}
