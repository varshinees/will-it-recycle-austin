
//
//  StoreViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents.MaterialButtons
import Firebase
import FirebaseUI

public struct StoreItem: Hashable {
    let item: String
    let cost: Int
    let key: String
    let pic: UIImage
    
    init(key:String, item: String, cost: Int, pic: UIImage) {
        self.item = item
        self.cost = cost
        self.key = key
        self.pic = pic
    }
}

public var storeItems = [
    StoreItem(key: "solarPanel", item: "Solar Panel", cost: 50, pic: UIImage(named: "solarPanel")!),
    StoreItem(key: "windTurbine", item: "Wind Turbine", cost: 60, pic: UIImage(named: "windTurbine")!),
    StoreItem(key: "succulent", item: "Succulent", cost: 20, pic: UIImage(named: "succulent")!),
    StoreItem(key: "tree", item: "Tree", cost: 50, pic: UIImage(named: "tree")!),
    StoreItem(key: "wateringCan", item: "Watering Can", cost: 80, pic: UIImage(named: "wateringCan")!)
]

class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leavesLabel: UILabel!
    @IBOutlet weak var backBtn: MDCButton!
    @IBOutlet weak var tableView: UITableView!
    
    let ref = Database.database().reference()
    let user = Auth.auth().currentUser!
    
    var displayedItems = storeItems
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        backBtn.setTitle("BACK TO MY LAND", for: .normal)
        backBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        //display number of leaves
        self.ref.child("users/\(user.uid)/currentLeaves").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                DispatchQueue.main.async {
                    self.leavesLabel.text = "WALLET: \(snapshot.value as! Int) LEAVES"
                }
                
            }
            else {
                print("No data available")
            }
        }
        
    }
    @IBAction func backOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath as IndexPath) as? StoreTableViewCell
        let row = indexPath.row
//        let index = storeItems.firstIndex{$0.item == displayedItems[row].item}
        
        cell?.cellLabel.text = displayedItems[row].item
        cell?.detailLabel.text = "Cost: \(displayedItems[row].cost)"
//        cell?.itemKey = storeItems[row].key
        cell?.storeItem = displayedItems[row]
        cell?.delegate = self
        cell?.itemImage.image = displayedItems[row].pic
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.displayedItems = storeItems
        tableView.reloadData()
        
        //display number of leaves
        self.ref.child("users/\(user.uid)/currentLeaves").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                DispatchQueue.main.async {
                    self.leavesLabel.text = "WALLET: \(snapshot.value as! Int) LEAVES"
                }
                
            }
            else {
                print("No data available")
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.displayedItems = storeItems
        } else {
            self.displayedItems = storeItems.filter {
                $0.item.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        tableView.reloadData()
    }
    
    func searchBarButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.displayedItems = storeItems
        tableView.reloadData()
    }
        
}
