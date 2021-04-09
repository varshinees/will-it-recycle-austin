//
//  ManualEntryViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialList

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
    

//    @IBOutlet weak var backBtn: MDCButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var redeemBtn: MDCButton!
    @IBOutlet weak var tableView: UITableView!
    
    var quantities:[Int] = [Int](repeating: 0, count: manualEntryData.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        backBtn.setTitle("< BACK", for: .normal)
//        backBtn.setTitleColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), for: .normal)
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
        do {
            try quantities[textField.tag] = Int(textField.text!) ?? 0
        } catch {
            return
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    
    @IBAction func redeemButtonPressed(_ sender: Any) {
        for quantity in quantities {
            // reset all textFields
            quantities = [Int](repeating: 0, count: manualEntryData.count)
            
            // calculate number of leaves earned
        }
        
        // update number of leaves and total earned leaves
    }
    
    // code to enable tapping on the background to remove software keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    


    
}
