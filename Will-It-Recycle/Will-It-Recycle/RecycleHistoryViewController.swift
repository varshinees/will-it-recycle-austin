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

class RecycleHistoryViewController: UIViewController {
    
    // Define section identifier type
    enum Section {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, RecycleHistoryItem>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, RecycleHistoryItem>!

    @IBOutlet weak var recyclingCollectionView: UICollectionView!
    @IBOutlet weak var returnToSettingsButton: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set material-ui button style
        returnToSettingsButton.setTitle("Back To Settings", for: .normal)
        returnToSettingsButton.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        returnToSettingsButton.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
        recyclingCollectionView.backgroundColor = UIColor.white
        
        // Create list layout
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        self.recyclingCollectionView.collectionViewLayout = listLayout

        // Make collection view take up the entire view
        recyclingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recyclingCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
            recyclingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            recyclingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 00.0),
            recyclingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200.0),
        ])
        
        // Register cells with material-ui
//        recyclingCollectionView.register(MDCBaseCell.self, forCellWithReuseIdentifier: "RecycleHistoryCell")
        
        // Create cell registration that defines how data should be shown in a cell
        // MDCBaseCell
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, RecycleHistoryItem> { (cell, indexPath, item) in

            // Define how data should be shown using content configuration
            var content = cell.defaultContentConfiguration()
//            content.image = item.image
            content.text = item.item + " (x" + item.count + ")               " + item.date

            // Assign content configuration to cell
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, RecycleHistoryItem>(collectionView: recyclingCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: RecycleHistoryItem) -> UICollectionViewCell? in
            
            // Dequeue reusable cell using cell registration (Reuse identifier no longer needed)
            let cell = self.recyclingCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
            // Configure cell appearance
            cell.accessories = [.disclosureIndicator()]
            return cell
        }
        
        // Create a snapshot that define the current state of data source's data
        snapshot = NSDiffableDataSourceSnapshot<Section, RecycleHistoryItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(recycleHistoryData, toSection: .main)

        // Display data in the collection view by applying the snapshot to data source
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = recyclingCollectionView.cellForItem(at: indexPath as IndexPath) as? MDCBaseCell else { fatalError() }

        return cell
    }
    
}
