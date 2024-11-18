//
//  OrderDetailViewController.swift
//  CoffeHouse
//
//  Created by DUONG DONG QUAN on 17/11/24.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    @IBOutlet weak var orderConfirmed: UIView!
    
    @IBOutlet weak var orderProcessed: UIView!
    
    @IBOutlet weak var onDelivery: UIView!
    
    @IBOutlet weak var orderCompleted: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //config radius
        self.orderConfirmed.layer.cornerRadius = 10
        self.orderConfirmed.layer.masksToBounds = true
        self.orderConfirmed.layer.borderWidth = 0.7
        
        self.orderProcessed.layer.cornerRadius = 10
        self.orderProcessed.layer.masksToBounds = true
        self.orderProcessed.layer.borderWidth = 0.7
        
        self.onDelivery.layer.cornerRadius = 10
        self.onDelivery.layer.masksToBounds = true
        self.onDelivery.layer.borderWidth = 0.7
        
        self.orderCompleted.layer.cornerRadius = 10
        self.orderCompleted.layer.masksToBounds = true
        self.orderCompleted.layer.borderWidth = 0.7
        
    }

}
