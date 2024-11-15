//
//  User_Entity.swift
//  CoffeHouse
//
//  Created by Macbook on 11/11/24.
//

import Foundation

struct User_Entity: Codable {
    let id: Int
    let user_name: String
    let email: String
    let phone: String
    let password: String
    let address: String
    let full_path: String
    let latitude: Double
    let longitude: Double
    let isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user_name = "user_name"
        case email = "email"
        case phone = "phone"
        case password = "password"
        case address = "address"
        case full_path = "full_path"
        case latitude = "latitude"
        case longitude = "longitude"
        case isActive = "isActive"
    }
    
}
