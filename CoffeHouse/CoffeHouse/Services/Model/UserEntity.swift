//
//  UserEntity.swift
//  CoffeHouse
//
//  Created by Apple on 10/11/24.
//

import Foundation

struct UserEntity: Codable {
    let id: Int
    let name: String
    let phone: String
    let password: String
    let address: String
    let latitude: Double
    let longitude: Double
    let fullPath: String
    let isActive: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name = "user_name"
        case phone
        case password
        case address
        case latitude
        case longitude
        case fullPath = "full_path"
        case isActive
    }
    
    init(id: Int, name: String, phone: String, password: String, address: String, latitude: Double, longitude: Double, fullPath: String, isActive: Bool) {
        self.id = id
        self.name = name
        self.phone = phone
        self.password = password
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.fullPath = fullPath
        self.isActive = isActive
    }
}
