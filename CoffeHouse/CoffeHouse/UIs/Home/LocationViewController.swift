//
//  LocationViewController.swift
//  CoffeHouse
//
//  Created by MacOs on 05/11/2024.
//

import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        
    }
    
    
    @IBAction func didTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: Layout and Config
extension LocationViewController{
    func setUpSearchBar(){
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.backgroundColor = UIColor.white
        }
        searchBar.layer.cornerRadius = 28
        searchBar.layer.masksToBounds = true
        searchBar.layer.borderColor = UIColor(.black).cgColor
        searchBar.layer.borderWidth = 1.0
    }
}

// MARK: METHOD
extension LocationViewController{
    
}

// MARK: COLLETION, TABLEVIEW
