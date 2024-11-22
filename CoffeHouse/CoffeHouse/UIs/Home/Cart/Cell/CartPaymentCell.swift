//
//  CartPaymentCell.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 17/11/24.
//

import Foundation
import UIKit

class CartPaymentCell: UICollectionViewCell {
    let imageProduct: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.white
        image.layer.cornerRadius = 14
        image.clipsToBounds = true
        //        image.image = UIImage(systemName: "flame.fill")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let imagePlaceHolder: UIImage = {
        var image = UIImage(systemName: "camera.fill")!
        return image
    }()
    var nameProduct: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.semiBold.font(size: 14)
        label.textColor = UIColor.black
        label.text = "Espresso"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceProduct: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.semiBold.font(size: 14)
        label.textColor = UIColor.red
        label.text = "2$"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sizeProduct: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.regular.font(size: 11.5)
        label.textColor = UIColor.black
        label.text = "Size: M / 1$"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var toppingProduct: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.regular.font(size: 11.5)
        label.textColor = UIColor.black
        label.text = "Topping: Thêm mì / 1$"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewSpacing: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var  stackContent = UIStackView()
    
    let iconRate: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.white
        image.image = UIImage(systemName: "star.fill")
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.systemGray2
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let scoreRate: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.regular.font(size: 13)
        label.textColor = UIColor.black
        label.text = "4.7"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let amount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular, width: .standard)
        label.textColor = UIColor.black
        label.text = "1"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var backAmount: ( (Int) -> Void )?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // configure cell
    func configureCell() {
        backgroundColor = .white
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.cornerRadius = 15
        
        layer.shadowColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    // add view to cell
    func addViews() {
        addSubview(imageProduct)
        addSubview(priceProduct)
        addSubview(nameProduct)
        addSubview(sizeProduct)
        addSubview(toppingProduct)
        addSubview(scoreRate)
        addSubview(iconRate)
        addSubview(amount)
        
    }
    
    // get data to display
    func bindingData(item: CartModel) {
        
        if item.product.full_path != "" {
            self.imageProduct.sd_setImage(with: URL(string: item.product.full_path), placeholderImage: imagePlaceHolder)
        }else{
            self.imageProduct.contentMode = .scaleAspectFit
            self.imageProduct.image = imagePlaceHolder
        }
        
        self.nameProduct.text = "\(item.product.name) / \(item.product.price)$"
        
        if let size = item.size {
            self.sizeProduct.text = "Size: \(size.name) / \(size.price) $"
        }else{
            self.sizeProduct.isHidden = true
        }
        
        if item.topping.count != 0{
            let string = valueTopping(data: item.topping)
            self.toppingProduct.text = string
        }else{
            self.toppingProduct.isHidden = true
        }
        
        if amount.text!.isNumeric {
            self.amount.text = "SL: " + item.amount.description
        }else{
            self.amount.text = "SL: 1"
        }
        
        self.scoreRate.text = item.product.rate.description
        addViews()
        constraintItem(sizeItem: item.size, toping: item.topping)
    }
    
    // return value topping
    func valueTopping(data: [ToppingCart]) -> String? {
        var text = ""
        for i in data.indices{
            let item = data[i]
            if i == 0 {
                text += "+ \(item.name) / \(item.price)$ - qty: \(item.amount)"
            }else{
                text += " \n+ \(item.name) / \(item.price)$ - qty: \(item.amount)"
            }
            
        }
        text = "Topping: \n\(text)"
        return text
    }

}

// MARK: Constraint
extension CartPaymentCell {
    // constraint item
    func constraintItem(sizeItem: SizeModelMain?, toping: [ToppingCart]?) {
        NSLayoutConstraint.activate([
            imageProduct.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageProduct.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            imageProduct.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            imageProduct.widthAnchor.constraint(equalToConstant: 90),
            imageProduct.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            nameProduct.topAnchor.constraint(equalTo: imageProduct.topAnchor, constant: 5),
            nameProduct.leftAnchor.constraint(equalTo: imageProduct.rightAnchor, constant: 10),
            nameProduct.heightAnchor.constraint(equalToConstant: 15),
            nameProduct.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            priceProduct.topAnchor.constraint(equalTo: nameProduct.bottomAnchor, constant: 5),
            priceProduct.leftAnchor.constraint(equalTo: imageProduct.rightAnchor, constant: 10),
            priceProduct.heightAnchor.constraint(equalToConstant: 15),
            priceProduct.heightAnchor.constraint(equalToConstant: 100)
        ])

        
        if ( (sizeItem) != nil) && (toping == nil) {
            // constraint label Size
            NSLayoutConstraint.activate([
                sizeProduct.topAnchor.constraint(equalTo: priceProduct.bottomAnchor, constant: 10),
                sizeProduct.leftAnchor.constraint(equalTo: imageProduct.rightAnchor, constant: 10),
                sizeProduct.heightAnchor.constraint(equalToConstant: 12.5)
            ])
            
        }else if toping != nil && ((sizeItem) == nil) {
            // constraint label Topping
            NSLayoutConstraint.activate([
                toppingProduct.topAnchor.constraint(equalTo: priceProduct.bottomAnchor, constant: 5),
                toppingProduct.leftAnchor.constraint(equalTo: imageProduct.rightAnchor, constant: 10),
                toppingProduct.rightAnchor.constraint(equalTo:  amount.leftAnchor, constant: -5)
            ])
        }else if ( (sizeItem) != nil) && (toping != nil) {
            // constraint label Size and Toping
            NSLayoutConstraint.activate([
                sizeProduct.topAnchor.constraint(equalTo: priceProduct.bottomAnchor, constant: 10),
                sizeProduct.leftAnchor.constraint(equalTo: imageProduct.rightAnchor, constant: 10),
                sizeProduct.heightAnchor.constraint(equalToConstant: 12.5)
            ])
            
            NSLayoutConstraint.activate([
                toppingProduct.topAnchor.constraint(equalTo: sizeProduct.bottomAnchor, constant: 5),
                toppingProduct.leftAnchor.constraint(equalTo: imageProduct.rightAnchor, constant: 10),
                toppingProduct.rightAnchor.constraint(equalTo: amount.leftAnchor, constant: -5),
                toppingProduct.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
                //            toppingProduct.heightAnchor.constraint(equalToConstant: 10)
            ])
        }
        
        //
        NSLayoutConstraint.activate([
            scoreRate.topAnchor.constraint(equalTo: nameProduct.topAnchor, constant: 0),
            scoreRate.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            scoreRate.heightAnchor.constraint(equalToConstant: 10),
            //            scoreRate.widthAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            iconRate.centerYAnchor.constraint(equalTo: scoreRate.centerYAnchor, constant: 0),
            iconRate.rightAnchor.constraint(equalTo: scoreRate.leftAnchor, constant: -2.5),
            iconRate.heightAnchor.constraint(equalToConstant: 10),
            iconRate.widthAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            iconRate.centerYAnchor.constraint(equalTo: scoreRate.centerYAnchor, constant: 0),
            iconRate.rightAnchor.constraint(equalTo: scoreRate.leftAnchor, constant: -2.5),
            iconRate.heightAnchor.constraint(equalToConstant: 10),
            iconRate.widthAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            amount.rightAnchor.constraint(equalTo: scoreRate.rightAnchor, constant: 0),
            amount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            amount.heightAnchor.constraint(equalToConstant: 30),
            amount.widthAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}

