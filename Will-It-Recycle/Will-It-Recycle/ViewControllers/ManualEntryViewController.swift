//
//  ManualEntryViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialList
import Firebase

public struct ManualEntryItem: Hashable {
    let value: Int
    let name: String
    
    init(value: Int, name: String) {
        self.name = name
        self.value = value
    }
}

public var manualEntryData = [
    ManualEntryItem(value: 2, name: "Aluminum Can"),
    ManualEntryItem(value: 2, name: "Plastic Bottle"),
    ManualEntryItem(value: 3, name: "Cardboard Box"),
    ManualEntryItem(value: 2, name: "Glass Bottle"),
    ManualEntryItem(value: 2, name: "Mixed Paper"),
    ManualEntryItem(value: 1, name: "Tin Can"),
    ManualEntryItem(value: 1, name: "Plastic Utencils"),
    ManualEntryItem(value: 1, name: "Paperboard"),
    ManualEntryItem(value: 1, name: "Aluminum Foil"),
]

class RecycleDropdownCell: UITableViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemField: UITextField!
    
}

class ManualEntryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var redeemBtn: MDCButton!
    @IBOutlet weak var tableView: UITableView!
    
    var quantities:[Int] = [Int](repeating: 0, count: manualEntryData.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        redeemBtn.setTitle("REDEEM", for: .normal)
        redeemBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    // returns the length of the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manualEntryData.count
    }
    
    // sets a height for the rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // creates and returns a cell for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // creates the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecycleDropdownCell", for: indexPath as IndexPath) as! RecycleDropdownCell
        let row = indexPath.row
        
        // sets the label values for the cell
        cell.itemLabel?.text = manualEntryData[row].name
        cell.itemField?.placeholder = "0"
        cell.itemField.delegate = self
        cell.itemField?.tag = row
        
        if (quantities[row] != 0) {
            cell.itemField?.text = "\(quantities[row])"
        } else {
            cell.itemField?.text = "0"
        }
        
        return cell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        quantities[textField.tag] = Int(textField.text!) ?? 0

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    
    @IBAction func redeemButtonPressed(_ sender: Any) {
        var leaves = 0
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        // get the current date and time
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        let dateString = formatter.string(from: currentDateTime)
        
        for i in 0...quantities.count-1 {
            // calculate number of leaves earned
            leaves += quantities[i] * manualEntryData[i].value
            
            if (quantities[i] > 0) {
                
                // update name + quantity + date to firebase
                guard let key = ref.child("users/\(Auth.auth().currentUser!.uid)/").childByAutoId().key else { return }
                
                let item = ["date": dateString,
                            "name": manualEntryData[i].name,
                            "quantity": quantities[i]] as [String : Any]
                let childUpdates = ["users/\(Auth.auth().currentUser!.uid)/history/\(key)": item]
                ref.updateChildValues(childUpdates)
            }
            
        }
        
        // if no leaves earned, pop up error alert
        if leaves == 0 {
            let controller = UIAlertController(
                title: "No items entered",
                message: "Please enter at least one quantity",
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "OK",
                                    style: .default,
                                    handler: nil))
            present(controller, animated: true, completion: nil)
            return
        }
        
        // update number of leaves and total earned leaves
        ref.child("users/\(Auth.auth().currentUser!.uid)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                guard let user = snapshot.value as? [String: Any] else {
                      return
                    }
                
                let childUpdates:[String: Int] = ["users/\(Auth.auth().currentUser!.uid)/currentLeaves": Int(user["currentLeaves"] as! Int) + leaves,
                                    "users/\(Auth.auth().currentUser!.uid)/allTimeLeaves": Int(user["allTimeLeaves"] as! Int) + leaves]
                ref.updateChildValues(childUpdates)
            }
            else {
                print("User does not exist")
            }
        }
        
        // send alert that indicates amount earned
        let controller = UIAlertController(
            title: "Success! 🌱",
            message: "You have added \(leaves) leaves to your account.",
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(
                                title: "Continue",
                                style: .default,
                                handler: nil))
        present(controller, animated: true, completion: nil)
        
        // reset all textFields
        quantities = [Int](repeating: 0, count: manualEntryData.count)
        tableView.reloadData()
    }
    
    // code to enable tapping on the background to remove software keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
 
}
