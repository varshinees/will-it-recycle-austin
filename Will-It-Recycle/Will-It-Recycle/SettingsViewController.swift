//
//  SettingsViewController.swift
//  Will-It-Recycle
//
//  Created by Chelsie Barrientos on 3/23/21.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class SettingsViewController: UIViewController {

    @IBOutlet weak var updateButton: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let newSwiftColor = UIColor(red: 252, green: 108, blue: 133, alpha: 255)
        
        updateButton.setTitle("Update", for: .normal)
        // updateButton.setBackgroundColor(newSwiftColor, for: .normal)

    }

}
