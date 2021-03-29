//
//  RecycleViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/28/21.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class RecycleViewController: UIViewController {

  
    @IBOutlet weak var scanBtn: MDCButton!
    @IBOutlet weak var enterBtn: MDCButton!
    
//    let containerScheme = MDCContainerScheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newSwiftColor = UIColor(red: 252, green: 108, blue: 133, alpha: 255)
//        scanBtn.applyTextTheme(withScheme: containerScheme)
        scanBtn.setTitle("Scan New Item", for: .normal)
//        scanBtn.setTitleColor(newSwiftColor, for: .normal)
        
//        enterBtn.applyTextTheme(withScheme: containerScheme)
        enterBtn.setTitle("Enter Item Manually", for: .normal)
//        enterBtn.setTitleColor(newSwiftColor, for: .normal)
        
//        scanBtn.mode = .expanded
//        scanBtn.setTitle("Scan New Item", for: .normal)
//        scanBtn.setTitleColor(newSwiftColor, for: .normal)
//
//        enterBtn.mode = .expanded
//        enterBtn.setTitle("Enter Items Manually", for: .normal)
//        enterBtn.setTitleColor(newSwiftColor, for: .normal)
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
