//
//  PlacementGridViewController.swift
//  Will-It-Recycle
//
//  Created by Victoria Denney on 4/9/21.
//

import UIKit
import MaterialComponents

class PlacementGridViewController: UIViewController {

    @IBOutlet weak var completeButton: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        completeButton.setTitle("COMPLETE", for: .normal)
        completeButton.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        completeButton.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
    }
    
    @IBAction func onPlacementCompleted(_ sender: Any) {
        
        self.dismiss(animated: true)
    }

}
