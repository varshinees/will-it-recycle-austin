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
//import MaterialComponents.MaterialSlider
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
        
//        let slider = MDCSlider(frame: CGRect(x: 50, y: 50, width: 100, height: 27))
//          slider.addTarget(self,
//                           action: #selector(didChangeSliderValue(senderSlider:)),
//                           for: .valueChanged)
//          view.addSubview(slider)
    }
    
//    @objc func didChangeSliderValue(senderSlider:MDCSlider) {
//      print("Did change slider value to: \(senderSlider.value)")
//    }
}
