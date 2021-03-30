//
//  InventoryViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialList


class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    
    let items = ["Solar Panels", "Wind Turbines", "Watering Cans", "Succulents", "Mulch", "Beehive", "Shovels", "Whellbarrows", "Seeds", "Trees"]
    let quantity = ["3", "1", "2", "1", "1", "2", "1", "1", "50", "10"]


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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath as IndexPath) as? InventoryTableViewCell
        let row = indexPath.row
        cell?.cellLabel.text = items[row] + " (" + quantity[row] + ")"
        return cell!
    }
    
    


}
