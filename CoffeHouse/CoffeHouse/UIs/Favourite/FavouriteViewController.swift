//
//  FavouriteViewController.swift
//  CoffeHouse
//
//  Created by Apple on 14/11/24.
//

import UIKit

class FavouriteViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let cellSpacingHeight: CGFloat = 1
    
    var favouriteProducts: [ProductModel] =  []
    var filterProducts: [ProductModel] = []
    var products: [ProductModel] = []
    var isFiltering: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        loadProductData()
        loadFavourites()
        filterProducts = favouriteProducts
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        config()
        loadProductData()
        loadFavourites()
    }
    
    func config() {
        configSearchBar()
        configTableView()
    }
}

//MARK: Method
extension FavouriteViewController {
    //load product json
    func loadProductData() {
        guard let fileURL = Bundle.main.url(forResource: "Product", withExtension: "json") else {
            print("File not found.")
            return
        }
        
        do {
               let data = try Data(contentsOf: fileURL)
               products = try JSONDecoder().decode([ProductModel].self, from: data)
           } catch {
               print(error.localizedDescription)
           }
    }
    
    //load favouries from userdefault
    func loadFavourites() {
        let favouriteIds = UserDefaults.standard.array(forKey: "drinkFavourite") as? [Int] ?? []
        print(favouriteIds)
        favouriteProducts = products.filter {favouriteIds.contains($0.idProduct)}
        tableView.reloadData()
    }
}

//MARK: - config
extension FavouriteViewController {
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavouriteCell", bundle: .main), forCellReuseIdentifier: "FavouriteCell")
    }
    
    func configSearchBar() {
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.backgroundColor = UIColor.white
        }
        searchBar.layer.cornerRadius = 28
        searchBar.layer.masksToBounds = true
        searchBar.layer.borderColor = UIColor.black.cgColor
        searchBar.layer.borderWidth = 1.0
        
        searchBar.delegate = self
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension FavouriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering ? filterProducts.count : favouriteProducts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as? FavouriteCell else {
            return UITableViewCell()
        }
        
        let product = isFiltering ? filterProducts[indexPath.section] : favouriteProducts[indexPath.section]
        cell.bind(with: product)
        
        cell.favButtonPressed = { [weak self] in
            var favouriteIds = UserDefaults.standard.array(forKey: "drinkFavourite") as? [Int] ?? []
            
            if favouriteIds.contains(product.idProduct) {
                if let index = favouriteIds.lastIndex(where: { $0 == product.idProduct }) {
                    favouriteIds.remove(at: index)
                }
            }
            self?.favouriteProducts.removeAll { $0.idProduct == product.idProduct }
            UserDefaults.standard.setValue(favouriteIds, forKey: "drinkFavourite")
            self?.tableView.reloadData()
        }
        
        return cell
    }
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
}

//MARK: - UISearchBarDelegate
extension FavouriteViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isFiltering = false
            filterProducts = favouriteProducts
        } else {
            isFiltering = true
            filterProducts = favouriteProducts.filter { product in
                return product.nameProduct.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

