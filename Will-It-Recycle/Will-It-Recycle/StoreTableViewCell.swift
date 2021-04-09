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
    
    let ref = Database.database().reference()
    
    var storeItem:StoreItem!
    
    let user = Auth.auth().currentUser!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buyOnClick(_ sender: Any) {
        
        //update number of leaves in firebase
        self.ref.child("users/\(user.uid)/currentLeaves").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
//                print("Got data \(snapshot.value!)")
                if snapshot.value as! Int - self.storeItem.cost > 0 {
                    self.ref.child("users/\(self.user.uid)/currentLeaves").setValue(snapshot.value as! Int - self.storeItem.cost)
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
//                print("Got data \(snapshot.value!)")
                self.ref.child("users/\(self.user.uid)/inventory/\(self.storeItem.key)").setValue(snapshot.value as! Int + 1)
            }
            else {
//                print("No data available")
                self.ref.child("users/\(self.user.uid)/inventory/\(self.storeItem.key)").setValue(1)
                
            }
        }

    }
    
}
