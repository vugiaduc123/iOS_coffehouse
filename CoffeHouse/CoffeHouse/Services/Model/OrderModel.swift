//
//  OrderModel.swift
//  CoffeHouse
//
//  Created by DUONG DONG QUAN on 15/11/24.
//

import Foundation

struct Order: Codable {
    var order_id: Int
    var product: Product
    var size: [Size]
    var topping: [Topping]
    var user_id: Int
    var status: Int
    var address: String
    var payment_method: Int
}

struct Product: Codable {
    var id: Int
    var product_name: String
    var ori_price: Double
    var full_path: String
}

struct Size: Codable {
    var id: Int
    var name_size: String
    var price_size: Double
}

struct Topping: Codable {
    var id: Int
    var name_topping: String
    var price_topping: Double
}
