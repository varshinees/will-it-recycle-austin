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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newSwiftColor = UIColor(red: 252, green: 108, blue: 133)
        
        recycleButton.setTitle("Start Recycling!", for: .normal)
        recycleButton.setBackgroundColor(newSwiftColor, for: .normal)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
