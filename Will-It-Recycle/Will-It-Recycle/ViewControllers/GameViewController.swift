//
//  GameViewController.swift
//  Will-It-Recycle
//
//  Created by Katherine H on 3/29/21.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialButtons
import Firebase

protocol activeListChanger {
    func changeActiveItemsList(activeList: [gameItem])
}

class GameViewController: UIViewController, activeListChanger {

    @IBOutlet weak var inventoryBtn: MDCButton!
    @IBOutlet weak var removeBtn: MDCButton!
    @IBOutlet weak var claimBtn: MDCButton!
    @IBOutlet weak var storeBtn: MDCButton!
    @IBOutlet weak var leavesLabel: UILabel!
    
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
    
    @IBOutlet weak var gameView: UIView!
    
    let ref = Database.database().reference()
    let user = Auth.auth().currentUser!
    var reward = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeBtn.setTitle("STORE", for: .normal)
        storeBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        storeBtn.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0))
        
        removeBtn.setTitle("REMOVE ITEM", for: .normal)
        removeBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        removeBtn.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0))
        
        claimBtn.setTitle("CLAIM TODAY'S REWARDS", for: .normal)
        claimBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        claimBtn.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0))
        
        inventoryBtn.setTitle("INVENTORY", for: .normal)
        inventoryBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        inventoryBtn.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0))
        
        //load active items onto game screen
        loadActiveItems()
        
        //display number of leaves the user has
        refreshLeaves()
    }

    override func viewWillAppear(_ animated: Bool) {
        //display number of leaves the user has
        refreshLeaves()
        
        clearItems()
        
        //load active items onto game screen
        loadActiveItems()    }
    
    @IBAction func claimOnClick(_ sender: Any) {
        //get today's date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        //compare current date with date stored in firebase
        self.ref.child("users/\(user.uid)/lastVisitedDate").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                
                //if the current date doesn't equal the stored date, claim the daily reward
                if snapshot.value as! String != result {
                    self.calculate()
                    self.successAlert()
                } else {
                    self.errorAlert()
                }
                
                //set date to current date
                self.ref.child("users/\(self.user.uid)/lastVisitedDate").setValue(result)
            }
            else {
                //set date to current date
                self.ref.child("users/\(self.user.uid)/lastVisitedDate").setValue(result)
                //claim reward
                self.calculate()
                self.successAlert()
            }
        }
    
    }
    
    func calculate() {
        //calculate reward based on price of items in game screen
        var total = 0
        for gameItem in activeItems {
            for storeItem in storeItems {
                if gameItem.key == storeItem.key {
                    total += storeItem.cost/10
                }
            }
        }
        reward = total
        //update current leaves in firebase
        self.ref.child("users/\(user.uid)/currentLeaves").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                //add to current leaves
                self.ref.child("users/\(self.user.uid)/currentLeaves").setValue(snapshot.value as! Int + total)
                DispatchQueue.main.async {
                    self.leavesLabel.text = "WALLET: \(snapshot.value as! Int + total) LEAVES"
                }
            }
            else {
                print("No data available")
            }
        }
        
        //update total leaves in firebase
        self.ref.child("users/\(user.uid)/allTimeLeaves").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                //add to current leaves
                self.ref.child("users/\(self.user.uid)/allTimeLeaves").setValue(snapshot.value as! Int + total)
            }
            else {
                print("No data available")
            }
        }
    }
    
    //alert for if you already claimed rewards
    func errorAlert() {
        DispatchQueue.main.async {
            let controller = UIAlertController(
                title: "Already Claimed!",
                message: "You already claimed today's rewards",
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "OK",
                                    style: .default,
                                    handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    //alert for if you successfully claimed rewards
    func successAlert() {
        DispatchQueue.main.async {
            let controller = UIAlertController(
                title: "Success! 🌱",
                message: "You claimed \(self.reward)leaves",
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "OK",
                                    style: .default,
                                    handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func clearItems() {
        zeroZero.setImage(nil, for: .normal)
        zeroOne.setImage(nil, for: .normal)
        zeroTwo.setImage(nil, for: .normal)
        zeroThree.setImage(nil, for: .normal)
        oneZero.setImage(nil, for: .normal)
        oneOne.setImage(nil, for: .normal)
        oneTwo.setImage(nil, for: .normal)
        oneThree.setImage(nil, for: .normal)
        twoZero.setImage(nil, for: .normal)
        twoOne.setImage(nil, for: .normal)
        twoTwo.setImage(nil, for: .normal)
        twoThree.setImage(nil, for: .normal)
        threeZero.setImage(nil, for: .normal)
        threeOne.setImage(nil, for: .normal)
        threeTwo.setImage(nil, for: .normal)
        threeThree.setImage(nil, for: .normal)
        fourZero.setImage(nil, for: .normal)
        fourOne.setImage(nil, for: .normal)
        fourTwo.setImage(nil, for: .normal)
        fourThree.setImage(nil, for: .normal)
    }
    
    //load active items onto game screen
    func loadActiveItems() {
        for item in activeItems {
            for coordinate in item.coordinates {
                let currentImage = UIImage(named: item.key)
                switch (coordinate) {
                case "(0,0)":
                    zeroZero.setImage(currentImage, for: .normal)
                case "(0,1)":
                    zeroOne.setImage(currentImage, for: .normal)
                case "(0,2)":
                    zeroTwo.setImage(currentImage, for: .normal)
                case "(0,3)":
                    zeroThree.setImage(currentImage, for: .normal)
                case "(1,0)":
                    oneZero.setImage(currentImage, for: .normal)
                case "(1,1)":
                    oneOne.setImage(currentImage, for: .normal)
                case "(1,2)":
                    oneTwo.setImage(currentImage, for: .normal)
                case "(1,3)":
                    oneThree.setImage(currentImage, for: .normal)
                case "(2,0)":
                    twoZero.setImage(currentImage, for: .normal)
                case "(2,1)":
                    twoOne.setImage(currentImage, for: .normal)
                case "(2,2)":
                    twoTwo.setImage(currentImage, for: .normal)
                case "(2,3)":
                    twoThree.setImage(currentImage, for: .normal)
                case "(3,0)":
                    threeZero.setImage(currentImage, for: .normal)
                case "(3,1)":
                    threeOne.setImage(currentImage, for: .normal)
                case "(3,2)":
                    threeTwo.setImage(currentImage, for: .normal)
                case "(3,3)":
                    threeThree.setImage(currentImage, for: .normal)
                case "(4,0)":
                    fourZero.setImage(currentImage, for: .normal)
                case "(4,1)":
                    fourOne.setImage(currentImage, for: .normal)
                case "(4,2)":
                    fourTwo.setImage(currentImage, for: .normal)
                case "(4,3)":
                    fourThree.setImage(currentImage, for: .normal)
                default:
                    return
                }
            }
        }
    }
    
    //get current leaves from firebase and display it
    func refreshLeaves() {
        self.ref.child("users/\(user.uid)/currentLeaves").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                DispatchQueue.main.async {
                    self.leavesLabel.text = "WALLET: \(snapshot.value as! Int) LEAVES"
                }
            }
            else {
                print("No data available")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "removeItemSegueId",
           let removeItemViewController = segue.destination as? RemoveItemViewController {
            removeItemViewController.delegate = self
        }
    }
    
    func changeActiveItemsList(activeList: [gameItem]) {
        activeItems = activeList
    }
    
}
