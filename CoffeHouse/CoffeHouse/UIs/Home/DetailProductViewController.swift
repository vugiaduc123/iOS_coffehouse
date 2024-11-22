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
    
    @IBOutlet weak var toppingCollectionView: UICollectionView!
    @IBOutlet weak var heightViewBot: NSLayoutConstraint!
    
    
    
    var idProduct = 0
    var product: detailProduct?
    var user: UserEntity?
    override func viewDidLoad() {
        super.viewDidLoad()
        configRadius()
        
        // Use ProductManager for loading data
        if let userData = UserDefaults.standard.data(forKey: "loggedInUser"),
           let user = try? JSONDecoder().decode(UserEntity.self, from: userData) {
            self.user = user
        }
        if let products = ProductManager.shared.loadProductData() {
//            product = products[3]
             let pro = products.filter({ $0.idProduct ==  idProduct })
            self.product = pro[0]
            loadUI()
        }
        toppingCollectionView.delegate = self
        toppingCollectionView.dataSource = self
        
        // Register Cell (cuz i created ToppingCell.xib)
        toppingCollectionView.register(UINib(nibName: "ToppingCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ToppingCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func addToCart(_ sender: Any) {
        
        let product = ProductMain(id: product!.idProduct, idCategory: product!.idCategory, name: product!.nameProduct, price: product!.price, rate: product!.rate, full_path: product!.urlImage)
        
        let size = SizeModelMain(idSize: 0, name: "S", price: 1.0)
        var toppingscart:[ToppingCart] = []
        
        if let toppings = self.product?.topping{
            for i in toppings {
                let item = ToppingCart(idTopping: i.id, name: i.name_topping, amount: i.amount, price: i.price_topping)
                toppingscart.append(item)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: { [self] in
            Cart.shared.addToCart(userId: user!.id, product: product, size: size, toppings: toppingscart)
            showAlert(on: self)
        })
    }
    
    @IBAction func backView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true
        )
    }
    func loadUI() {
        guard let product = product else { return }
        
        product_name.text = product.nameProduct
        
        product_description.text = product.productContent
        
        // product_img
        if let url = URL(string: product.urlImage) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.product_img.image = UIImage(data: data)
                    }
                }
            }
        }
        
        if let defaultSize = product.size.first {
            product_size.setTitle(defaultSize.name_size, for: .normal)
        }
    }
    
    func configureView(with product: detailProduct) {
        self.product = product

        // Check if there is topping
        if product.topping.count != 0 {
            toppingCollectionView.isHidden = true // Hidden if there is not
            heightViewBot.constant = 300
        } else {
            toppingCollectionView.isHidden = false
            let height = CGFloat(product.topping.count * 40)
            heightViewBot.constant = 500 + height
            toppingCollectionView.reloadData()
        }
        view.layoutIfNeeded()
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
    private func showAlert(on viewController: UIViewController) {
        let alert = UIAlertController(title: "Success", message: "Thêm sản phẩm vào giỏ hàng", preferredStyle: .alert)
        
        viewController.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension DetailProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Returns the number of toppings (data from product)
        return product?.topping.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Create cells and assign data
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToppingCell", for: indexPath) as! ToppingCellCollectionViewCell
        let topping = product?.topping[indexPath.row]
        cell.configure(with: topping!) // Config cell with topping
        cell.changeAmount = { [unowned self] amount in
            
            if amount < 1 {
                product?.topping[indexPath.row].amount = 0
            }else{
                product?.topping[indexPath.row].amount = amount
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.toppingCollectionView.frame.width, height: 50)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
}


