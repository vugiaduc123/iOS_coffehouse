//
//  SizeModel.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 10/11/24.
//

import Foundation
import UIKit

struct SizeModelMain: Codable{
    var idSize: Int
    var name: String
    var price: Double
    
    enum CodingKeys: String, CodingKey {
        case idSize = "id"
        case name = "name_size"
        case price = "price_size"
    }
}
