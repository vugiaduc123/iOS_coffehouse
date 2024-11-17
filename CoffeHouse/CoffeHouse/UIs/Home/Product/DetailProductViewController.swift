//
//  DetailProductViewController.swift
//  CoffeHouse
//
//  Created by DUONG DONG QUAN on 15/11/24.
//

import UIKit

class DetailProductViewController: UIViewController {

    @IBOutlet weak var button_favourite: UIButton!
    @IBOutlet weak var button_back: UIButton!
    
    @IBOutlet weak var button_pickSize: UIButton!
    @IBOutlet weak var button_AddToCart: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var product_img: UIImageView!
    @IBOutlet weak var product_name: UILabel!
    @IBOutlet weak var product_size: UIButton!
    @IBOutlet weak var product_description: UILabel!
    
    var product: detailProduct?

    override func viewDidLoad() {
        super.viewDidLoad()
        configRadius()
        
        // Sử dụng ProductManager để tải dữ liệu
        if let products = ProductManager.shared.loadProductData() {
            // Ví dụ: Chọn sản phẩm đầu tiên để hiển thị
            product = products.first
            loadUI()
        }
    }
    
    func loadUI() {
        guard let product = product else { return }
        
        // Hiển thị tên sản phẩm
        product_name.text = product.nameProduct
        
        // Hiển thị mô tả sản phẩm
        product_description.text = product.productContent
        
        // Hiển thị ảnh sản phẩm
        if let url = URL(string: product.urlImage) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.product_img.image = UIImage(data: data)
                    }
                }
            }
        }
        
        // Hiển thị size mặc định
        if let defaultSize = product.size.first {
            product_size.setTitle(defaultSize.name_size, for: .normal)
        }
    }
}

extension DetailProductViewController {
    func configRadius() {
        self.button_AddToCart.layer.cornerRadius = 20
        self.button_AddToCart.layer.masksToBounds = true
        self.button_pickSize.layer.cornerRadius = 15
        self.button_pickSize.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 30
        self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.contentView.layer.masksToBounds = true
    }
}
