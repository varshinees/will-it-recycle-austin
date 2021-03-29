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
    
    let containerScheme = MDCContainerScheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statsCard.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
        
        leaderboardCard.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
    }
}
