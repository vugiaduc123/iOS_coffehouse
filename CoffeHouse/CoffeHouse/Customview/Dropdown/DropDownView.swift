//
//  Library.swift
//  Convert
//
//  Created by Vũ Đức on 09/03/2022.
//

import Foundation
import UIKit

public class DropDownView:UIView{
    private var openDirection: OpenDirection?
    // Open direction
    enum OpenDirection {
        case top
        case bottom
        case left
        case right
        
    }
    
    let cellDrop = "DropDownTableViewCell"
    lazy var transparentView = UIView()
    lazy var heightNavBar:CGFloat = 0.0
    
    lazy var tableView: UITableView = {
        
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        //   tv.backgroundColor = .lightGray
        tv.isUserInteractionEnabled = true
        tv.allowsSelection = true
        tv.allowsSelectionDuringEditing = true
        return tv
    }()
    
    var frameTable: CGRect?
    
    var bacData: ((String, Int, String) -> () )?
    
    lazy var icons:[String] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    lazy var listName:[String] = []
    lazy var listId:[Int] = []
    
    private var tap: UITapGestureRecognizer!
    
    // Mark: you can set any additional properties in it.
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DropDownTableViewCell.self, forCellReuseIdentifier: cellDrop)
        
    }
    
    convenience init(frame: CGRect, navController: UINavigationController, openDirection: OpenDirection, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor){
        self.init(frame: frame)
        // calls the initializer above
        self.openDirection = openDirection
        self.frameTable = frame
        let height:CGFloat = CGFloat(listName.count * 40)
        addTransparentView(locationView: frame, navView: navController, heightTableView: height, cornerRadius: cornerRadius, borderWidth: borderWidth, borderColor: borderColor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func awakeFromNib() {
        
    }
    
    func addTransparentView(locationView: CGRect, navView: UINavigationController, heightTableView: CGFloat, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor){
        var mainWindow = UIWindow()
        if #available(iOS 15, *) {
            let scenes = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene })
            mainWindow = (scenes.first(where: { $0.keyWindow != nil })?.keyWindow)!
            guard mainWindow.windowScene?.windows != nil else { return }
            heightNavBar = ((mainWindow.windowScene?.statusBarManager?.statusBarFrame.height)!) + (navView.navigationBar.frame.height)
        } else {
            mainWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first!
            guard mainWindow.windowScene?.windows != nil else { return }
            let scene = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height
            heightNavBar = (scene ?? 0.0) +
            (navView.navigationBar.frame.height)
        }
        transparentView.frame = mainWindow.frame
        mainWindow.addSubview(transparentView)
        self.tap = UITapGestureRecognizer(target: self, action: #selector(DropDownView.removeTransparentView))
        self.tap.delegate = self
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = false
        transparentView.addGestureRecognizer(tap)
        mainWindow.addSubview(tableView)
        runOption(openDirection: openDirection!, heightTableView: 200)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.transparentView.alpha = 0.5
        }, completion: nil)
        
    }
    
    @objc func removeTransparentView(){
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: { [self] in
            self.transparentView.alpha = 0
            self.removeFromSuperview()
            deleteviewOption(openDirection: openDirection!, heightTableView: 0)
        }, completion: nil)
    }
    
    func runOption(openDirection: OpenDirection, heightTableView: CGFloat){
        
        if let frame = frameTable{
            
            var frameOption:CGRect?
            var frameDefault:CGRect?
            switch openDirection {
            case .top:
                frameDefault = CGRect(x: frame.origin.x, y: (frame.minY + heightNavBar), width: frame.width, height: 0)
                frameOption = CGRect(x: frame.origin.x, y: ((frame.minY + heightNavBar) - heightTableView) - 5, width: frame.width, height: heightTableView)
            case .bottom:
                frameDefault = CGRect(x: frame.origin.x, y: (frame.maxY + heightNavBar) + 5, width: frame.width, height: 0)
                frameOption = CGRect(x: frame.origin.x, y: (frame.maxY + heightNavBar) + 5, width: frame.width, height: heightTableView)
            case .right:
                frameDefault = CGRect(x: frame.maxX + 5, y: (frame.maxY + heightNavBar) + 5, width: frame.width, height: 0)
                frameOption = CGRect(x: frame.maxX + 5, y: (frame.maxY + heightNavBar) + 5, width: frame.width, height: heightTableView)
            case .left:
                frameDefault = CGRect(x: (frame.minX - frame.width) - 5, y: (frame.maxY + heightNavBar) + 5, width: frame.width, height: 0)
                frameOption = CGRect(x: (frame.minX - frame.width) - 5, y: (frame.maxY + heightNavBar) + 5, width: frame.width, height: heightTableView)
            }
            
            tableView.frame = frameDefault!
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: { [self] in
                tableView.frame = frameOption!
            }, completion: nil)
            
        }
        
    }
    
    func deleteviewOption(openDirection: OpenDirection, heightTableView: CGFloat){
        if let frame = frameTable{
            switch openDirection {
            case .top:
                tableView.frame = CGRect(x: frame.origin.x, y: (frame.minY - heightTableView) - 5, width: frame.width, height: heightTableView)
            case .bottom:
                tableView.frame = CGRect(x: frame.origin.x, y: frame.maxY + 5, width: frame.width, height: heightTableView)
            case .right:
                tableView.frame = CGRect(x: frame.maxX + 5, y: frame.maxY + 5, width: frame.width, height: heightTableView)
            case .left:
                tableView.frame = CGRect(x: (frame.minX - frame.width) - 5, y: frame.maxY + 5, width: frame.width, height: heightTableView)
            }
        }
        
    }
    
}


extension DropDownView:UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listName.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellDrop, for: indexPath) as! DropDownTableViewCell
        let  itemTitle = listName[indexPath.row]
        let  itemIcon = icons[indexPath.row]
        cell.bindingData(title: itemTitle, icon: itemIcon)
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = true
        return cell
    }
}


extension DropDownView:UITableViewDelegate{
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cezTitle = listName[indexPath.row]
        let cezId = listId[indexPath.row]
        let cezIcon = icons[indexPath.row]
        bacData!(cezTitle, cezId, cezIcon)
        remove()
    }
    func remove(){
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: { [self] in
            self.transparentView.alpha = 0
            self.removeFromSuperview()
            deleteviewOption(openDirection: openDirection!, heightTableView: 0)
        }, completion: nil)
    }
}


extension DropDownView : UIGestureRecognizerDelegate
{
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: tableView))!
        {
            return false
        }
        return true
    }
}
