//
//  TrackingOrderViewController.swift
//  CoffeHouse
//
//  Created by DUONG DONG QUAN on 17/11/24.
//

import UIKit

class TrackingOrderViewController: UIViewController {
    
    @IBOutlet weak var trackingOrder: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.trackingOrder.layer.cornerRadius = 20
        self.trackingOrder.layer.masksToBounds = true
        configureNavigationBar()
    }
    @IBAction func goView(_ sender: Any) {
        let view = OrderDetailViewController()
        view.hidesBottomBarWhenPushed = true
        view.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(view, animated: true)
    }
    

}

// MARK: Navigation bar
extension TrackingOrderViewController{
    
    // Configure navigation bar
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.changeBackgroundColor(backroundColor: .white)
        self.navigationItem.leftBarButtonItem = NavigationItem().itemBarbtn(icon: Asset.CartIcon.ic_back, target: self, selector: #selector(backToViewController), sizeIcon: 35)
    }
}

// MARK: Method Action
extension TrackingOrderViewController {
    
    @objc func backToViewController(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
