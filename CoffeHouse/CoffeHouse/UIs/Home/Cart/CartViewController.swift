//
//  CartViewController.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 13/11/24.
//

import UIKit
import SDWebImage

class CartViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //
    private let widthSize: CGFloat = UIScreen.main.bounds.width
    private let heightSize: CGFloat = UIScreen.main.bounds.height
    private let paddingLeading: CGFloat = 20
    private let paddingRight: CGFloat = -20
    private var cellCart = "cellCart"
    private var cellEmpty = "cellEmpty"
    
    // view
    private let topView = UIView()
    private let bottomView = UIView()
    private var collectionView: UICollectionView!
    private var txtPrice = UILabel()
    
    // data
    private let service = Cart.shared
    private var listItems:[CartModel] = []
    private var totalPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure
        configureNavigationBar()
        configureView()
        
        // API
        getDataCart()
    }
    

}



// MARK: Manager Service

extension CartViewController {
    
    func getDataCart(){
        service.getDataCart { items in
            if  items.count != 0 {
                listItems = items
                totalPrice = items.map( { $0.total } ).reduce(0, +)
                txtPrice.text = "Total: \(totalPrice)$"
                collectionView.reloadData()
            }else{
                txtPrice.isHidden = true
            }
         
        }
    }

}

// MARK: Navigation bar
extension CartViewController{
    // Configure navigation bar
    private func configureNavigationBar() {
        self.navigationItem.rightBarButtonItem = NavigationItem().itemBarbtn(target: self, selector: #selector(pushToViewOrder), sizeIcon: 35)
    }
}

// MARK: Configure
extension CartViewController {
    
    // Configure View
    private func configureView() {
        
        // Addd View
        configureTopView()
        configureCollectionView()
        configureBottomView()
        configurelbPrice()
        
        // Main Constraint
        constraintTopView()
        constraintCollectionView() // collectionView
        constraintbottomView()
        
        // top view
        let itemLabel = generateLabel() // YOUR ORDER
        self.topView.addSubview(itemLabel)
        
        
        // botView
        let btnGoToCart = generateBtGo() // button action go destination link
        let btnLabel = generateLabelBtGo() // display text Go To Cart
        let imageArrow = generateImageArrow()
        self.bottomView.addSubview(btnGoToCart)
        btnGoToCart.addSubview(btnLabel)
        btnGoToCart.addSubview(imageArrow)
        self.view.addSubview(self.txtPrice)
        
        
        // constraint
        constraintLabel(label: itemLabel, itemConstraint: topView) // item label
        constraintBtGo(view: btnGoToCart, itemConstraint: bottomView) // item button
        constraintTextGoToCart(view: btnLabel, itemConstraint: btnGoToCart) // item label bot view
        constraintImageArrow(view: imageArrow, itemConstraint: btnGoToCart)
        constraintTotalPrice(view: self.txtPrice, itemConstraint: self.bottomView) // item label total price
    }
    
    private func configureTopView() {
        self.topView.translatesAutoresizingMaskIntoConstraints = false
        self.topView.backgroundColor = .white
        self.view.addSubview(topView)
    }
    
    private func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: cellCart)
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: cellEmpty)
        self.view.addSubview(collectionView)
    }
    
    private func configureBottomView() {
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.backgroundColor = .white
        self.view.addSubview(bottomView)
    }
    
    private func configurelbPrice() {
        
        self.txtPrice.text = "Total:  2000$"
        self.txtPrice.font = UIFont.systemFont(ofSize: 15, weight: .heavy, width: .standard)
        self.txtPrice.textColor = .black
        self.txtPrice.textAlignment = .right
        self.txtPrice.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func generateLabel() -> UILabel {
        let label = UILabel()
        label.text = "YOUR ORDER"
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy, width: .standard)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func generateBtGo() -> UIView {
        let btnView = UIView()
        btnView.backgroundColor = .black
        btnView.translatesAutoresizingMaskIntoConstraints = false
        btnView.layer.cornerRadius = 15
        btnView.layer.masksToBounds = true
        let action = UITapGestureRecognizer(target: self, action: #selector(pushToViewCart(sender:)))
        btnView.isUserInteractionEnabled = true
        btnView.addGestureRecognizer(action)
        return btnView
    }
    
    private func generateLabelBtGo() -> UILabel {
        let label = UILabel()
        label.text = "Go to Cart"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold, width: .standard)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func generateImageArrow() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: Asset.CartIcon.ic_arrow_right)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
     
}

// MARK: Constraint
extension CartViewController {
    // Constraint View
    private func constraintTopView() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            topView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            topView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func constraintCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0),
        ])
    }
    
    private func constraintbottomView() {
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            bottomView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func constraintLabel(label: UILabel, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: itemConstraint.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: itemConstraint.leadingAnchor, constant: paddingLeading),
            label.trailingAnchor.constraint(equalTo: itemConstraint.trailingAnchor, constant: paddingRight),
            label.bottomAnchor.constraint(equalTo: itemConstraint.bottomAnchor, constant: 0),
        ])
    }
    
    private func constraintBtGo(view: UIView, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
//            view.topAnchor.constraint(equalTo: itemConstraint.topAnchor, constant: 5),
            view.centerYAnchor.constraint(equalTo: itemConstraint.centerYAnchor, constant: 0),
            view.leadingAnchor.constraint(equalTo: itemConstraint.leadingAnchor, constant: paddingLeading),
            view.trailingAnchor.constraint(equalTo: itemConstraint.trailingAnchor, constant: paddingRight),
            view.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func constraintTextGoToCart(view: UILabel, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: itemConstraint.topAnchor, constant: 5),
            view.leadingAnchor.constraint(equalTo: itemConstraint.leadingAnchor, constant: 32),
            view.centerYAnchor.constraint(equalTo: itemConstraint.centerYAnchor, constant: 0),
            view.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func constraintImageArrow(view: UIImageView, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: itemConstraint.topAnchor, constant: 5),
            view.rightAnchor.constraint(equalTo: itemConstraint.rightAnchor, constant: -32),
            view.centerYAnchor.constraint(equalTo: itemConstraint.centerYAnchor, constant: 0),
            view.heightAnchor.constraint(equalToConstant: 20),
            view.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
    
    private func constraintTotalPrice(view: UILabel, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: itemConstraint.topAnchor, constant: 10),
            view.rightAnchor.constraint(equalTo: itemConstraint.rightAnchor, constant: paddingRight),
            view.leftAnchor.constraint(equalTo: itemConstraint.leftAnchor, constant: paddingLeading),
            view.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

// MARK: Method Action
extension CartViewController{
    @objc func pushToViewOrder(sender: UIButton) {
        print("kkk")
    }
    
    @objc func pushToViewCart(sender: UITapGestureRecognizer) {
        print("ppp")
    }
    
    private func updatePrice(index: Int, amount: Int){
        listItems[index].amount = amount
        totalPrice = listItems.map( { $0.total * Double($0.amount) } ).reduce(0, +)
        txtPrice.text = "Total: \(totalPrice.description)$"
    }
}

// MARK: CollectionView
extension CartViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listItems.count != 0 {
            return listItems.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        if listItems.count != 0 {
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellCart, for: indexPath as IndexPath) as! CartCell
            
            let item = listItems[indexPath.row]
            
            cell.bindingData(item: item)
            
            // caculate total amount again
            
            cell.backAmount = { amount in
                self.updatePrice(index: indexPath.row, amount: amount)
            }
            
            return cell
        }
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellEmpty, for: indexPath as IndexPath) as! EmptyCell
        
        return cell

    }
    
    
    
    
    
}

extension CartViewController: UICollectionViewDelegate {
  
}

extension CartViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.widthSize - (paddingLeading * 2)), height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 30, bottom: 10, right: 30)
    }
    
}









