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
    var indexPathSelected: Int?
    var selectedCategoryIndexPath: IndexPath?
    @IBOutlet weak var collectionCategory: UICollectionView!
    @IBOutlet weak var collectionProduct: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        setUpCollectView()
        category = loadCateData() ?? []
        product = loadProductData() ?? []
        filteredProduct = product
        collectionCategory.reloadData()
        collectionProduct.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
        collectionCategory.collectionViewLayout = LeftAlignedHorizontalCollectionViewFlowLayout()
        collectionCategory.delegate = self
        collectionCategory.dataSource = self
        
        
        //collectionProduct
        collectionProduct.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil),
                             forCellWithReuseIdentifier: "ProductCollectionViewCell")
        collectionProduct.delegate = self
        collectionProduct.dataSource = self
    }
    
    private func setWidthForCategoryCell(item: CategoryModel) -> CGFloat{
        let view = UILabel()
        view.text = item.name
        view.numberOfLines = 1
        view.sizeToFit()
        view.font = FontFamily.Montserrat.regular.font(size: 12)
        return view.frame.width + 35
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
            let width = setWidthForCategoryCell(item: category[indexPath.row] )
            return CGSize(width: width, height: 30)
        }
        let width = (self.collectionProduct.frame.width / 2) - 10
        return CGSize(width: width, height: 180)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

       if collectionView.numberOfItems(inSection: section) == 1 {

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: collectionView.frame.width - flowLayout.itemSize.width)

       }

       return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

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
        
        //mark favourite item
        let itemsWhichAreChecked = UserDefaults.standard.array(forKey: "drinkFavourite") as? [Int] ?? [Int]()
        if itemsWhichAreChecked.contains(currentProduct.idProduct) {
            cellProduct.btnAddToFavourite.setImage(UIImage(named: "ic_round-favorite-fill"), for: .normal)
        } else {
            cellProduct.btnAddToFavourite.setImage(UIImage(named: "ic_favories"), for: .normal)
        }
       
        cellProduct.favButtonPressed = { [weak self] in
            guard let self = self else { return }
            print("Favorite button pressed for product ID: \(product[indexPath.row].idProduct)")
            
            var itemsWhichAreChecked = UserDefaults.standard.array(forKey: "drinkFavourite") as? [Int] ?? [Int]()
            if itemsWhichAreChecked.contains(product[indexPath.row].idProduct) {
                if let removeId = itemsWhichAreChecked.lastIndex(where: { $0 == self.product[indexPath.row].idProduct }) {
                    itemsWhichAreChecked.remove(at: removeId)
                   cellProduct.btnAddToFavourite.setImage(UIImage(named: "ic_favories"), for: .normal)
                   print("Remove product \(product[indexPath.row].idProduct) from favourite")
               }
            } else {
                itemsWhichAreChecked.append(product[indexPath.row].idProduct)
               print("add product \(product[indexPath.row].idProduct) to favourite")
               cellProduct.btnAddToFavourite.setImage(UIImage(named: "ic_round-favorite-fill"), for: .normal)
            }
            UserDefaults.standard.set(itemsWhichAreChecked, forKey: "drinkFavourite")
            self.collectionProduct.reloadItems(at: [indexPath])
        }
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
            if previousIndexPath == indexPath{
                isSearching = false
                selectedCategoryIndexPath = nil
                collectionCategory.reloadData()
                collectionProduct.reloadData()
                return
            }else{
                selectedCategoryIndexPath = indexPath
            }
            

            // Reload collection view to update the selected state
//            collectionView.reloadItems(at: [previousIndexPath, indexPath].compactMap { $0 })
            collectionView.reloadData()
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

class LeftAlignedHorizontalCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    required override init() {super.init(); common()}
        required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); common()}
        
        private func common() {
            scrollDirection = .horizontal
            estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            minimumLineSpacing = -10
            minimumInteritemSpacing = 8
        }
        
        override func layoutAttributesForElements(
                        in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            
            guard let att = super.layoutAttributesForElements(in:rect) else {return []}
            
            let group = att.group(by: {$0.frame.origin.y})
            
            var x: CGFloat = sectionInset.left
            
            for attr in group {
                x = sectionInset.left
                for a in attr {
                    if a.representedElementCategory != .cell { continue }
                    a.frame.origin.x = x
                    x += a.frame.width + minimumInteritemSpacing
                }
            }
            return att
        }
}

extension Array {
    func group<T: Hashable>(by key: (_ element: Element) -> T) -> [[Element]] {
        var categories: [T: [Element]] = [:]
        var groups = [[Element]]()
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        categories.keys.forEach { key in
            if let group = categories[key] {
                groups.append(group)
            }
        }
        return groups
    }
}
