//
//  ScanViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents.MaterialButtons

class ScanViewController: UIViewController {

    @IBOutlet weak var backBtn: MDCButton!
    @IBOutlet weak var takePicBtn: MDCButton!
    @IBOutlet weak var itemOne: UILabel!
    @IBOutlet weak var itemTwo: UILabel!
    @IBOutlet weak var itemThree: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        backBtn.setTitle("< BACK", for: .normal)
        backBtn.setTitleColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), for: .normal)
        takePicBtn.setTitle("TAKE PICTURE", for: .normal)
        takePicBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
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
