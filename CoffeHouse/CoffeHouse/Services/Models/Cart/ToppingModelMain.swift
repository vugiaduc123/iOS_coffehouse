//
//  ToppingModel.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 10/11/24.
//

import Foundation
import UIKit

struct ToppingModelMain: Codable{
    var idTopping: Int
    var name: String
    var amount: Int
    var price: Double
    
    enum CodingKeys: String, CodingKey {
        case idTopping = "id"
        case amount = "amount"
        case name = "name_topping"
        case price = "price_topping"
    }
}


