//
//  GameViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialButtons

class GameViewController: UIViewController {
    

    @IBOutlet weak var inventoryBtn: MDCButton!
    @IBOutlet weak var removeBtn: MDCButton!
    @IBOutlet weak var claimBtn: MDCButton!
    @IBOutlet weak var storeBtn: MDCButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeBtn.setTitle("STORE", for: .normal)
        storeBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
//        storeBtn.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
        // Do any additional setup after loading the view.
        removeBtn.setTitle("REMOVE ITEM", for: .normal)
        removeBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        claimBtn.setTitle("CLAIM TODAY'S REWARDS", for: .normal)
        claimBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        inventoryBtn.setTitle("INVENTORY", for: .normal)
        inventoryBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
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
