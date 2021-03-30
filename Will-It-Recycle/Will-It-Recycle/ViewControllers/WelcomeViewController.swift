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
    
    @IBOutlet weak var dogButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogButton.showsTouchWhenHighlighted = true
        
        recycleButton.setTitle("Start Recycling!", for: .normal)
    }
    
    
}
