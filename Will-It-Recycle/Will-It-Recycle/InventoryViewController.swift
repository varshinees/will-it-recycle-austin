//
//  InventoryViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialList

public struct InventoryItem: Hashable {
    let id: Int
    let item: String
    let count: String
    let button: String
    
    init(id: Int, item: String, count: String, button: String) {
        self.id = id
        self.item = item
        self.count = count
        self.button = button
    }
}

public var inventoryData = [
    InventoryItem(id: 0, item: "Solar Panels", count: "3", button: "PLACE"),
    InventoryItem(id: 1, item: "Wind Turbines", count: "1", button: "PLACE"),
    InventoryItem(id: 2, item: "Watering Cans", count: "2", button: "PLACE"),
    InventoryItem(id: 3, item: "Succulents", count: "1", button: "PLACE"),
    InventoryItem(id: 4, item: "Mulch", count: "1", button: "PLACE"),
    InventoryItem(id: 5, item: "Beehive", count: "2", button: "PLACE"),
    InventoryItem(id: 6, item: "Shovels", count: "1", button: "PLACE"),
    InventoryItem(id: 7, item: "Wheelbarrows", count: "1", button: "PLACE"),
    InventoryItem(id: 8, item: "Seeds", count: "50", button: "PLACE"),
    InventoryItem(id: 9, item: "Trees", count: "10", button: "PLACE"),
    
]

class InventoryViewController: UIViewController {

    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, InventoryItem>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, InventoryItem>!
    
    @IBOutlet weak var inventoryCollectionView: UICollectionView!
    @IBOutlet weak var backBtn: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backBtn.setTitle("BACK TO MY LAND", for: .normal)
        backBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
//        backBtn.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
        inventoryCollectionView.backgroundColor = UIColor.white
    
    
    let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
    self.inventoryCollectionView.collectionViewLayout = listLayout
    
    inventoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        inventoryCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
        inventoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
        inventoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 00.0),
        inventoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200.0),
    ])
    
    let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, InventoryItem> { (cell, indexPath, item) in

        // Define how data should be shown using content configuration
        var content = cell.defaultContentConfiguration()
//            content.image = item.image
        content.text = item.item + " (x" + item.count + ")               " + item.button

        // Assign content configuration to cell
        cell.contentConfiguration = content
    }
    
    dataSource = UICollectionViewDiffableDataSource<Section, InventoryItem>(collectionView: inventoryCollectionView) {
        (collectionView: UICollectionView, indexPath: IndexPath, identifier: InventoryItem) -> UICollectionViewCell? in
        
        // Dequeue reusable cell using cell registration (Reuse identifier no longer needed)
            let cell = self.inventoryCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
            // Configure cell appearance
            cell.accessories = [.disclosureIndicator()]
            return cell
        }
        
        snapshot = NSDiffableDataSourceSnapshot<Section, InventoryItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(inventoryData, toSection: .main)

        // Display data in the collection view by applying the snapshot to data source
        dataSource.apply(snapshot, animatingDifferences: false)
    
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = inventoryCollectionView.cellForItem(at: indexPath as IndexPath) as? MDCBaseCell else { fatalError() }

        return cell
    
    }
    

    /*
    // MARK: - Navigation
s
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
