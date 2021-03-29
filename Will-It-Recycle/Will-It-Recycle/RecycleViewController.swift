//
//  RecycleViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/28/21.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialButtons

class RecycleViewController: UIViewController {

  
    @IBOutlet weak var scanBtn: MDCFloatingButton!
    @IBOutlet weak var enterBtn: MDCFloatingButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scanBtn.mode = .expanded
        scanBtn.setTitle("Scan New Item", for: .normal)
        scanBtn.setTitleColor(UIColor.white, for: .normal)
        enterBtn.mode = .expanded
        enterBtn.setTitle("Enter Items Manually", for: .normal)
        enterBtn.setTitleColor(UIColor.white, for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
