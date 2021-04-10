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

//open class UNNotificationSettings : NSObject, NSCopying, NSSecureCoding {
//
//
//    open var authorizationStatus: UNAuthorizationStatus { get }
//
//
//    open var soundSetting: UNNotificationSetting { get }
//
//    open var badgeSetting: UNNotificationSetting { get }
//
//    open var alertSetting: UNNotificationSetting { get }
//
//
//    open var notificationCenterSetting: UNNotificationSetting { get }
//}

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
        
        // assume they are on, catch error when it fails
        // ask if not. off or on
        
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
        
//        let center = UNUserNotificationCenter.current()
//        center.getNotificationSettings { (settings) in
//
//            if(settings.authorizationStatus == .authorized) {
//                print("Push notification is enabled")
//                notifications = true
//                self.appNotify.isOn = true
//
//            } else {
//                print("Push notification is not enabled")
//                notifications = false
//                self.appNotify.isOn = false
//            }
//        }
        
//        DispatchQueue.main.async() {
//            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
//            if isRegisteredForRemoteNotifications {
//                 // User is registered for notification
//                notifications = true
//                self.appNotify.isOn = true
//
//                print("Enabled")
//            } else {
//                 // Show alert user is not registered for notification
//                notifications = false
//                self.appNotify.isOn = false
//                print("Not Enabled")
//            }
//        }
        
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
