//
//  RecycleHistoryViewController.swift
//  Will-It-Recycle
//
//  Created by Victoria Denney on 3/28/21.
//

import UIKit
import MaterialComponents.MaterialList
import Firebase
import Foundation

public struct RecycleHistoryItem: Hashable {
    let item: String
    let count: String
    let date: String
    
    init(item: String, count: String, date: String) {
        self.item = item
        self.count = count
        self.date = date
    }
}

class RecycleHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var returnToSettingsButton: MDCButton!
    @IBOutlet weak var tableView: UITableView!
    
    var recycleHistoryData:[RecycleHistoryItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        returnToSettingsButton.setTitle("BACK TO SETTINGS", for: .normal)
        returnToSettingsButton.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        returnToSettingsButton.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        do {
          
        // retrieves data from Firebase
         try ref.child("users/\(Auth.auth().currentUser!.uid)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                guard let user = snapshot.value as? [String: Any] else {
                      return
                    }
                
                guard let history = user["history"] as? [String:[String:Any]] else {
                      return
                    }
                
                // loops through items in history and adds them to the array
                for (_, item) in history {
                    
                    let name = item["name"] as! String
                    let quantity = String(item["quantity"] as! Int)
                    let date = item["date"] as! String
                    
                    let historyItem = RecycleHistoryItem(item: name, count: quantity, date: date)
                    self.recycleHistoryData.append(historyItem)
                }
                
                DispatchQueue.main.async {
                    self.recycleHistoryData = self.recycleHistoryData.sorted(by: { $0.date < $1.date })
                    self.tableView.reloadData()
                }
                
                
            }
            else {
                print("User does not exist")
            }
        }
        } catch {
            print("Error loading data")
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recycleHistoryData.count
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recycleHistoryCell", for: indexPath as IndexPath) as? RecycleHistoryTableViewCell
        let row = indexPath.row
        cell?.recycledItemCount.text = recycleHistoryData[row].item + " (x" + recycleHistoryData[row].count + ")"
        cell?.recycleDate.text = recycleHistoryData[row].date
        return cell!
    }
    
}
