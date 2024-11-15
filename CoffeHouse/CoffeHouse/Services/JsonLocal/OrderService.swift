//
//  OrderService.swift
//  CoffeHouse
//
//  Created by DUONG DONG QUAN on 15/11/24.
//

import Foundation

class OrderService {
    // tên file json
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
    func addOrder(newOrder: [String: Any]) {
        guard let fileURL = getFileUrl() else { return }
        
        // read data from Order.json
        var ordersArray: [[String: Any]] = []
        if let data = try? Data(contentsOf: fileURL),
           let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
            ordersArray = jsonArray
        }
        
        // add new order to array
        ordersArray.append(newOrder)
        
        // write updated data to Order.json
        if let updatedData = try? JSONSerialization.data(withJSONObject: ordersArray, options: .prettyPrinted) {
            do {
                try updatedData.write(to: fileURL)
                print("Add new order to Order.json successfully")
            } catch {
                print("Error")
            }
        } else {
            print("Error converting data")
        }
    }
    
    
}
