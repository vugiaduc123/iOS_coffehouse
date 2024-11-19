//
//  TrackingOrderViewController.swift
//  CoffeHouse
//
//  Created by DUONG DONG QUAN on 17/11/24.
//

import UIKit

class TrackingOrderViewController: UIViewController {
    
    @IBOutlet weak var trackingOrder: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.trackingOrder.layer.cornerRadius = 20
        self.trackingOrder.layer.masksToBounds = true
    }

}
