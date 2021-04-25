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

var newUsername = ""

//
// A class which coordinates communication between the data
// and view components of the Settings View Controller.
//
class SettingsViewController: UIViewController, UNUserNotificationCenterDelegate {
    @IBOutlet weak var statsLabel: UILabel!
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var changeUsername: UITextField!
    @IBOutlet weak var changeEmail: UITextField!
    
    @IBOutlet weak var appNotify: UISwitch!
    @IBOutlet weak var leaderSettings: UISwitch!
    
    @IBOutlet weak var updateButton: MDCButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    // A method which signals that the program is ready.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // A method which signals that the view will appear.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        populateSettings()
    }
    
    // A method which populates the Settings according to the current user's specifications.
    func populateSettings() {
        UNUserNotificationCenter.current().delegate = self
        
        // Populate the Settings and display the current user's name and current leaves.
        let ref = Database.database().reference()
        
        ref.child("users/\(Auth.auth().currentUser!.uid)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                guard let user = snapshot.value as? [String: Any] else {
                      return
                    }

                DispatchQueue.main.async() {
                    if user["avatar"] != nil {
                        self.avatarImage.image = UIImage(named: user["avatar"] as! String)
                    }
                    self.statsLabel.text = user["displayName"] as! String + " | " + String(Int(user["currentLeaves"] as! Int)) + " Leaves"
                    
                    UNUserNotificationCenter.current().getNotificationSettings { (settings) in

                        switch settings.authorizationStatus {
                        case .authorized:
                            DispatchQueue.main.async() {
                                ref.child("users/\(Auth.auth().currentUser!.uid)/notifications").setValue(true)
                                notifications = true
                                self.appNotify.isOn = true
                            }

                        case .denied:
                            DispatchQueue.main.async() {
                                ref.child("users/\(Auth.auth().currentUser!.uid)/notifications").setValue(false)
                                notifications = false
                                self.appNotify.isOn = false
                            }

                        case .notDetermined:
                            print("notDetermined")

                        case .provisional:
                            print("provisional")

                        case .ephemeral:
                            print("ephemeral")

                        default:
                            print("error")
                        }
                    }
                    
                    if (user["leaderboard"] as! Int == 0) {
                        leaderboard = false
                        self.leaderSettings.isOn = false

                    } else {
                        leaderboard = true
                        self.leaderSettings.isOn = true
                    }
                }
            }
            else {
                print("User does not exist")
            }
        }
        
        changeUsername.clearsOnBeginEditing = true
        changeEmail.clearsOnBeginEditing = true

        updateButton.setTitle("Update", for: .normal)
    }
    
    // A method that allows the user to turn on or off app notifications.
    @IBAction func appNotifySwitched(_ sender: Any) {
        
        // Give the user the option to turn on or off app notifications.
        let ref = Database.database().reference()
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async() {
                let alertController = UIAlertController(title: nil, message: "Do you want to change notifications settings?", preferredStyle: .alert)

                let action1 = UIAlertAction(title: "Settings",
                                            style: .default) { (action:UIAlertAction) in
                    if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings as URL, options: [:], completionHandler: nil)
                    }
                }

                let action2 = UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler:  { _ in
                                                if (notifications) {
                                                    ref.child("users/\(Auth.auth().currentUser!.uid)/notifications").setValue(true)
                                                    self.appNotify.isOn = true
                                        
                                                } else {
                                                    ref.child("users/\(Auth.auth().currentUser!.uid)/notifications").setValue(false)
                                                    self.appNotify.isOn = false
                                                }
                                            })

                alertController.addAction(action1)
                alertController.addAction(action2)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    // A method that allows the user to opt out of or join the leaderboard.
    @IBAction func leaderSettingsSwitched(_ sender: Any) {
        
        // If the user has not joined the leaderboard, give them the option to opt in.
        if (leaderSettings.isOn) {
            let controller = UIAlertController(
                title: "Would you like to join the leaderboard?",
                message: nil,
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "Yes",
                                    style: .cancel,
                                    handler: {
                                        (action) in
                                        let ref = Database.database().reference()
                                        
                                        DispatchQueue.main.async() {
                                            leaderboard = true
                                            self.leaderSettings.isOn = true
                                            ref.child("users/\(Auth.auth().currentUser!.uid)/leaderboard").setValue(true)
                                        }
                                    }))
            
            controller.addAction(UIAlertAction(
                                    title: "No",
                                    style: .default,
                                    handler: {
                                        (action) in
                                        let ref = Database.database().reference()
                                        
                                        DispatchQueue.main.async() {
                                            leaderboard = false
                                            self.leaderSettings.isOn = false
                                            ref.child("users/\(Auth.auth().currentUser!.uid)/leaderboard").setValue(false)
                                        }
                                    }))
            
            present(controller, animated: true, completion: nil)
            
            // If the user has joined the leaderboard, give them the option to opt out.
        } else {
            let controller = UIAlertController(
                title: "Would you like to opt out of the leaderboard?",
                message: nil,
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(
                                    title: "Yes",
                                    style: .cancel,
                                    handler: {
                                        (action) in
                                        let ref = Database.database().reference()
                                        
                                        DispatchQueue.main.async() {
                                            leaderboard = false
                                            self.leaderSettings.isOn = false
                                            ref.child("users/\(Auth.auth().currentUser!.uid)/leaderboard").setValue(false)
                                        }
                                    }))
            
            controller.addAction(UIAlertAction(
                                    title: "No",
                                    style: .default,
                                    handler: {
                                        (action) in
                                        let ref = Database.database().reference()
                                        
                                        DispatchQueue.main.async() {
                                            leaderboard = true
                                            self.leaderSettings.isOn = true
                                            ref.child("users/\(Auth.auth().currentUser!.uid)/leaderboard").setValue(true)
                                        }
                                    }))
            
            present(controller, animated: true, completion: nil)
        }
    }
    
    // A method that updates the current user's email.
    @IBAction func updateButtonPressed(_ sender: Any) {
                    
        let ref = Database.database().reference()
        
        if (changeUsername.text != "" ) {
            ref.child("users/\(Auth.auth().currentUser!.uid)/displayName").setValue(changeUsername.text)
            newUsername = changeUsername.text!
            
            ref.child("users/\(Auth.auth().currentUser!.uid)").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    guard let user = snapshot.value as? [String: Any] else {
                          return
                        }

                    DispatchQueue.main.async() {
                        if user["avatar"] != nil {
                            self.avatarImage.image = UIImage(named: user["avatar"] as! String)
                        }
                        self.statsLabel.text = newUsername + " | " + String(Int(user["currentLeaves"] as! Int)) + " Leaves"
                    }
                }
            }
        }
        
        if (changeEmail.text != "") {
            Auth.auth().currentUser?.updateEmail(to: changeEmail.text!, completion: nil)
        }
    }
    
    // A method that deletes the current user's account.
    @IBAction func deleteButtonPressed(_ sender: Any) {
        let controller = UIAlertController(
            title: "Are you sure you want to delete your account?",
            message: nil,
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(
                                title: "Yes",
                                style: .cancel,
                                handler: {
                                    (action) in
                                    let ref = Database.database().reference()
                                    
                                    Auth.auth().currentUser!.delete(completion: nil)
                                    
                                    ref.child("users/\(Auth.auth().currentUser!.uid)").removeValue()
                                    
                                    self.performSegue(withIdentifier: "restartSegueIdentifier", sender: nil)
                                }))
        
        controller.addAction(UIAlertAction(
                                title: "No",
                                style: .default,
                                handler: nil))
        
        present(controller, animated: true, completion: nil)
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
    
    // code to enable tapping on the background to remove software keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
