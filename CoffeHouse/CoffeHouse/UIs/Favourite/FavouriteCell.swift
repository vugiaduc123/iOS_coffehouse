//
//  FavouriteCell.swift
//  CoffeHouse
//
//  Created by Apple on 14/11/24.
//

import UIKit
import SDWebImage

class FavouriteCell: UITableViewCell {
    
    @IBOutlet weak var imageProduct: UIImageView!
    
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backView: UIView!
    
    var favButtonPressed: (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        config()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnRemoveFavourite(_ sender: UIButton) {
        favButtonPressed()
    }
    
    func bind(with product: ProductModel) {
        name.text = product.nameProduct
        price.text = String(product.price)
        rate.text = String(product.rate)
        imageProduct.sd_setImage(with: URL(string: product.urlImage), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func config() {
        configImageProduct()
        configCell()
    }
}


//MARK: - Config
extension FavouriteCell {
    func configImageProduct() {
        imageProduct.layer.cornerRadius = 14
    }
    
    func configCell() {
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}
