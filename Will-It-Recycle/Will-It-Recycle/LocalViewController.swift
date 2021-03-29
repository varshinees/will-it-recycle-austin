//
//  LocalViewController.swift
//  Will-It-Recycle
//
//  Created by Victoria Denney on 3/28/21.
//

import UIKit
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialButtons

class LocalViewController: UIViewController {
    
    @IBOutlet weak var localCollectionView: UICollectionView!
    @IBOutlet weak var News1Card: MDCCard!
    @IBOutlet weak var News1Button: MDCButton!
    @IBOutlet weak var NewsTitleLabel1: UILabel!
    @IBOutlet weak var NewsCard2: MDCCard!
    @IBOutlet weak var NewsButton2: MDCButton!
    @IBOutlet weak var NewsTitleLabel2: UILabel!
    @IBOutlet weak var NewsCard3: MDCCard!
    @IBOutlet weak var NewsButton3: MDCButton!
    @IBOutlet weak var NewsTitleLabel3: UILabel!
    @IBOutlet weak var NewsLocationLabel3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let white = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let recyclePink = UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0)
        let fadedRecyclePink = UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 0.8)
        let extraFadedRecyclePink = UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 0.5)
        
        News1Card.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
        News1Button.setTitle("READ MORE", for: .normal)
        News1Button.setTitleColor(white, for: .normal)
        News1Button.setBackgroundColor(recyclePink, for: .normal)
        NewsTitleLabel1.textColor = fadedRecyclePink
        
        NewsCard2.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
        NewsButton2.setTitle("READ MORE", for: .normal)
        NewsButton2.setTitleColor(white, for: .normal)
        NewsButton2.setBackgroundColor(recyclePink, for: .normal)
        NewsTitleLabel2.textColor = fadedRecyclePink
        
        NewsCard3.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
        NewsButton3.setTitle("READ MORE", for: .normal)
        NewsButton3.setTitleColor(white, for: .normal)
        NewsButton3.setBackgroundColor(recyclePink, for: .normal)
        NewsTitleLabel3.textColor = fadedRecyclePink
        
        NewsLocationLabel3.textColor = extraFadedRecyclePink
    }
    
    @IBAction func NewsButton1Pressed(_ sender: Any) {
        if let url = URL(string: "https://www.austintexas.gov/department/recycle-reuse-drop-center") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func NewsButton2Pressed(_ sender: Any) {
        if let url = URL(string: "https://www.austinlocal.com/recycling-in-austin-what-is-recyclable-and-what-is-not.html") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func NewsButton3Pressed(_ sender: Any) {
        if let url = URL(string: "https://www.austincreativereuse.org/2021/03/march-reuse-and-rethink-reuse-in-the-yard/") {
            UIApplication.shared.open(url)
        }
    }
    
}
