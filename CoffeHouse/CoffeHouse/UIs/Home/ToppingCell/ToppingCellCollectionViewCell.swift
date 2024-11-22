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
    var amount:Int = 0
    var changeAmount: ( (Int) -> Void )?
    override func awakeFromNib() {
        super.awakeFromNib()
        count.text = amount.description
        decreaseButton.layer.cornerRadius = decreaseButton.frame.height / 2
        decreaseButton.layer.masksToBounds = true
        
        increaseButton.layer.cornerRadius = decreaseButton.frame.height / 2
        increaseButton.layer.masksToBounds = true
        
        count.font = FontFamily.Montserrat.regular.font(size: 12)
        toppingNameLabel.font = FontFamily.Montserrat.semiBold.font(size: 14)
        toppingPriceLabel.font = FontFamily.Montserrat.semiBold.font(size: 14)
    }
    func configure(with topping: Topping_Order) {
        toppingNameLabel.text = topping.name_topping
        toppingPriceLabel.text = "\(topping.price_topping)$"
    }
    
    @IBAction func plus(_ sender: Any) {
        if amount > 0 {
            if amount == 10 {
                self.amount = 10
            }else{
                self.amount += 1
            }
        }else{
            self.amount += 1
        }
        count.text = amount.description
        changeAmount!(amount)
    }
    
    
    @IBAction func minus(_ sender: Any) {
        if amount > 0 {
            if amount == 0 {
                self.amount = 0
            }else{
                self.amount -= 1
            }
        }
        count.text = amount.description
        changeAmount!(amount)
    }
}
