//
//  WelcomeViewController.swift
//  Will-It-Recycle
//
//  Created by Chelsie Barrientos on 3/23/21.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class WelcomeViewController: UIViewController {

    @IBOutlet weak var recycleButton: MDCButton!
    
//    let buttonScheme = MDCButtonScheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        MDCContainedButtonThemer.applyScheme(buttonScheme, to: recycleButton)
        
        recycleButton.setTitle("Start Recycling!", for: .normal)
    }
}
