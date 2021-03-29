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
    ManualEntryItem(id: 8, item: "Aluminum Foil"),
    
]

class ManualEntryViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, ManualEntryItem>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, ManualEntryItem>!

    @IBOutlet weak var backBtn: MDCButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var manualCollectionView: UICollectionView!
    @IBOutlet weak var redeemBtn: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.setTitle("< BACK", for: .normal)
        backBtn.setTitleColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), for: .normal)
        
        redeemBtn.setTitle("REDEEM", for: .normal)
        redeemBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        manualCollectionView.backgroundColor = UIColor.white
        
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        self.manualCollectionView.collectionViewLayout = listLayout
        
        manualCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            manualCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 140.0),
            manualCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            manualCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 00.0),
            manualCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200.0),
        ])
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ManualEntryItem> { (cell, indexPath, item) in

            // Define how data should be shown using content configuration
            var content = cell.defaultContentConfiguration()
    //            content.image = item.image
            content.text = item.item

            // Assign content configuration to cell
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, ManualEntryItem>(collectionView: manualCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: ManualEntryItem) -> UICollectionViewCell? in
            
            // Dequeue reusable cell using cell registration (Reuse identifier no longer needed)
                let cell = self.manualCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
                // Configure cell appearance
                cell.accessories = [.disclosureIndicator()]
                return cell
            }
            
            snapshot = NSDiffableDataSourceSnapshot<Section, ManualEntryItem>()
            snapshot.appendSections([.main])
            snapshot.appendItems(manualEntryData, toSection: .main)

            // Display data in the collection view by applying the snapshot to data source
            dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = manualCollectionView.cellForItem(at: indexPath as IndexPath) as? MDCBaseCell else { fatalError() }

        return cell
    
    }

    
}
