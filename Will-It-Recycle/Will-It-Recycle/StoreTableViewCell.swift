//
//  StoreTableViewCell.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import FirebaseUI
import Firebase

class StoreTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    var delegate: UIViewController!
    
    let ref = Database.database().reference()
    
    var storeItem:StoreItem!
    
    let user = Auth.auth().currentUser!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func buyOnClick(_ sender: Any) {
        
        var currentLeaves:Int!
        
        //update number of leaves in firebase
        self.ref.child("users/\(user.uid)/currentLeaves").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                //subtract cost from currentLeaves
                currentLeaves = snapshot.value! as! Int
                if snapshot.value as! Int - self.storeItem.cost >= 0 {
                    self.ref.child("users/\(self.user.uid)/currentLeaves").setValue(snapshot.value as! Int - self.storeItem.cost)
                    let storeVC = self.delegate as! Leaves
                    DispatchQueue.main.async {
                        storeVC.displayLeaves(number: snapshot.value as! Int - self.storeItem.cost)
                    }
                }
            }
            else {
                print("No data available")
            }
        }
        
        //update inventory array in firebase
        self.ref.child("users/\(user.uid)/inventory/\(storeItem.key)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                if currentLeaves! - self.storeItem.cost >= 0 {
                //add to firebase
                    self.ref.child("users/\(self.user.uid)/inventory/\(self.storeItem.key)").setValue(snapshot.value as! Int + 1)
                    //add to global inventory array
                    inventoryItems.append(gameItem(key: self.storeItem.key, item: self.storeItem.item, count: snapshot.value as! Int + 1, coordinates: []))
                    self.successAlert()
                } else {
                    self.errorAlert()
                }
            }
            else {
                if currentLeaves! - self.storeItem.cost >= 0 {
                    //add to firebase
                    self.ref.child("users/\(self.user.uid)/inventory/\(self.storeItem.key)").setValue(1)
                    //add to global inventory array
                    inventoryItems.append(gameItem(key: self.storeItem.key, item: self.storeItem.item, count: 1, coordinates: []))
                    self.successAlert()
                } else {
                    self.errorAlert()
                }
            }
        }
        
    }
    
    //alert for unsuccessful purchase
    func errorAlert() {
        DispatchQueue.main.async {
            let controller = UIAlertController(
                title: "Not enough leaves ☹️",
                message: "Recycle more to earn leaves!",
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "OK",
                                    style: .default,
                                    handler: nil))
            self.delegate.present(controller, animated: true, completion: nil)
        }
    }
    
    //alert for successful purchase
    func successAlert() {
        DispatchQueue.main.async {
            let controller = UIAlertController(
                title: "Purchase Success! 😄",
                message: "Item has been added to your inventory",
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "OK",
                                    style: .default,
                                    handler: nil))
            self.delegate.present(controller, animated: true, completion: nil)
        }
        
    }
    
}
