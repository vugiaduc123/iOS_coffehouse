//
//  ToppingCellCollectionViewCell.swift
//  CoffeHouse
//
//  Created by DUONG DONG QUAN on 21/11/24.
//

import UIKit

class ToppingCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var toppingNameLabel: UILabel!
    @IBOutlet weak var toppingPriceLabel: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configure(with topping: Topping_Order) {
        toppingNameLabel.text = topping.name_topping
        toppingPriceLabel.text = "\(topping.price_topping)$"
    }
}
