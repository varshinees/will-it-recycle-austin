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
    
    @IBOutlet weak var zeroZero: UIButton!
    @IBOutlet weak var zeroOne: UIButton!
    @IBOutlet weak var zeroTwo: UIButton!
    @IBOutlet weak var zeroThree: UIButton!
    @IBOutlet weak var oneZero: UIButton!
    @IBOutlet weak var oneOne: UIButton!
    @IBOutlet weak var oneTwo: UIButton!
    @IBOutlet weak var oneThree: UIButton!
    @IBOutlet weak var twoZero: UIButton!
    @IBOutlet weak var twoOne: UIButton!
    @IBOutlet weak var twoTwo: UIButton!
    @IBOutlet weak var twoThree: UIButton!
    @IBOutlet weak var threeZero: UIButton!
    @IBOutlet weak var threeOne: UIButton!
    @IBOutlet weak var threeTwo: UIButton!
    @IBOutlet weak var threeThree: UIButton!
    @IBOutlet weak var fourZero: UIButton!
    @IBOutlet weak var fourOne: UIButton!
    @IBOutlet weak var fourTwo: UIButton!
    @IBOutlet weak var fourThree: UIButton!
    
    
    

    var gameItem:gameItem!
    
    @IBOutlet weak var gameView: UIView!
    
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

    override func viewDidAppear(_ animated: Bool) {
        let currentImage = UIImage(named: gameItem.key)
        
//        let numbers = [0:"zero", 1:"one", 2:"two", 3:"three", 4:"four"]
//
        //get numbers in coordinates
        //let string = gameItem.coordinates[0]
//        let string = "(0,0)"
//        let firstNum = (string[string.index(string.startIndex, offsetBy: 1)] as? Int)!
//        let secondNum = (string[string.index(string.startIndex, offsetBy: 3)] as? Int)!

//        let buttonName = "\(numbers[firstNum])\(numbers[secondNum])"
        
//        buttonName.setImage(currentImage, for: .normal)
        
        switch (gameItem.coordinates) {
        case ["(0,0)"]:
            zeroZero.setImage(currentImage, for: .normal)
        case ["(0,1)"]:
            zeroOne.setImage(currentImage, for: .normal)
        case ["(0,2)"]:
            zeroTwo.setImage(currentImage, for: .normal)
        case ["(0,3)"]:
            zeroThree.setImage(currentImage, for: .normal)
        case ["(1,0)"]:
            oneZero.setImage(currentImage, for: .normal)
        case ["(1,1)"]:
            oneOne.setImage(currentImage, for: .normal)
        case ["(1,2)"]:
            oneTwo.setImage(currentImage, for: .normal)
        case ["(1,3)"]:
            oneThree.setImage(currentImage, for: .normal)
        case ["(2,0)"]:
            twoZero.setImage(currentImage, for: .normal)
        case ["(2,1)"]:
            twoOne.setImage(currentImage, for: .normal)
        case ["(2,2)"]:
            twoTwo.setImage(currentImage, for: .normal)
        case ["(2,3)"]:
            twoThree.setImage(currentImage, for: .normal)
        case ["(3,0)"]:
            threeZero.setImage(currentImage, for: .normal)
        case ["(3,1)"]:
            threeOne.setImage(currentImage, for: .normal)
        case ["(3,2)"]:
            threeTwo.setImage(currentImage, for: .normal)
        case ["(3,3)"]:
            threeThree.setImage(currentImage, for: .normal)
        case ["(4,0)"]:
            fourZero.setImage(currentImage, for: .normal)
        case ["(4,1)"]:
            fourOne.setImage(currentImage, for: .normal)
        case ["(4,2)"]:
            fourTwo.setImage(currentImage, for: .normal)
        case ["(4,3)"]:
            fourThree.setImage(currentImage, for: .normal)
        default:
            return
        }
    }

}
