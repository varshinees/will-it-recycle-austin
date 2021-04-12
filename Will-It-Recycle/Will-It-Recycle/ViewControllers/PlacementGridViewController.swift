//
//  PlacementGridViewController.swift
//  Will-It-Recycle
//
//  Created by Victoria Denney on 4/9/21.
//

import UIKit
import FirebaseUI
import Firebase
import MaterialComponents

public var coordinatesOccupied = [String]()

class PlacementGridViewController: UIViewController {
    
    var activeItem = gameItem(key: "", item: "", count: 0, coordinates: [])
    var delegate: UIViewController!
    let ref = Database.database().reference()
    let user = Auth.auth().currentUser!

    @IBOutlet weak var completeButton: MDCButton!
    @IBOutlet weak var button00: UIButton!
    @IBOutlet weak var button01: UIButton!
    @IBOutlet weak var button02: UIButton!
    @IBOutlet weak var button03: UIButton!
    
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    
    @IBOutlet weak var button20: UIButton!
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var button23: UIButton!
    
    @IBOutlet weak var button30: UIButton!
    @IBOutlet weak var button31: UIButton!
    @IBOutlet weak var button32: UIButton!
    @IBOutlet weak var button33: UIButton!
    
    @IBOutlet weak var button40: UIButton!
    @IBOutlet weak var button41: UIButton!
    @IBOutlet weak var button42: UIButton!
    @IBOutlet weak var button43: UIButton!
    
    var coordinate = String()
    var coordinateSelected: UIButton!
    var buttonCoordinates = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button00.isEnabled = coordinatesOccupied.contains("(0,0)") ? false: true
        buttonCoordinates.append(button00)
        button01.isEnabled = coordinatesOccupied.contains("(0,1)") ? false: true
        buttonCoordinates.append(button01)
        button02.isEnabled = coordinatesOccupied.contains("(0,2)") ? false: true
        buttonCoordinates.append(button02)
        button03.isEnabled = coordinatesOccupied.contains("(0,3)") ? false: true
        buttonCoordinates.append(button03)
        
        button10.isEnabled = coordinatesOccupied.contains("(1,0)") ? false: true
        buttonCoordinates.append(button10)
        button11.isEnabled = coordinatesOccupied.contains("(1,1)") ? false: true
        buttonCoordinates.append(button11)
        button12.isEnabled = coordinatesOccupied.contains("(1,2)") ? false: true
        buttonCoordinates.append(button12)
        button13.isEnabled = coordinatesOccupied.contains("(1,3)") ? false: true
        buttonCoordinates.append(button13)
        
        button20.isEnabled = coordinatesOccupied.contains("(2,0)") ? false: true
        buttonCoordinates.append(button20)
        button21.isEnabled = coordinatesOccupied.contains("(2,1)") ? false: true
        buttonCoordinates.append(button21)
        button22.isEnabled = coordinatesOccupied.contains("(2,2)") ? false: true
        buttonCoordinates.append(button22)
        button23.isEnabled = coordinatesOccupied.contains("(2,3)") ? false: true
        buttonCoordinates.append(button23)
        
        button30.isEnabled = coordinatesOccupied.contains("(3,0)") ? false: true
        buttonCoordinates.append(button30)
        button31.isEnabled = coordinatesOccupied.contains("(3,1)") ? false: true
        buttonCoordinates.append(button31)
        button32.isEnabled = coordinatesOccupied.contains("(3,2)") ? false: true
        buttonCoordinates.append(button32)
        button33.isEnabled = coordinatesOccupied.contains("(3,3)") ? false: true
        buttonCoordinates.append(button33)
        
        button40.isEnabled = coordinatesOccupied.contains("(4,0)") ? false: true
        buttonCoordinates.append(button40)
        button41.isEnabled = coordinatesOccupied.contains("(4,1)") ? false: true
        buttonCoordinates.append(button41)
        button42.isEnabled = coordinatesOccupied.contains("(4,2)") ? false: true
        buttonCoordinates.append(button42)
        button43.isEnabled = coordinatesOccupied.contains("(4,3)") ? false: true
        buttonCoordinates.append(button43)
        
        for button in buttonCoordinates {
            if button.isEnabled == true {
                button.backgroundColor = UIColor.white
                button.layer.borderWidth = 0.8
                button.layer.borderColor = UIColor.lightGray.cgColor
            }
            else {
                button.backgroundColor = UIColor.lightGray
            }
            button.backgroundColor?.withAlphaComponent(0.5)
        }

        completeButton.setTitle("COMPLETE", for: .normal)
        completeButton.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        completeButton.setBackgroundColor(UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0), for: .normal)
    }
    
    @IBAction func onPlacementCompleted(_ sender: Any) {
        self.dismiss(animated: true)
        
        if coordinate.count > 0 {
            // protocol back to game view controller
            
            // add coordinate to occupiedCoordinates
            coordinatesOccupied.append(coordinate)
            // add item to activeItems in firebase
            self.ref.child("users/\(user.uid)/activeItems/\(self.activeItem.key)").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    let activeItemsData = snapshot.value as! [String]
                    self.ref.child("users/\(self.user.uid)/activeItems/\(self.activeItem.key)/\(activeItemsData.count)").setValue(self.coordinate)
                    // update local activeItems list
                    for item in activeItems {
                        if item.key == self.activeItem.key {
                            item.incrementCount()
                            item.coordinates.append(self.coordinate)
                        }
                    }
                }
                else {
                    self.ref.child("users/\(self.user.uid)/activeItems/\(self.activeItem.key)").child("0").setValue(self.coordinate)
                    // update local activeItems list
                    let newItem = gameItem(key: self.activeItem.key, item: self.activeItem.item, count: 1, coordinates: [self.coordinate])
                    activeItems.append(newItem)
                }
            }
        }
        else {
            // alert to select a coordinate
            print("select a coordinate")
        }
    }
    
    func resetSelectedCoordinate (button: UIButton) {
        if coordinateSelected != nil {
            coordinateSelected.backgroundColor = UIColor.white
            coordinateSelected.backgroundColor?.withAlphaComponent(0.5)
        }
        button.backgroundColor = UIColor(red: 252/255, green: 108/255, blue: 133/255, alpha: 1.0)
        coordinateSelected = button
    }
    
    @IBAction func onSelectButton00(_ sender: Any) {
        coordinate = "(0,0)"
        resetSelectedCoordinate(button: button00)
    }
    
    @IBAction func onSelectButton01(_ sender: Any) {
        coordinate = "(0,1)"
        resetSelectedCoordinate(button: button01)
    }
    
    @IBAction func onSelectButton02(_ sender: Any) {
        coordinate = "(0,2)"
        resetSelectedCoordinate(button: button02)
    }
    
    @IBAction func onSelectButton03(_ sender: Any) {
        coordinate = "(0,3)"
        resetSelectedCoordinate(button: button03)
    }
    
    @IBAction func onSelectButton10(_ sender: Any) {
        coordinate = "(1,0)"
        resetSelectedCoordinate(button: button10)
    }
    
    @IBAction func onSelectButton11(_ sender: Any) {
        coordinate = "(1,1)"
        resetSelectedCoordinate(button: button11)
    }
    
    @IBAction func onSelectButton12(_ sender: Any) {
        coordinate = "(1,2)"
        resetSelectedCoordinate(button: button12)
    }
    
    @IBAction func onSelectButton13(_ sender: Any) {
        coordinate = "(1,3)"
        resetSelectedCoordinate(button: button13)
    }
    
    @IBAction func onSelectButton20(_ sender: Any) {
        coordinate = "(2,0)"
        resetSelectedCoordinate(button: button20)
    }
    
    @IBAction func onSelectButton21(_ sender: Any) {
        coordinate = "(2,1)"
        resetSelectedCoordinate(button: button21)
    }
    
    @IBAction func onSelectButton22(_ sender: Any) {
        coordinate = "(2,2)"
        resetSelectedCoordinate(button: button22)
    }
    
    @IBAction func onSelectButton23(_ sender: Any) {
        coordinate = "(2,3)"
        resetSelectedCoordinate(button: button23)
    }
    
    @IBAction func onSelectButton30(_ sender: Any) {
        coordinate = "(3,0)"
        resetSelectedCoordinate(button: button30)
    }
    
    @IBAction func onSelectButton31(_ sender: Any) {
        coordinate = "(3,1)"
        resetSelectedCoordinate(button: button31)
    }
    
    @IBAction func onSelectButton32(_ sender: Any) {
        coordinate = "(3,2)"
        resetSelectedCoordinate(button: button32)
    }
    
    @IBAction func onSelectButton33(_ sender: Any) {
        coordinate = "(3,3)"
        resetSelectedCoordinate(button: button33)
    }
    
    @IBAction func onSelectButton40(_ sender: Any) {
        coordinate = "(4,0)"
        resetSelectedCoordinate(button: button40)
    }
    
    @IBAction func onSelectButton41(_ sender: Any) {
        coordinate = "(4,1)"
        resetSelectedCoordinate(button: button41)
    }
    
    @IBAction func onSelectButton42(_ sender: Any) {
        coordinate = "(4,2)"
        resetSelectedCoordinate(button: button42)
    }
    
    @IBAction func onSelectButton43(_ sender: Any) {
        coordinate = "(4,3)"
        resetSelectedCoordinate(button: button43)
    }
    
}
