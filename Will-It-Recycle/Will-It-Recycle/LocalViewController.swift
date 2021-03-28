//
//  LocalViewController.swift
//  Will-It-Recycle
//
//  Created by Victoria Denney on 3/28/21.
//

import UIKit
import MaterialComponents.MaterialCards

public struct LocalNewsItem: Hashable {
    let id: Int
    let title: String
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

public var LocalNewsData = [
    LocalNewsItem(id: 0, title: "Recycle & Reuse Drop-off Center"),
    LocalNewsItem(id: 1, title: "My Collection Schedule"),
    LocalNewsItem(id: 2, title: "HOW TO RECYCLE IN AUSTIN"),
    LocalNewsItem(id: 3, title: "Reducing waste at events"),
    LocalNewsItem(id: 4, title: "Volunteer to Clean Lady Bird Lake"),
    LocalNewsItem(id: 5, title: "Austin Creative Reuse Volunteer Opportunities"),
    LocalNewsItem(id: 6, title: "Keep Austin Beautiful Volunteer Opportunities")
]

class LocalViewController: UIViewController {
    
    // Define section identifier type
    enum Section {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, LocalNewsItem>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, LocalNewsItem>!
    
    @IBOutlet weak var localCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        localCollectionView.backgroundColor = UIColor.white
        
        // Create list layout
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        self.localCollectionView.collectionViewLayout = listLayout

        // Make collection view take up the entire view
        localCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            localCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
            localCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            localCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 00.0),
            localCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0),
        ])
        
        // Register cells with material-ui
//        localCollectionView.register(MDCCardCollectionCell.self, forCellWithReuseIdentifier: "localNewsCellIdentifier")
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LocalNewsItem> { (cell, indexPath, item) in

            // Define how data should be shown using content configuration
            var content = cell.defaultContentConfiguration()
//            content.image = item.image
            content.text = item.title

            // Assign content configuration to cell
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, LocalNewsItem>(collectionView: localCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: LocalNewsItem) -> UICollectionViewCell? in
            
            // Dequeue reusable cell using cell registration (Reuse identifier no longer needed)
            let cell = self.localCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
            // Configure cell appearance
            cell.accessories = [.disclosureIndicator()]
            return cell
        }
        
        // Create a snapshot that define the current state of data source's data
        snapshot = NSDiffableDataSourceSnapshot<Section, LocalNewsItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(LocalNewsData, toSection: .main)

        // Display data in the collection view by applying the snapshot to data source
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // Material-ui connection
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = localCollectionView.dequeueReusableCell(withReuseIdentifier: "localNewsCellIdentifier",
                                                    for: indexPath) as! MDCCardCollectionCell
        // If you wanted to have the card show the selected state when tapped
        // then you need to turn isSelectable to true, otherwise the default is false.
        print(indexPath)
        cell.isSelectable = true
        cell.cornerRadius = 8
        
        cell.setShadowColor(UIColor.black, for: .highlighted)
        return cell
    }

}
