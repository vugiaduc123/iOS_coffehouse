//
//  PaymentViewController.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 17/11/24.
//

import Foundation
import UIKit


class PaymentViewController: UIViewController{
    
    private let widthSize: CGFloat = UIScreen.main.bounds.width
    private let heightSize: CGFloat = UIScreen.main.bounds.height
    private let paddingLeft: CGFloat = 20
    private let paddingRight: CGFloat = -20
    private var cellPay = "CartPaymentCell"
    
    // view
    private let mainView = UIView()
    private let topView = UIView()
    private let bottomView = UIView()
    private var collectionView: UICollectionView!
    private var txtPrice = UILabel()
    
    private var PaymentMethodView = UIView()
    private var txtMethodPay = UILabel()
    private var IconMethod = UIImageView()

  
    // data
    private let service = Cart.shared
    
    
    var listItems:[CartModel] = []
    var totalPrice = 0.0
    var idPaymentMethod = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
    }
    
    deinit{
        print("kkkkk")
    }
        
}

// MARK: Navigation bar
extension PaymentViewController{
  
    // Configure navigation bar
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.changeBackgroundColor(backroundColor: .white)
        self.navigationItem.leftBarButtonItem = NavigationItem().itemBarbtn(icon: Asset.CartIcon.ic_back, target: self, selector: #selector(backToViewController), sizeIcon: 35)
    }
}

// MARK: Configure
extension PaymentViewController {
    
    // Configure View
    private func configureView() {
        
        // Addd View
        configureMainView()
        configureTopView()
        configureCollectionView()
        configureBottomView()
        configurelbPrice()
        configurePaymenMethodView()
        
        // Main Constraint
        constraintMainView()
        constraintTopView()
        constraintCollectionView() // collectionView
        constraintbottomView()
        
        // top view
        let itemLabel = generateLabel() // YOUR ORDER
        self.topView.addSubview(itemLabel)
        constraintLabelOrder(label: itemLabel, itemConstraint: topView) // item label
        
        // bot view
        configureInBottomView()
    }
    
    private func configureMainView() {
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        self.mainView.backgroundColor = .white
        
        self.view.addSubview(mainView)
    }
    
    private func configureTopView() {
        self.topView.translatesAutoresizingMaskIntoConstraints = false
        self.topView.backgroundColor = .white
        self.mainView.addSubview(topView)
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
        collectionView.register(CartPaymentCell.self, forCellWithReuseIdentifier: cellPay)
        self.mainView.addSubview(collectionView)
    }
    
    private func configureBottomView() {
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.backgroundColor = .white
        self.mainView.addSubview(bottomView)
    }
    
    private func configurePaymenMethodView(){
   
        PaymentMethodView.backgroundColor = UIColor.systemGray4
        PaymentMethodView.translatesAutoresizingMaskIntoConstraints = false
        PaymentMethodView.layer.cornerRadius = 2.5
        PaymentMethodView.layer.masksToBounds = true
        let action = UITapGestureRecognizer(target: self, action: #selector(showDropdown(sender:)))
        PaymentMethodView.isUserInteractionEnabled = true
        PaymentMethodView.addGestureRecognizer(action)
      
        self.mainView.addSubview(PaymentMethodView)
    }
    
    private func configureInBottomView(){
        // botView
        
        // create view
        let addressView = generateAddressView()
        let lbDisplayPayment = generatelbDisplayPayment()
     
        
        // item view button go to order
        let btnGoToOrder = generateBtGo() // button action go destination link
        let btnLabel = generateLabelBtGo() // display text Go To Cart
        let imageArrow = generateImageArrow()
        
        // item view address
        let icLocation = generateImageLoaction()
        let lbAddress = generateLabelAddress()
    
        // item view method
        let txtPaymentMethod = generatetxtMethodPay()
        let iconPaymentMethod = generateIconMethod()
        let iconDropdown = generateIconDropdown()
        
        // add view
        self.bottomView.addSubview(btnGoToOrder)
        self.bottomView.addSubview(addressView)
        self.bottomView.addSubview(lbDisplayPayment)
    
        
        
        btnGoToOrder.addSubview(btnLabel)
        btnGoToOrder.addSubview(imageArrow)
        addressView.addSubview(icLocation)
        addressView.addSubview(lbAddress)
        
        txtMethodPay = txtPaymentMethod
         IconMethod = iconPaymentMethod
        PaymentMethodView.addSubview(txtPaymentMethod)
        PaymentMethodView.addSubview(iconPaymentMethod)
        PaymentMethodView.addSubview(iconDropdown)
        
        self.mainView.addSubview(self.txtPrice)
        self.txtPrice.text = "Total: \(totalPrice)$"
        
        
        // constraint
        
        constraintAddressView(view: addressView, itemConstraint: bottomView) // view location contain
        constraintImageLocation(view: icLocation, itemConstraint: addressView) // ic location
        constraintLbAddress(view: lbAddress, itemConstraint: icLocation) // txt address
        
        constraintlbDisplayPayment(view: lbDisplayPayment, itemConstraint: addressView) // lb payment method
        constraintpaymentMethodView(view: PaymentMethodView, itemConstraint: lbDisplayPayment) // payment method view
        
        // button view order
        constraintBtGo(view: btnGoToOrder, itemConstraint: bottomView) // item button
        constraintTextGoToCart(view: btnLabel, itemConstraint: btnGoToOrder) // item label bot view
        constraintImageArrow(view: imageArrow, itemConstraint: btnGoToOrder) // image arrow right
        // button view order
        
        constraintTotalPrice(view: self.txtPrice, itemConstraint: btnGoToOrder) // item label total price
        
        //    payment method view
        constraintIconPaymentMethod(iconView: iconPaymentMethod, itemConstraint: PaymentMethodView)
        constraintTxtPaymentMethod(view: txtPaymentMethod, itemConstraint: iconPaymentMethod, iconDropDown: iconDropdown)
        constraintIconDropdown(iconView: iconDropdown, itemConstraint: PaymentMethodView, iconPayment: iconPaymentMethod)
        //    payment method view
        
       
        
    }
    
    private func configurelbPrice() {
        
        self.txtPrice.text = "Total:  2000$"
        self.txtPrice.font = UIFont.systemFont(ofSize: 13, weight: .heavy, width: .standard)
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
    
    private func generateAddressView() -> UIView {
        let address = UIView()
        address.backgroundColor = .white
        address.translatesAutoresizingMaskIntoConstraints = false
        let action = UITapGestureRecognizer(target: self, action: #selector(pushToLocationView(sender:)))
        address.isUserInteractionEnabled = true
        address.addGestureRecognizer(action)
        return address
    }
    
    private func generateBtGo() -> UIView {
        let btnView = UIView()
        btnView.backgroundColor = .black
        btnView.translatesAutoresizingMaskIntoConstraints = false
        btnView.layer.cornerRadius = 2.5
        btnView.layer.masksToBounds = true
        let action = UITapGestureRecognizer(target: self, action: #selector(pushToViewCreateOrder(sender:)))
        btnView.isUserInteractionEnabled = true
        btnView.addGestureRecognizer(action)
        return btnView
    }
    
    private func generateLabelBtGo() -> UILabel {
        let label = UILabel()
        label.text = "Creat Order"
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
    
    private func generateImageLoaction() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: Asset.CartIcon.ic_location)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
    
    private func generateLabelAddress() -> UILabel {
        let label = UILabel()
        label.text = "88/15 Tran Van Dang, P9, Q.3, TP.HCM"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold, width: .standard)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func generatelbDisplayPayment() -> UILabel {
        let label = UILabel()
        label.text = "Payment method"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold, width: .standard)
        label.textColor = UIColor.systemGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
  
    private func generatetxtMethodPay() -> UILabel {
        let label = UILabel()
        label.text = "Apple"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold, width: .standard)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func generateIconMethod() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: Asset.CartIcon.ic_apple)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
    
    private func generateIconDropdown() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: Asset.CartIcon.ic_arrow_down)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
    
     
}


// MARK: Constraint
extension PaymentViewController {
    // Constraint View
    
    private func constraintMainView() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
        ])
    }
    
    private func constraintTopView() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 15),
            topView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 0),
            topView.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: 0),
            topView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func constraintCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0),
        ])
    }
    
    private func constraintbottomView() {
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 0),
            bottomView.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: 0),
            bottomView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 0),
            bottomView.heightAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    private func constraintLabelOrder(label: UILabel, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: itemConstraint.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: itemConstraint.leadingAnchor, constant: paddingLeft),
            label.trailingAnchor.constraint(equalTo: itemConstraint.trailingAnchor, constant: paddingRight),
            label.bottomAnchor.constraint(equalTo: itemConstraint.bottomAnchor, constant: 0),
        ])
    }
    
    private func constraintAddressView(view: UIView, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: itemConstraint.topAnchor, constant: 5),
            view.leadingAnchor.constraint(equalTo: itemConstraint.leadingAnchor, constant: paddingLeft),
            view.trailingAnchor.constraint(equalTo: itemConstraint.trailingAnchor, constant: paddingRight),
            view.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func constraintBtGo(view: UIView, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: itemConstraint.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: itemConstraint.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: itemConstraint.bottomAnchor, constant: 0),
            view.heightAnchor.constraint(equalToConstant: 104)
        ])
    }
    
    private func constraintTextGoToCart(view: UILabel, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: itemConstraint.topAnchor, constant: 5),
            view.leadingAnchor.constraint(equalTo: itemConstraint.leadingAnchor, constant: 32),
            view.centerYAnchor.constraint(equalTo: itemConstraint.centerYAnchor, constant: -7.5),
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
            view.bottomAnchor.constraint(equalTo: itemConstraint.topAnchor, constant: -15),
            view.rightAnchor.constraint(equalTo: itemConstraint.rightAnchor, constant: paddingRight),
            view.leftAnchor.constraint(equalTo: itemConstraint.leftAnchor, constant: paddingLeft),
            view.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func constraintImageLocation(view: UIImageView, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: itemConstraint.leftAnchor, constant: 0),
            view.centerYAnchor.constraint(equalTo: itemConstraint.centerYAnchor, constant: 0),
            view.heightAnchor.constraint(equalToConstant: 20),
            view.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func constraintLbAddress(view: UILabel, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: itemConstraint.rightAnchor, constant: 5),
            view.rightAnchor.constraint(equalTo: self.bottomView.rightAnchor, constant: paddingRight),
            view.centerYAnchor.constraint(equalTo: itemConstraint.centerYAnchor, constant: 0),
            view.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func constraintlbDisplayPayment(view: UILabel, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: itemConstraint.topAnchor, constant: 50),
            view.rightAnchor.constraint(equalTo: self.bottomView.rightAnchor, constant: paddingRight),
            view.leftAnchor.constraint(equalTo: itemConstraint.leftAnchor, constant: 0),
            view.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func constraintpaymentMethodView(view: UIView, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: itemConstraint.bottomAnchor, constant: 10),
            view.rightAnchor.constraint(equalTo: self.bottomView.rightAnchor, constant: paddingRight),
            view.leftAnchor.constraint(equalTo: self.bottomView.leftAnchor, constant: paddingLeft),
            view.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    private func constraintIconPaymentMethod(iconView: UIImageView, itemConstraint: UIView) {
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: itemConstraint.centerYAnchor, constant: 0),
            iconView.leftAnchor.constraint(equalTo: itemConstraint.leftAnchor, constant: 5),
            iconView.widthAnchor.constraint(equalToConstant: 25),
            iconView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    private func constraintTxtPaymentMethod(view: UILabel, itemConstraint: UIImageView, iconDropDown: UIImageView) {
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: itemConstraint.centerYAnchor, constant: 0),
            view.leftAnchor.constraint(equalTo: itemConstraint.rightAnchor, constant: 5),
            view.rightAnchor.constraint(equalTo: iconDropDown.leftAnchor, constant: 5),
            view.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func constraintIconDropdown(iconView: UIImageView, itemConstraint: UIView, iconPayment: UIImageView) {
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: iconPayment.centerYAnchor, constant: 0),
            iconView.rightAnchor.constraint(equalTo: itemConstraint.rightAnchor, constant: -10),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

// MARK: Method Action
extension PaymentViewController {
    
    @objc func backToViewController(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pushToLocationView(sender: UITapGestureRecognizer) {
        print("aaaa")
    }
    
    @objc func pushToViewCreateOrder(sender: UITapGestureRecognizer) {
        print("aaaa")
    }

    @objc func showDropdown(sender: UITapGestureRecognizer) {
        dropDown()
    }
    
    func dropDown(){
        guard let frame = PaymentMethodView.frame(in: mainView) else{
            print("error get frame view")
            return
        }
        let drop = DropDownView(frame: frame, mainView: self.mainView, heightTableView: 150, openDirection: .bottom, cornerRadius: 5, borderWidth: 1, borderColor: .gray)
        drop.translatesAutoresizingMaskIntoConstraints = false
        let title = ["Apple", "VISA/MASTERCART","Cash"]
        let ids = [0,1,2]
        let icons = [Asset.CartIcon.ic_apple, Asset.CartIcon.ic_visa, Asset.CartIcon.ic_cash]
        drop.listName = title
        drop.listId = ids
        drop.icons = icons
        drop.bacData = { text, idMethod, icon in
            self.txtMethodPay.text = text
            self.IconMethod.image = UIImage(named: icon)
            self.idPaymentMethod = idMethod
        }
        self.mainView.addSubview(drop)
    }
    
    
}

// MARK: CollectionView
extension PaymentViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellPay, for: indexPath as IndexPath) as! CartPaymentCell
        
        let item = listItems[indexPath.row]
        cell.bindingData(item: item)
        
        return cell

    }
    
    
    
    
    
}

extension PaymentViewController: UICollectionViewDelegate {
  
}

extension PaymentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.widthSize - (paddingLeft * 2)), height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 30, bottom: 10, right: 30)
    }
    
}
