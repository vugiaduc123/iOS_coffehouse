//
//  CartModel.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 10/11/24.
//

import Foundation
import UIKit

struct CartModel: Codable{
    var idCart: Int
    var userId: Int
    var amount: Int
    var total: Double
    var product : ProductMain
    var size: SizeModelMain? = nil
    var topping: [ToppingModelMain] = []
    
    init(idCart: Int, userId: Int, amount: Int, total: Double, product: ProductMain, size: SizeModelMain?, topping: [ToppingModelMain] ) {
        self.idCart = idCart
        self.userId = userId
        self.amount = amount
        self.total = total
        self.product = product
        self.size = size
        self.topping = topping
    }
    
    enum CodingKeys: String, CodingKey {
        case idCart = "cart_id"
        case userId = "user_id"
        case amount = "amount"
        case total = "total_price"
        case product = "product"
        case size = "size"
        case topping = "topping"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idCart = try container.decode(Int.self, forKey: .idCart)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.total = try container.decode(Double.self, forKey: .total)
        self.product = try container.decode(ProductMain.self, forKey: .product)
        self.size = try? container.decode(SizeModelMain.self, forKey: .size)
        self.topping = try! container.decode([ToppingModelMain].self, forKey: .topping)
    }
    
}



