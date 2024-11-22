//
//  CartCell.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 17/11/24.
//

import Foundation
import UIKit

class CartCell: UICollectionViewCell {
    var paddingRightBack: NSLayoutConstraint?
    var paddingRight: NSLayoutConstraint?
    
    var iconWidth: NSLayoutConstraint?
    var iconHeight: NSLayoutConstraint?
    var iconZeroWidth: NSLayoutConstraint?
    var iconZeroHeight: NSLayoutConstraint?
    
    
    
    let imageProduct: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.white
        image.layer.cornerRadius = 14
        image.clipsToBounds = true
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
    
    let minusView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.white
        image.image = UIImage(systemName: "minus.circle.fill")
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.black
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let plusView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.white
        image.image = UIImage(systemName: "plus.circle.fill")
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.black
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
    
    let editView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .tintColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let iconEdit: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: Asset.CartIcon.ic_edit)?
            .imageWithColor(color: .white)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var backAmount: ( (Int) -> Void )?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        addViews()
        constraintItem()
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
        addSubview(nameProduct)
        addSubview(priceProduct)
        configureStackView()
        addSubview(scoreRate)
        addSubview(iconRate)
        addSubview(minusView)
        addSubview(plusView)
        addSubview(amount)
        addSubview(editView)
        editView.addSubview(iconEdit)
        
        // configure
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(minus(sender:)))
        minusView.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(plus(sender:)))
        plusView.addGestureRecognizer(tap2)
    }
    
    func configureStackView() {
        let stackContent = UIStackView(arrangedSubviews: [sizeProduct, toppingProduct,viewSpacing])
        stackContent.translatesAutoresizingMaskIntoConstraints = false
        stackContent.axis = .vertical
        stackContent.spacing = 5
        stackContent.alignment = .leading
//        stackContent.backgroundColor = .red
//        stackContent.distribution = .fillEqually
        self.stackContent = stackContent
        addSubview(stackContent)
        
    }
    
    // get data to display
    func bindingData(item: CartModel, editProduct: Bool) {
        if item.product.full_path != "" {
            self.imageProduct.sd_setImage(with: URL(string: item.product.full_path), placeholderImage: imagePlaceHolder)
        }else{
            self.imageProduct.contentMode = .scaleAspectFit
            self.imageProduct.image = imagePlaceHolder
        }
        
        self.nameProduct.text = "\(item.product.name)"
        self.priceProduct.text = "\(item.product.price)$"
        
        if let item = item.size{
            self.sizeProduct.text = "Size: \(item.name) / \(item.price) $"
            self.sizeProduct.isHidden = false
        }else{
            self.sizeProduct.isHidden = true
        }
        
        if item.topping.count != 0{
            
//            stackContent.heightAnchor.constraint(equalToConstant: CGFloat(50 + item.topping.count*20)).isActive = true
//            debugPrint("itemHiehgt",CGFloat(30 + item.topping.count*20))

            let string = valueTopping(data: item.topping)
            self.toppingProduct.text = string
            self.toppingProduct.isHidden = false
            
        }else{
            self.toppingProduct.isHidden = true
        }
        
        if amount.text!.isNumeric {
            self.amount.text = item.amount.description
        }else{
            self.amount.text = "1"
        }
        self.scoreRate.text = item.product.rate.description
        
        updateConstraint(editProduct: editProduct)
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
extension CartCell {
    
    // constraint item
    func constraintItem() {
        
        NSLayoutConstraint.activate([
            imageProduct.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageProduct.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            imageProduct.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
//            imageProduct.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
//            imageProduct.widthAnchor.constraint(equalTo: imageProduct.heightAnchor, multiplier: 1.0/1.0)
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
        
        NSLayoutConstraint.activate([
            stackContent.topAnchor.constraint(equalTo: priceProduct.bottomAnchor, constant: 10),
            stackContent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackContent.leftAnchor.constraint(equalTo: imageProduct.rightAnchor, constant: 10),
            stackContent.rightAnchor.constraint(equalTo: minusView.leftAnchor, constant: -5),
//            stackContent.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        NSLayoutConstraint.activate([
            scoreRate.topAnchor.constraint(equalTo: nameProduct.topAnchor, constant: 0),
            scoreRate.heightAnchor.constraint(equalToConstant: 10),
        ])
        
        paddingRight = NSLayoutConstraint(item: scoreRate, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -80)
        paddingRightBack = NSLayoutConstraint(item: scoreRate, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -10)
        paddingRight?.isActive = false
        paddingRightBack?.isActive = true
        
        NSLayoutConstraint.activate([
            iconRate.centerYAnchor.constraint(equalTo: scoreRate.centerYAnchor, constant: 0),
            iconRate.rightAnchor.constraint(equalTo: scoreRate.leftAnchor, constant: -2.5),
            iconRate.heightAnchor.constraint(equalToConstant: 15),
            iconRate.widthAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            plusView.rightAnchor.constraint(equalTo: self.scoreRate.rightAnchor, constant: 0),
            plusView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            plusView.heightAnchor.constraint(equalToConstant: 22),
            plusView.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            amount.rightAnchor.constraint(equalTo: plusView.leftAnchor, constant: 0),
//            amount.bottomAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant: 0),
            amount.centerYAnchor.constraint(equalTo: plusView.centerYAnchor, constant: 0),
            amount.heightAnchor.constraint(equalToConstant: 30),
            amount.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            minusView.rightAnchor.constraint(equalTo: amount.leftAnchor, constant: 0),
            minusView.centerYAnchor.constraint(equalTo: plusView.centerYAnchor, constant: 0),
            minusView.heightAnchor.constraint(equalToConstant: 22),
            minusView.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            editView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            editView.leftAnchor.constraint(equalTo: scoreRate.rightAnchor, constant: 10),
            editView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            editView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            iconEdit.centerXAnchor.constraint(equalTo: editView.centerXAnchor, constant: 0),
            iconEdit.centerYAnchor.constraint(equalTo: editView.centerYAnchor, constant: 0)
        ])
        
        iconWidth = NSLayoutConstraint(item: iconEdit, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .width, multiplier: 1.0, constant: 30)
        
        iconHeight = NSLayoutConstraint(item: iconEdit, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .height, multiplier: 1.0, constant: 30)
        
        iconZeroWidth = NSLayoutConstraint(item: iconEdit, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
        
        iconZeroHeight = NSLayoutConstraint(item: iconEdit, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
        
        iconWidth?.isActive = false
        iconZeroWidth?.isActive = true
        iconHeight?.isActive = false
        iconZeroHeight?.isActive = true
        
    }
    
    func updateConstraint(editProduct: Bool){
        if editProduct {
            paddingRight?.isActive = true
            paddingRightBack?.isActive = false
            iconWidth?.isActive = true
            iconHeight?.isActive = true
            iconZeroWidth?.isActive = false
            iconZeroHeight?.isActive = false
        }else{
            paddingRight?.isActive = false
            paddingRightBack?.isActive = true
            iconZeroWidth?.isActive = true
            iconZeroHeight?.isActive = true
            iconWidth?.isActive = false
            iconHeight?.isActive = false
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

// MARK: Method action
extension CartCell {
    
    //  minus amount
    @objc func minus(sender: UITapGestureRecognizer){
        if !amount.text!.isNumeric {
            return
        }
        
        var number = Int(self.amount.text!)!
        
        if number < 1{
            number = 1
        }else{
            
            if number < 2{
                number = 1
            }else{
                number -= 1
            }
            
        }
        
        backAmount?(number)
        self.amount.text = number.description
        
    }
    
    // plus amount
    @objc func plus(sender: UITapGestureRecognizer){
        if !amount.text!.isNumeric {
            return
        }
        
        var number = Int(self.amount.text!)!
        
        if number >= 100{
            number = 100
        }else{
            
            if number < 2{
                number += 1
            }else{
                number += 1
            }
            
        }
        backAmount?(number)
        self.amount.text = number.description
        
    }
    
}
