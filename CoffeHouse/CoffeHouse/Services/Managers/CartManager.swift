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
    
    private var file_path = ""
    
    func CheckDataBaseOnPathorNot() {
        // coppy file json bundle to documentation
            let bundlePath = Bundle.main.path(forResource: "Cart", ofType: ".json")
            print(bundlePath ?? "", "\n") //prints the correct path
            let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let fileManager = FileManager.default
            let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent("Cart.json")
            let fullDestPathString = fullDestPath!.path
            print(fileManager.fileExists(atPath: bundlePath!)) // prints true
            if fileManager.fileExists(atPath: fullDestPathString) {
                print("File is available \(fullDestPathString)")
                file_path = fullDestPathString
            }else{
                do{
                    file_path = fullDestPathString
                    try fileManager.copyItem(atPath: bundlePath!, toPath: fullDestPathString)
                }catch{
                    print("\n")
                    print(error)

                }
            }

        }
    
    func addToCart(userId: Int, product: ProductMain, size: SizeModelMain?, toppings: [ToppingCart]? ) {
        // get data
        var arrayItem = [CartModel]()
        let totalPrice = calculatedPrice(product: product, size: size, toppings: toppings)
        
        let wait = DispatchGroup()
        wait.enter()
         getDataCart(completion: { array in
            arrayItem = array
            wait.leave()
        })
        
            wait.notify(queue: .main, execute: { [self] in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    do {
                        if arrayItem.count == 0{
                            let itemCart = CartModel(idCart: 0, userId: userId, amount: 1, total: totalPrice, product: product, size: size != nil ? size : nil, topping: toppings != nil ? toppings! : [] )
                            arrayItem.append(itemCart)
                        }else{
                            let itemCart = CartModel(idCart: arrayItem.count, userId: userId, amount: 1, total: totalPrice, product: product, size: size != nil ? size! : nil, topping: toppings != nil ? toppings! : [] )
                            arrayItem.append(itemCart)
                        }
                        
                        let Data = try? JSONEncoder().encode(arrayItem)
                        let pathAsURL = URL(fileURLWithPath: self.file_path) // use save local file
                        
                        try Data?.write(to: pathAsURL)
                    }catch{
                        print("404 Add item to cart!!!")
                    }
                    
                })
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
    
    
    func getDataCart(completion: ( ([CartModel]) -> Void) ) {
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

    
    func calculatedPrice(product: ProductMain, size: SizeModelMain?, toppings: [ToppingCart]? ) -> Double{
        
        var total = 0.0
        
        total += product.price

        if size != nil {
            total += size!.price
        }
        
        if toppings != nil {
            if toppings!.count != 0 {
                total += toppings!.map( { $0.price * Double($0.amount) } ).reduce( 0, +)
            }
        }
       
        
        return total
    }

}

