//
//  ScanViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/28/21.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialChips
import MaterialComponents.MaterialBanner

class ScanViewController: UIViewController {

    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var backBtn: MDCButton!
//    @IBOutlet weak var itemOne: MDCChipView!
//    @IBOutlet weak var itemTwo: MDCChipView!
//    @IBOutlet weak var itemThree: MDCChipView!
    @IBOutlet weak var takePicBtn: MDCButton!
    
    let bannerView = MDCBannerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.textView.text = "Success! You have gained 50 leaves"
//        itemOne.titleLabel.text = "Item one"
//        itemTwo.titleLabel.text = "Item two"
//        itemThree.titleLabel.text = "Item three"
       
        backBtn.setTitle("< BACK", for: .normal)
        
        takePicBtn.setTitle("TAKE PICTURE", for: .normal)
        takePicBtn.setTitleColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)

        // Do any additional setup after loading the view.
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
