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
import UserNotifications

var notifications = false
var leaderboard = true

//
// A class which coordinates communication between the data
// and view components of the Settings View Controller.
//
class SettingsViewController: UIViewController, UNUserNotificationCenterDelegate {
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
        
        if (notifications) {
            self.appNotify.isOn = true
        } else {
            self.appNotify.isOn = false
        }

        if (leaderboard) {
            self.leaderSettings.isOn = true
        } else {
            self.leaderSettings.isOn = false
        }

        updateButton.setTitle("Update", for: .normal)
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    @IBAction func appNotifySwitched(_ sender: Any) {
        let ref = Database.database().reference()
        
        // How to update appNotify and notifications?
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async() {
                let alertController = UIAlertController(title: nil, message: "Do you want to change notifications settings?", preferredStyle: .alert)

                let action1 = UIAlertAction(title: "Settings", style: .default) { (action:UIAlertAction) in
                    if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings as URL, options: [:], completionHandler: nil)
                    }
                }

                let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
                }

                alertController.addAction(action1)
                alertController.addAction(action2)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        if (self.appNotify.isOn) {
            ref.child("users/\(Auth.auth().currentUser!.uid)/notifications").setValue(true)
            
        } else {
            ref.child("users/\(Auth.auth().currentUser!.uid)/notifications").setValue(false)
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
                                        (action) in
                                        leaderboard = false
                                        self.leaderSettings.isOn = false
                                    }))
            controller.addAction(UIAlertAction(
                                    title: "No",
                                    style: .default,
                                    handler: {
                                        (action) in
                                        leaderboard = true
                                        self.leaderSettings.isOn = true
                                    }))
            present(controller, animated: true, completion: nil)
            
        } else {
            let controller = UIAlertController(
                title: "Do you want to turn on leaderboard settings?",
                message: nil,
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "Yes",
                                    style: .cancel,
                                    handler: {
                                        (action) in
                                        leaderboard = true
                                        self.leaderSettings.isOn = true
                                    }))
            controller.addAction(UIAlertAction(
                                    title: "No",
                                    style: .default,
                                    handler: {
                                        (action) in
                                        leaderboard = false
                                        self.leaderSettings.isOn = false
                                    }))
            present(controller, animated: true, completion: nil)
        }
        
        if (self.leaderSettings.isOn) {
            ref.child("users/\(Auth.auth().currentUser!.uid)/leaderboard").setValue(true)
            
        } else {
            ref.child("users/\(Auth.auth().currentUser!.uid)/leaderboard").setValue(false)
        }
    }
    
    // A method that updates the current user's email.
    @IBAction func updateButtonPressed(_ sender: Any) {
        let ref = Database.database().reference()
        
        if (changeUsername.text != "" ) {
            ref.child("users/\(Auth.auth().currentUser!.uid)/displayName").setValue(changeUsername.text)
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
