//
//  SettingsViewController.swift
//  Will-It-Recycle
//
//  Created by Chelsie Barrientos on 3/23/21.
//

import UIKit
import Firebase
import MaterialComponents
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

//
// A class which coordinates communication between the data
// and view components of the Settings View Controller.
//
class SettingsViewController: UIViewController {
    @IBOutlet weak var changeUsername: UITextField!
    
    @IBOutlet weak var changeEmail: UITextField!
    
    @IBOutlet weak var updateButton: MDCButton!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    // A method which signals that the program is ready.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeUsername.clearsOnBeginEditing = true
        
        changeEmail.clearsOnBeginEditing = true
        
        updateButton.setTitle("Update", for: .normal)
    }

    // A method that updates the current user's email.
    @IBAction func updateButtonPressed(_ sender: Any) {
        if (changeEmail.text != "") {
            Auth.auth().currentUser?.updateEmail(to: changeEmail.text!, completion: nil)
        }
    }
    
    // A method that signs out the current user.
    @IBAction func signOutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
        } catch {
            print("Already logged out")
        }
        performSegue(withIdentifier: "mainSegueIdentifier", sender: nil)
    }
}
