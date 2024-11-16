//
//  HomeViewController.swift
//  CoffeHouse
//
//  Created by MacOs on 05/11/2024.
//

import UIKit
import SDWebImage
class HomeViewController: UIViewController {
    var category = [CategoryModel]()
    var product = [ProductModel]()
    @IBOutlet weak var collectionCategory: UICollectionView!
    @IBOutlet weak var collectionProduct: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        category = loadCateData() ?? []
        product = loadProductData() ?? []
        setUpCollectView()
    }
    @IBAction func didTapLocation(_ sender: Any) {
        self.navigationController?.pushViewController(LocationViewController(), animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
}
// MARK: Layout and Config
extension HomeViewController {
    func setUpSearchBar() {
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.backgroundColor = UIColor.white
        }
        searchBar.layer.cornerRadius = 28
        searchBar.layer.masksToBounds = true
        searchBar.layer.borderColor = UIColor(.black).cgColor
        searchBar.layer.borderWidth = 1.0
    }
    private func setUpCollectView() {
        //collectionCategory
        collectionCategory.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
                             forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        collectionCategory.delegate = self
        collectionCategory.dataSource = self
        //collectionProduct
        collectionProduct.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil),
                             forCellWithReuseIdentifier: "ProductCollectionViewCell")
        collectionProduct.delegate = self
        collectionProduct.dataSource = self
    }
}

// MARK: METHOD
extension HomeViewController {
    private func loadProductData() -> [ProductModel]? {
        guard let fileURL = Bundle.main.url(forResource: "Product", withExtension: "json") else {
            print("file not found.")
            return nil
        }
        do {
            let proData = try Data(contentsOf: fileURL)
            let products =  try JSONDecoder().decode([ProductModel].self, from: proData)
            print("\(products.count)")
            return products
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    private func loadCateData() -> [CategoryModel]? {
        guard let fileURL = Bundle.main.url(forResource: "Category", withExtension: "json") else {
            print("file not found.")
            return nil
        }
        do {
            let cateData = try Data(contentsOf: fileURL)
            let cates =  try JSONDecoder().decode([CategoryModel].self, from: cateData)
            print("\(cates.count)")
            return cates
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: COLLETION, TABLEVIEW
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  collectionView == collectionCategory {
            return category.count
        }
            return product.count
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if  collectionView == collectionCategory {
            return CGSize(width: 100, height: 30)
        }
            return CGSize(width: 140, height: 175)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Category
        if  collectionView == collectionCategory {
            let cellCategory = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cellCategory.setUpCellCategory(categies: category[indexPath.row])
            return cellCategory
        }
        //Product
        let cellProduct = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        cellProduct.sizes = product[indexPath.row].size
        cellProduct.setUpCellProduct(products: product[indexPath.row])
        return cellProduct
    }
}

