//
//  EmptyCell.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 17/11/24.
//

import Foundation
import UIKit


class EmptyCell: UICollectionViewCell {
    
    
    let imageProduct: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.white
        image.layer.cornerRadius = 14
        image.clipsToBounds = true
        image.image = UIImage(systemName: "camera.fill")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let labelText: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 10, weight: .medium, width: .standard)
        lb.text = "Xin vui lòng thêm sản phẩm vào giỏ hàng!"
        lb.textAlignment = .center
        lb.numberOfLines = 5
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        
        addSubview(imageProduct)
        addSubview(labelText)
      
        constraintItem()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // configure cell
    func configureCell() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    
    // constraint item
    func constraintItem() {
        NSLayoutConstraint.activate([
            imageProduct.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            imageProduct.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            imageProduct.widthAnchor.constraint(equalToConstant: 150),
            imageProduct.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            labelText.centerXAnchor.constraint(equalTo: imageProduct.centerXAnchor, constant: 0),
            labelText.topAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant: 2.5),
            labelText.widthAnchor.constraint(equalToConstant: 150)
//            labelText.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    
}
