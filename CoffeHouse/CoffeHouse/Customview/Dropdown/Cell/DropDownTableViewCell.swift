//
//  DropDownTableViewCell.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 17/11/24.
//
import Foundation
import UIKit


class DropDownTableViewCell: UITableViewCell {
    
    
    var imageProduct: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.white
        image.layer.cornerRadius = 14
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let labelText: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 10, weight: .medium, width: .standard)
//        lb.text = "Apple"
        lb.textAlignment = .left
        lb.numberOfLines = 5
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        
        addSubview(imageProduct)
        addSubview(labelText)
      
        constraintItem()
        
    }
   
    required init?(coder: NSCoder) {
        //From xib or storyboard
        super.init(coder: coder)
    }
    
    
    func bindingData(title: String, icon: String){
        self.imageProduct.image = UIImage(named: icon)
        self.labelText.text = title
    }

    
    // configure cell
    func configureCell() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    // constraint item
    func constraintItem() {
        NSLayoutConstraint.activate([
            imageProduct.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageProduct.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            imageProduct.widthAnchor.constraint(equalToConstant: 25),
            imageProduct.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            labelText.centerYAnchor.constraint(equalTo: imageProduct.centerYAnchor, constant: 0),
            labelText.leftAnchor.constraint(equalTo: imageProduct.rightAnchor, constant: 5),
            labelText.widthAnchor.constraint(equalToConstant: 150)
//            labelText.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    
}
