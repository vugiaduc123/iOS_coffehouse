//
//  CartManager.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 10/11/24.
//

import Foundation
import UIKit

class Cart{
    static var shared = Cart()
    private let file_path   = "/Users/vuduc/Desktop/Swift/IOS-LCK/iOS_coffehouse/CoffeHouse/CoffeHouse/Services/JsonLocal/Carttt.json"
    func addToCart(userId: Int, product: ProductMain, size: SizeModelMain, topping: ToppingModelMain) {
        // get data
        var arrayItem = [CartModel]()
        
        let wait = DispatchGroup()
        wait.enter()
         getDataCart(completion: { array in
            arrayItem = array
            wait.leave()
            return
        })
        
        wait.notify(queue: .main, execute: {
            do {
                if arrayItem.count == 0{
                    let itemCart = CartModel(idCart: 0, userId: userId, product: product, size: size, topping: topping)
                    arrayItem.append(itemCart)
                }else{
                    let itemCart = CartModel(idCart: arrayItem.count, userId: userId, product: product, size: size, topping: topping)
                    arrayItem.append(itemCart)
                }
                
                let Data = try? JSONEncoder().encode(arrayItem)
                let pathAsURL = URL(fileURLWithPath: self.file_path) // use save local file
                try Data?.write(to: pathAsURL)
            }catch{
                
            }
        })
    }

     func checkCart(completion: ( ([CartModel]) -> Void) ){
        let pathAsURL = URL(fileURLWithPath: file_path) // link path
        if FileManager.default.fileExists(atPath: file_path) {
            do {
                let cartData = try Data(contentsOf: pathAsURL)
                let cartArray = try! JSONDecoder().decode([CartModel].self, from: cartData)
                completion(cartArray)
            } catch {
                print(error.localizedDescription)
            }
        }else{
            print(" Does not exist file path: \(file_path)")
        }
        
    }
    
    
    func getDataCart(completion: ( ([CartModel]) -> Void) ){
       let pathAsURL = URL(fileURLWithPath: file_path) // link path
       if FileManager.default.fileExists(atPath: file_path) {
           do {
               let cartData = try Data(contentsOf: pathAsURL)
               let cartArray = try! JSONDecoder().decode([CartModel].self, from: cartData)
               completion(cartArray)
           } catch {
               print(error.localizedDescription)
           }
       }else{
           print(" Does not exist file path: \(file_path)")
       }
       
   }


}


