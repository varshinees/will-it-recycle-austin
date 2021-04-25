//
//  InventoryTableViewCell.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/30/21.
//

import UIKit

class InventoryTableViewCell: UITableViewCell {
    
    var inventoryItem = gameItem(key: "", item: "", count: 0, coordinates: [])
    var delegate: UIViewController!

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var placeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func onPlaceItem(_ sender: Any) {
        let mainVC = delegate as! InventoryItemPlacedChanger
        mainVC.setInventoryItemToPlace(item: inventoryItem)
    }
    
}
