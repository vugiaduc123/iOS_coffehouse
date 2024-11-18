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
    var filteredProduct = [ProductModel]()
    var isSearching = false
    var selectedCategoryId: Int?
    var selectedCategoryIndexPath: IndexPath?
    @IBOutlet weak var collectionCategory: UICollectionView!
    @IBOutlet weak var collectionProduct: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        category = loadCateData() ?? []
        product = loadProductData() ?? []
        filteredProduct = product
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
        searchBar.delegate = self
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
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Add property to keep track of selected index path
   

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionCategory {
            return category.count
        }
        return isSearching ? filteredProduct.count : product.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionCategory {
            return CGSize(width: 100, height: 30)
        }
        return CGSize(width: 140, height: 175)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Category
        if collectionView == collectionCategory {
            let cellCategory = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            let categoryItem = category[indexPath.row]
            cellCategory.setUpCellCategory(categies: categoryItem)
            
            let isSelected = indexPath == selectedCategoryIndexPath
            cellCategory.setSelected(isSelected)
            
            return cellCategory
        }

        // Product
        let cellProduct = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        let currentProduct = isSearching ? filteredProduct[indexPath.row] : product[indexPath.row]
        cellProduct.sizes = currentProduct.size
        cellProduct.setUpCellProduct(products: currentProduct)
        cellProduct.delegate = self
        return cellProduct
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionCategory {
            selectedCategoryId = category[indexPath.row].idCategory // Assuming CategoryModel has an 'id' property

            // Filter products based on selected category ID
            filteredProduct = product.filter { $0.idCategory == selectedCategoryId }
            isSearching = true
            
            // Update selected index path
            let previousIndexPath = selectedCategoryIndexPath
            selectedCategoryIndexPath = indexPath

            // Reload collection view to update the selected state
            collectionView.reloadItems(at: [previousIndexPath, indexPath].compactMap { $0 })
            collectionProduct.reloadData()
        }
    }
    

}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredProduct = product
        } else {
            isSearching = true
            filteredProduct = product.filter { $0.nameProduct.lowercased().contains(searchText.lowercased()) }
        }
        collectionProduct.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        filteredProduct = product
        collectionProduct.reloadData()
        searchBar.resignFirstResponder()
    }
}
extension HomeViewController: ProductCollectionViewCellDelegate {
    func didTapFavoriteButton(for product: ProductModel) {
        var favouriteIds = SaveFavourite().getFavourite(key: "drinkFavourite") as? [Int] ?? []
        if favouriteIds.contains(product.idProduct) {
            favouriteIds.append(product.idProduct)
            SaveFavourite().saveFavourite(favouriteIds: favouriteIds, key: "drinkFavourite")
            print("Added \(product.idProduct) to favourites")
        } else {
            print("\(product.idProduct) is already in favourites")
        }
        
        // Navigate to FavouriteViewController
        let favouriteVC = FavouriteViewController()
        self.navigationController?.pushViewController(favouriteVC, animated: true)
    }
    
}
struct SaveFavourite {
    func saveFavourite(favouriteIds: [Int],key: String ) {
        UserDefaults.standard.setValue(favouriteIds, forKey: key)
    }
    func getFavourite(key: String) -> [Int]? {
       let arrayFavourite = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
        return arrayFavourite
    }
}
