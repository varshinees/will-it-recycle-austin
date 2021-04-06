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
    
    @IBOutlet weak var appNotify: UISwitch!
    
    @IBOutlet weak var leaderSettings: UISwitch!
    
    @IBOutlet weak var updateButton: MDCButton!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    // A method which signals that the program is ready.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeUsername.clearsOnBeginEditing = true
        
        changeEmail.clearsOnBeginEditing = true
        
        appNotify.isOn = false
        
        leaderSettings.isOn = true
        
        updateButton.setTitle("Update", for: .normal)
    }
    
    @IBAction func appNotifySwitched(_ sender: Any) {
        let ref = Database.database().reference()
        
        if (!appNotify.isOn) {
            let controller = UIAlertController(
                title: "Do you want to turn off app notifications?",
                message: nil,
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "Yes",
                                    style: .cancel,
                                    handler: {
                                        (action)
                                        in self.appNotify.isOn = false
                                    }))
            controller.addAction(UIAlertAction(
                                    title: "No",
                                    style: .default,
                                    handler: {
                                        (action)
                                        in self.appNotify.isOn = true
                                    }))
            present(controller, animated: true, completion: nil)
            
            if (self.appNotify.isOn) {
                ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["notifications": true])
                
            } else {
                ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["notifications": false])
            }
            
        } else {
            let controller = UIAlertController(
                title: "Do you want to turn on app notifications?",
                message: nil,
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "Yes",
                                    style: .cancel,
                                    handler: {
                                        (action)
                                        in self.appNotify.isOn = true
                                    }))
            controller.addAction(UIAlertAction(
                                    title: "No",
                                    style: .default,
                                    handler: {
                                        (action)
                                        in self.appNotify.isOn = false
                                    }))
            present(controller, animated: true, completion: nil)
        }
        
        if (self.appNotify.isOn) {
            ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["notifications": true])
            
        } else {
            ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["notifications": false])
        }
    }
    
    
    @IBAction func leaderSettingsSwitched(_ sender: Any) {
        let ref = Database.database().reference()
        
        if (!leaderSettings.isOn) {
            let controller = UIAlertController(
                title: "Do you want to turn off leaderboard settings?",
                message: nil,
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "Yes",
                                    style: .cancel,
                                    handler: {
                                        (action)
                                        in self.leaderSettings.isOn = false
                                    }))
            controller.addAction(UIAlertAction(
                                    title: "No",
                                    style: .default,
                                    handler: {
                                        (action)
                                        in self.leaderSettings.isOn = true
                                    }))
            present(controller, animated: true, completion: nil)
            
            if (self.leaderSettings.isOn) {
                ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["leaderboard": true])
                
            } else {
                ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["leaderboard": false])
            }
            
        } else {
            let controller = UIAlertController(
                title: "Do you want to turn on leaderboard settings?",
                message: nil,
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "Yes",
                                    style: .cancel,
                                    handler: {
                                        (action)
                                        in self.leaderSettings.isOn = true
                                    }))
            controller.addAction(UIAlertAction(
                                    title: "No",
                                    style: .default,
                                    handler: {
                                        (action)
                                        in self.leaderSettings.isOn = false
                                    }))
            present(controller, animated: true, completion: nil)
            
            if (self.leaderSettings.isOn) {
                ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["leaderboard": true])
                
            } else {
                ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["leaderboard": false])
            }
        }
    }
    
    // A method that updates the current user's email.
    @IBAction func updateButtonPressed(_ sender: Any) {
        let ref = Database.database().reference()
        
        if (changeUsername.text != "" ) {
            ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["displayName": changeUsername.text])
        }
        
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
