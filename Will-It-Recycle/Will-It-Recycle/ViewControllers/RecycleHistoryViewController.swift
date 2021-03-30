//
//  RecycleHistoryViewController.swift
//  Will-It-Recycle
//
//  Created by Victoria Denney on 3/28/21.
//

import UIKit
import MaterialComponents.MaterialList

public struct RecycleHistoryItem: Hashable {
    let id: Int
    let item: String
    let count: String
    let date: String
    
    init(id: Int, item: String, count: String, date: String) {
        self.id = id
        self.item = item
        self.count = count
        self.date = date
    }
}

public var recycleHistoryData = [
    RecycleHistoryItem(id: 0, item: "Cereal Box", count: "2", date: "3/28/2021"),
    RecycleHistoryItem(id: 1, item: "Mail", count: "1", date: "3/28/2021"),
    RecycleHistoryItem(id: 2, item: "Newspaper", count: "10", date: "3/28/2021"),
    RecycleHistoryItem(id: 3, item: "Soda Can", count: "5", date: "3/27/2021"),
    RecycleHistoryItem(id: 4, item: "Magazine", count: "3", date: "3/27/2021"),
    RecycleHistoryItem(id: 5, item: "Water Bottle", count: "1", date: "3/27/2021"),
    RecycleHistoryItem(id: 6, item: "Milk Carton", count: "2", date: "3/26/2021"),
    RecycleHistoryItem(id: 7, item: "Juice Box", count: "1", date: "3/26/2021"),
    RecycleHistoryItem(id: 8, item: "Paper Towel Roll", count: "1", date: "3/26/2021"),
    RecycleHistoryItem(id: 9, item: "Moving Box", count: "2", date: "3/20/2021"),
    RecycleHistoryItem(id: 10, item: "Cardboard Box", count: "1", date: "3/20/2021"),
    RecycleHistoryItem(id: 11, item: "Aluminum Foil", count: "2", date: "3/20/2021"),
    RecycleHistoryItem(id: 12, item: "Printer Paper", count: "10", date: "3/20/2021")
]

class RecycleHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var returnToSettingsButton: MDCButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        returnToSettingsButton.setTitle("BACK TO SETTINGS", for: .normal)
        returnToSettingsButton.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        returnToSettingsButton.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
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
