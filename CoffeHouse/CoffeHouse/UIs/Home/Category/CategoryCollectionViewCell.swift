//
//  CategoryCollectionViewCell.swift
//  CoffeHouse
//
//  Created by MacOs on 15/11/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameCategory: UILabel!
    @IBOutlet weak var imageCategory: UIImageView!
    @IBOutlet weak var viewCategory: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews (){
        viewCategory.layer.cornerRadius = 15
        viewCategory.layer.masksToBounds = true
        viewCategory.layer.borderWidth = 2
        viewCategory.layer.borderColor = UIColor.colorCustomBrown.cgColor
        nameCategory.font = FontFamily.Montserrat.regular.font(size: 12)
    }
    func setUpCellCategory(categies: CategoryModel) {
        nameCategory.text = categies.name
        if let imageURL = URL(string: categies.urlImage) {
            imageCategory.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        } else {
            imageCategory.image = UIImage(named: "placeholder")
        }
    }
    func setSelected(_ selected: Bool) { viewCategory.backgroundColor = selected ? UIColor.colorCustomBrown : UIColor.white }
}
