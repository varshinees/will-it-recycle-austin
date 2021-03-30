
//
//  StoreViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialList


class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    let items = ["Solar Panel", "Wind Turbine", "Succulent", "Tree", "Watering Can"]
    let details = ["Generates 3 leaves/day | Cost: 50 leaves", "Generates 5 leaves/day | Cost: 60 leaves", "Looks adorable | Cost: 20 leaves", "Generates 3 leaves/day | Cost: 50 leaves", "Doubles leaf generation | Cost: 80 leaves" ]
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath as IndexPath) as? StoreTableViewCell
        let row = indexPath.row
        cell?.cellLabel.text = items[row]
        cell?.detailLabel.text = details[row]
        return cell!
    }
    

}
