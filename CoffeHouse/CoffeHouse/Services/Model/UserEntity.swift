//
//  UserEntity.swift
//  CoffeHouse
//
//  Created by Apple on 10/11/24.
//

import Foundation

struct UserEntity: Codable {
    let id: Int
    var name: String
    var email: String
    var phone: String
    var password: String
    var address: String
    var latitude: Double
    var longitude: Double
    var fullPath: String
    var isActive: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name = "user_name"
        case email
        case phone
        case password
        case address
        case latitude
        case longitude
        case fullPath = "full_path"
        case isActive
    }
    
    init(id: Int, name: String, email: String, phone: String, password: String, address: String, latitude: Double, longitude: Double, fullPath: String, isActive: Bool) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.password = password
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.fullPath = fullPath
        self.isActive = isActive
    }
}
