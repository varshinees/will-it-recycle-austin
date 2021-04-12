//
//  InventoryTableViewCell.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/30/21.
//

import UIKit
import FirebaseUI
import Firebase

class InventoryTableViewCell: UITableViewCell {
    
    let ref = Database.database().reference()
    let user = Auth.auth().currentUser!
    
    var inventoryItem = gameItem(key: "", item: "", count: 0, coordinates: [])
    var tableView: UITableView!

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var placeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func onPlaceItem(_ sender: Any) {
         
        // update inventory in firebase
        self.ref.child("users/\(user.uid)/inventory/\(self.inventoryItem.key)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                if snapshot.value as! Int == 1 {
                    // remove from child's list
                    self.ref.child("users/\(self.user.uid)/inventory/\(self.inventoryItem.key)").removeValue()
                }
                else {
                    self.ref.child("users/\(self.user.uid)/inventory/\(self.inventoryItem.key)").setValue(snapshot.value as! Int - 1)
                }
            }
        }
        
        // update local inventory list
        var index = 0
        var removeIndex = -1
        for item in inventoryItems {
            if item.key == self.inventoryItem.key {
                // if count is 1, remove this item
                if item.count == 1 {
                    removeIndex = index
                }
                else {
                    item.decrementCount()
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)],
                                              with: .fade)
                }
            }
            index += 1
        }
        if removeIndex != -1 {
            inventoryItems.remove(at: removeIndex)
            // delete row
            self.tableView.deleteRows(at: [IndexPath(row: removeIndex, section: 0)], with: .fade)
        }
        
    }
    
}
