//
//  RemoveItemViewController.swift
//  Will-It-Recycle
//
//  Created by Victoria Denney on 4/24/21.
//

import UIKit
import FirebaseUI
import Firebase
import MaterialComponents

class RemoveItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeButton: MDCButton!
    
    var delegate: UIViewController!
    let ref = Database.database().reference()
    let user = Auth.auth().currentUser!
    var selectedCoordinate = String()
    var selectedItem = gameItem(key: "", item: "", count: 0, coordinates: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        removeButton.setTitle("REMOVE", for: .normal)
        removeButton.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        removeButton.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return coordinatesOccupied.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath as IndexPath) as? UITableViewCell
        let row = indexPath.row
        let selectedItem = findActiveItemCoordinate(coordinate: coordinatesOccupied[row])
        cell?.textLabel!.text = "\(selectedItem.item) : \(coordinatesOccupied[row])"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        selectedCoordinate = coordinatesOccupied[row]
    }
    
    @IBAction func onRemove(_ sender: Any) {
        
        if selectedCoordinate.count > 0 {
            // remove from coordinatesOccupied list
            var removeIndex = -1
            var index = 0;
            for coordinate in coordinatesOccupied {
                if coordinate == selectedCoordinate {
                    removeIndex = index
                }
                index += 1
            }
            if removeIndex != -1 {
                coordinatesOccupied.remove(at: removeIndex)
            }
            
            selectedItem = findActiveItemCoordinate(coordinate: selectedCoordinate)
            // remove from activeItems local list
            for item in activeItems {
                var removeIndex = -1
                var index = 0;
                for coordinate in item.coordinates {
                    if coordinate == selectedCoordinate {
                        removeIndex = index
                    }
                    index += 1
                }
                if removeIndex != -1 {
                    item.coordinates.remove(at: removeIndex)
                }
            }
            let mainVC = self.delegate as! activeListChanger
            mainVC.changeActiveItemsList(activeList: activeItems)
            
            // remove item's coordinate from active list in firebase or remove altogether
            self.ref.child("users/\(self.user.uid)/activeItems/\(selectedItem.key)").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    let activeItemsData = snapshot.value as! [String]
                    self.ref.child("users/\(self.user.uid)/activeItems/\(self.selectedItem.key)").removeValue()
                    
                    if activeItemsData.count > 1 {
                        var index = 0
                        for coordinate in activeItemsData {
                            if coordinate != self.selectedCoordinate {
                                self.ref.child("users/\(self.user.uid)/activeItems/\(self.selectedItem.key)").child(String(index)).setValue(coordinate)
                                index += 1
                            }
                        }
                    }
                }
            }
            
            removeIndex = -1
            index = 0;
            for item in inventoryItems {
                if item.item == selectedItem.item {
                    if item.count > 1 {
                        item.incrementCount()
                    } else {
                        removeIndex = index
                    }
                }
                index += 1
            }
            if removeIndex != -1 {
                coordinatesOccupied.remove(at: removeIndex)
            }
            // add inventory item count in firebase or create new item
            self.ref.child("users/\(user.uid)/inventory/\(selectedItem.key)").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    let newCount = (snapshot.value as! Int) + 1
                    self.ref.child("users/\(self.user.uid)/inventory/\(self.selectedItem.key)").setValue(newCount)
                }
                else {
                    self.ref.child("users/\(self.user.uid)/inventory").child(self.selectedItem.key).setValue(1)
                }
            }
            
            // dismiss screen back to my land
            self.navigationController?.popViewController(animated: true)
        } else {
            // alert to select a coordinate
            let controller = UIAlertController(
                title: "Invalid input",
                message: "Please select an item to remove",
                preferredStyle: .alert
            )
            
            controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(controller, animated: true, completion: nil)
        }
    }
    
    func findActiveItemCoordinate (coordinate: String) -> gameItem {
        var itemFound = gameItem(key: "", item: "", count: 0, coordinates: [])
        for item in activeItems {
            for thisCoordinate in item.coordinates {
                if thisCoordinate == coordinate {
                    itemFound = item
                }
            }
        }
        return itemFound
    }
    
}
