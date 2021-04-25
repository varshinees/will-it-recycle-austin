//
//  InventoryViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialList

public class gameItem {
    let key: String
    let item: String
    var count: Int
    var coordinates: [String]
    
    init(key: String, item: String, count: Int, coordinates: [String]) {
        self.key = key
        self.item = item
        self.count = count
        self.coordinates = coordinates
    }
    
    func decrementCount () {
        self.count -= 1
    }
    
    func incrementCount () {
        self.count += 1
    }
}

public var inventoryItems = [gameItem]()
public var activeItems = [gameItem]()

protocol InventoryItemPlacedChanger {
    func setInventoryItemToPlace(item: gameItem)
}

protocol localListChanger {
    func changeInventoryList(inventory: [gameItem])
    func changeActiveItemsList(activeList: [gameItem])
}

class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, InventoryItemPlacedChanger, localListChanger {
    
    @IBOutlet weak var backBtn: MDCButton!
    @IBOutlet weak var tableView: UITableView!
    
    var inventoryItem = gameItem(key: "", item: "", count: 0, coordinates: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        backBtn.setTitle("BACK TO MY LAND", for: .normal)
        backBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        backBtn.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func backOnClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return inventoryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath as IndexPath) as? InventoryTableViewCell
        let row = indexPath.row
        cell?.cellLabel.text = inventoryItems[row].item + " (\(inventoryItems[row].count))"
        cell?.inventoryItem = inventoryItems[row]
        cell?.delegate = self
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlacementSegueId",
           let placementGridViewController = segue.destination as? PlacementGridViewController {
            placementGridViewController.delegate = self
            placementGridViewController.activeItem = inventoryItem
        }
    }
    
    func setInventoryItemToPlace (item: gameItem) {
        self.inventoryItem = item
    }
    
    func changeInventoryList(inventory: [gameItem]) {
        inventoryItems = inventory
    }
    
    func changeActiveItemsList(activeList: [gameItem]) {
        activeItems = activeList
    }

}
