//
//  OrderService.swift
//  CoffeHouse
//
//  Created by DUONG DONG QUAN on 15/11/24.
//

import Foundation

class OrderService {
    private let fileName = "Orders.json"
    
    // get url Order.json in bundle
    private func getFileUrl() -> URL? {
        // check file exists or not
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil, subdirectory: "Services/JsonLocal") {
            return fileURL
        } else {
            print("File not found")
            return nil
        }
    }
    // add item to Order.json
    func addOrder(newOrder: Order) {
        guard let fileURL = getFileUrl() else { return }
        
        // Read data from Order.json
        var ordersArray: [Order] = []
        if let data = try? Data(contentsOf: fileURL) {
            let decoder = JSONDecoder()
            if let jsonArray = try? decoder.decode([Order].self, from: data) {
                ordersArray = jsonArray
            }
        }
        
        // add new order to array
        ordersArray.append(newOrder)
        
        // write updated data to Order.json
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let updatedData = try? encoder.encode(ordersArray) {
            do {
                try updatedData.write(to: fileURL)
                print("Add new order to Order.json successfully")
            } catch {
                print("Error writing data to file")
            }
        } else {
            print("Error encoding data")
        }
    }
}

