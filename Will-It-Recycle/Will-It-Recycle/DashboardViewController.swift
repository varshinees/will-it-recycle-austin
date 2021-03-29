//
//  DashboardViewController.swift
//  Will-It-Recycle
//
//  Created by Chelsie Barrientos on 3/26/21.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming
import MaterialComponents.MaterialCards

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var statsCard: MDCCard!
    
    @IBOutlet weak var leaderboardCard: MDCCard!
    
    @IBOutlet weak var redeemLeavesButton: MDCButton!
    
    @IBOutlet weak var recycleItemsButton: MDCButton!
    
    let containerScheme = MDCContainerScheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newSwiftColor = UIColor(red: 252, green: 108, blue: 133, alpha: 255)
        
        statsCard.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
        
        leaderboardCard.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
        
        redeemLeavesButton.applyTextTheme(withScheme: containerScheme)
        redeemLeavesButton.setTitle("Redeem Leaves", for: .normal)
        redeemLeavesButton.setTitleColor(newSwiftColor, for: .normal)
        
        recycleItemsButton.applyTextTheme(withScheme: containerScheme)
        recycleItemsButton.setTitle("Recycle Items Now", for: .normal)
        recycleItemsButton.setTitleColor(newSwiftColor, for: .normal)
    }
}
