//
//  ProductManager.swift
//  CoffeHouse
//
//  Created by DUONG DONG QUAN on 17/11/24.
//

import Foundation

class ProductManager {
    static let shared = ProductManager()
    
    private init() {}
    
    func loadProductData() -> [detailProduct]? {
        // get link url of Product.json
        guard let url = Bundle.main.url(forResource: "Product", withExtension: "json") else {
            print("No found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            // Decode JSON to arrayP
            let products = try JSONDecoder().decode([detailProduct].self, from: data)
            return products
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
}
