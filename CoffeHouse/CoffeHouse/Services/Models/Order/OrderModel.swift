//
//  OrderModel.swift
//  CoffeHouse
//
//  Created by DUONG DONG QUAN on 15/11/24.
//

import Foundation

struct Order: Codable {
    var order_id: Int
    var product: Product_Order
    var size: [Size_Order]
    var topping: [Topping_Order]
    var user_id: Int
    var status: Int
    var address: String
    var payment_method: Int
}

struct Product_Order: Codable {
    var id: Int
    var product_name: String
    var ori_price: Double
    var full_path: String
}

struct Size_Order: Codable {
    var id: Int
    var name_size: String
    var price_size: Double
}

struct Topping_Order: Codable {
    var id: Int
    var name_topping: String
    var price_topping: Double
    var amount:Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name_topping = "name_topping"
        case price_topping = "price_topping"

    }
}
