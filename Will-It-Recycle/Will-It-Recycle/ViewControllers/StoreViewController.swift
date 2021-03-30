//
//  StoreViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialList

public struct StoreItem: Hashable {
    let id: Int
    let item: String
    let message: String
    let cost: String
    
    init(id: Int, item: String, message: String, cost: String) {
        self.id = id
        self.item = item
        self.message = message
        self.cost = cost
    }
}

public var storeData = [
    StoreItem(id: 0, item: "Solar Panel", message: "Generates 3 leaves/day", cost: "50"),
    StoreItem(id: 1, item: "Wind Turbine", message: "Generates 5 leaves/day", cost: "60"),
    StoreItem(id: 2, item: "Succulent", message: "Looks adorable", cost: "20"),
    StoreItem(id: 3, item: "Tree", message: "Generates 3 leaves/day", cost: "50"),
    StoreItem(id: 4, item: "Watering Can", message: "Doubles leaf generation", cost: "80"),
]

class StoreViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, StoreItem>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, StoreItem>!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leavesLabel: UILabel!
    @IBOutlet weak var storeCollectionView: UICollectionView!
    @IBOutlet weak var backBtn: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backBtn.setTitle("BACK TO MY LAND", for: .normal)
        backBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        //        backBtn.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
        storeCollectionView.backgroundColor = UIColor.white
        
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        self.storeCollectionView.collectionViewLayout = listLayout
        
        storeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storeCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 90.0),
            storeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            storeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 00.0),
            storeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200.0),
        ])
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, StoreItem> { (cell, indexPath, item) in

            // Define how data should be shown using content configuration
            var content = cell.defaultContentConfiguration()
    //            content.image = item.image
            content.text = item.item + " - " + item.message + " (" + item.cost + " leaves)"

            // Assign content configuration to cell
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, StoreItem>(collectionView: storeCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: StoreItem) -> UICollectionViewCell? in
            
            // Dequeue reusable cell using cell registration (Reuse identifier no longer needed)
                let cell = self.storeCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
                // Configure cell appearance
                cell.accessories = [.disclosureIndicator()]
                return cell
            }
            
            snapshot = NSDiffableDataSourceSnapshot<Section, StoreItem>()
            snapshot.appendSections([.main])
            snapshot.appendItems(storeData, toSection: .main)

            // Display data in the collection view by applying the snapshot to data source
            dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = storeCollectionView.cellForItem(at: indexPath as IndexPath) as? MDCBaseCell else { fatalError() }

        return cell
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
