
//
//  StoreViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents.MaterialButtons

public struct StoreItem: Hashable {
    let id: Int
    let item: String
    let cost: Int
    let key: String
    
    init(id: Int, item: String, cost: Int, key:String) {
        self.id = id
        self.item = item
        self.cost = cost
        self.key = key
    }
}

public var storeItems = [
    StoreItem(id: 0, item: "Solar Panel", cost: 50, key: "solarPanel"),
    StoreItem(id: 1, item: "Wind Turbine", cost: 60, key: "windTurbine"),
    StoreItem(id: 2, item: "Succulent", cost: 20, key: "succulent"),
    StoreItem(id: 3, item: "Tree", cost: 50, key: "tree"),
    StoreItem(id: 4, item: "Watering Can", cost: 80, key: "wateringCan")
]

class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leavesLabel: UILabel!
    @IBOutlet weak var backBtn: MDCButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        backBtn.setTitle("BACK TO MY LAND", for: .normal)
        backBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
    }
    @IBAction func backOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath as IndexPath) as? StoreTableViewCell
        let row = indexPath.row
        cell?.cellLabel.text = storeItems[row].item
        cell?.detailLabel.text = "Cost: \(storeItems[row].cost)"
//        cell?.itemKey = storeItems[row].key
        cell?.storeItem = storeItems[row]
        
        return cell!
    }
    

}
