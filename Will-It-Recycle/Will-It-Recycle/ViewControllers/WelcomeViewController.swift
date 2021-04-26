//
//  WelcomeViewController.swift
//  Will-It-Recycle
//
//  Created by Chelsie Barrientos on 3/30/21.
//

import UIKit
import Firebase

//
// A class which coordinates communication between the data
// and view components of the Welcome View Controller.
//
class WelcomeViewController: UIViewController {
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var birdButton: UIButton!
    @IBOutlet weak var fishButton: UIButton!
    @IBOutlet weak var catButton: UIButton!
    @IBOutlet weak var frogButton: UIButton!
    @IBOutlet weak var horseButton: UIButton!
    @IBOutlet weak var dragonButton: UIButton!
    @IBOutlet weak var hippoButton: UIButton!
    @IBOutlet weak var recycleButton: UIButton!
    
    var selectedButton:UIButton!
    
    let imageNames:[String] = ["Dog.png", "Bird.png", "Fish.png", "Cat.png", "Frog.png", "Horse.png", "Dragon.png", "Hippo.png"]
    
    var buttons:[UIButton]!
    
    // A method which signals that the program is ready.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [dogButton, birdButton, fishButton, catButton, frogButton, horseButton, dragonButton, hippoButton]
        
        if !firstTimeUser {
            recycleButton.setTitle("BACK TO SETTINGS", for: .normal)
        }
        
        selectedButton = dogButton
        selectedButton.layer.cornerRadius = 50
        selectedButton.layer.borderWidth = 4
        selectedButton.layer.borderColor = UIColor.init(red: 252/256, green: 108/256, blue: 133/256, alpha: 1).cgColor
        
    }
    
    @IBAction func avatarPicked(_ sender: UIButton) {
        selectedButton.layer.borderColor = UIColor.clear.cgColor
        selectedButton = sender
        selectedButton.layer.cornerRadius = 50
        selectedButton.layer.borderWidth = 4
        selectedButton.layer.borderColor = UIColor.init(red: 252/256, green: 108/256, blue: 133/256, alpha: 1).cgColor
        
    }
    
    
    // A method which performs the appropriate segue when the button is pressed.
    @IBAction func buttonPressed(_ sender: Any) {
        // save to Firebase
        let ref = Database.database().reference()
        ref.child("users/\(Auth.auth().currentUser!.uid)/avatar").setValue(imageNames[selectedButton.tag])
        
        // segue to next VC
        if firstTimeUser {
            self.performSegue(withIdentifier: "dashboardSegueIdentifier", sender: nil)
            firstTimeUser = false
            
        } else {
            self.dismiss(animated: true)
        }
    }
    
}
