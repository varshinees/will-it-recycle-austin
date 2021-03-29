//
//  ManualEntryViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/28/21.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialList

public struct ManualEntryItem: Hashable {
    let id: Int
    let item: String
    
    init(id: Int, item: String) {
        self.id = id
        self.item = item

    }
}

public var manualEntryData = [
    ManualEntryItem(id: 0, item: "Aluminum Can"),
    ManualEntryItem(id: 1, item: "Plastic Bottle"),
    ManualEntryItem(id: 2, item: "Cardboard Box"),
    ManualEntryItem(id: 3, item: "Glass Bottle"),
    ManualEntryItem(id: 4, item: "Mixed Paper"),
    ManualEntryItem(id: 5, item: "Tin Can"),
    ManualEntryItem(id: 6, item: "Plastic Utencils"),
    ManualEntryItem(id: 7, item: "Paperboard"),
    ManualEntryItem(id: 8, item: "Aluminum Foil")
]

class ManualEntryViewController: UIViewController {
    
    enum Section {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, ManualEntryItem>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, ManualEntryItem>!
    @IBOutlet weak var redeemBtn: MDCButton!
    @IBOutlet weak var backBtn: MDCButton!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var entryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redeemBtn.setTitle("REDEEM", for: .normal)
        redeemBtn.setTitleColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
//        redeemBtn.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
        backBtn.setTitle("< BACK", for: .normal)
        backBtn.setTitleColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
        entryCollectionView.backgroundColor = UIColor.white

        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        self.entryCollectionView.collectionViewLayout = listLayout

        // Make collection view take up the entire view
        entryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            entryCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 130.0),
            entryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            entryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 00.0),
            entryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200.0),
        ])
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ManualEntryItem> { (cell, indexPath, item) in

            // Define how data should be shown using content configuration
            var content = cell.defaultContentConfiguration()
//            content.image = item.image
            content.text = item.item

            // Assign content configuration to cell
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, ManualEntryItem>(collectionView: entryCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: ManualEntryItem) -> UICollectionViewCell? in
            
            // Dequeue reusable cell using cell registration (Reuse identifier no longer needed)
            let cell = self.entryCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
            // Configure cell appearance
            cell.accessories = [.disclosureIndicator()]
            return cell
        }
        
        // Create a snapshot that define the current state of data source's data
        snapshot = NSDiffableDataSourceSnapshot<Section, ManualEntryItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(manualEntryData, toSection: .main)

        // Display data in the collection view by applying the snapshot to data source
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = entryCollectionView.cellForItem(at: indexPath as IndexPath) as? MDCBaseCell else { fatalError() }

        return cell
    }
    
}
