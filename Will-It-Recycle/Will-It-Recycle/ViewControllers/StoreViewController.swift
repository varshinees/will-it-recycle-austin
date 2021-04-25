
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

protocol Leaves {
    func displayLeaves(number: Int)
}

public struct StoreItem: Hashable {
    let item: String
    let cost: Int
    let key: String
    
    init(key:String, item: String, cost: Int) {
        self.item = item
        self.cost = cost
        self.key = key
    }
}

public var storeItems = [
    StoreItem(key: "solarPanel", item: "Solar Panel", cost: 50),
    StoreItem(key: "windTurbine", item: "Wind Turbine", cost: 60),
    StoreItem(key: "succulent", item: "Succulent", cost: 20),
    StoreItem(key: "tree", item: "Tree", cost: 50),
    StoreItem(key: "wateringCan", item: "Watering Can", cost: 40),
    StoreItem(key: "beehive", item: "Beehive", cost: 40),
    StoreItem(key: "seedling", item: "Seedling", cost: 30),
    StoreItem(key: "flower", item: "Flower", cost: 20)
]

class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, Leaves {
    
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
        backBtn.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0))
        
        //display number of leaves
        refreshLeaves()
        
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
        
        cell?.cellLabel.text = displayedItems[row].item
        cell?.detailLabel.text = "Cost: \(displayedItems[row].cost)"
        cell?.storeItem = displayedItems[row]
        cell?.delegate = self
        cell?.itemImage.image = UIImage(named: displayedItems[row].key)
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.displayedItems = storeItems
        tableView.reloadData()
        
        //display number of leaves
        refreshLeaves()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //search bar should filter searches
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
    
    //display number of current leaves
    func refreshLeaves() {
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
    
    //protocol method for table view cells
    func displayLeaves(number: Int) {
        self.leavesLabel.text = "WALLET: \(number) LEAVES"
    }
    
    //remove keyboard code
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
        
}
