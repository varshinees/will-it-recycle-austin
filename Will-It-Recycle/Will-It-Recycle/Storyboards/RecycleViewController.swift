//
//  RecycleViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents.MaterialButtons

class RecycleViewController: UIViewController {

    @IBOutlet weak var scanBtn: MDCButton!
    @IBOutlet weak var enterBtn: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanBtn.setTitle("SCAN NEW ITEMS", for: .normal)
        scanBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        enterBtn.setTitle("ENTER ITEMS MANUALLY", for: .normal)
        enterBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
    }
    

    
}
