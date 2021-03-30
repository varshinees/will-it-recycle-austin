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

class SettingsViewController: UIViewController {

    @IBOutlet weak var changeEmail: UITextField!
    
    @IBOutlet weak var updateButton: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let newSwiftColor = UIColor(red: 252, green: 108, blue: 133, alpha: 255)
        
        updateButton.setTitle("Update", for: .normal)
        // updateButton.setBackgroundColor(newSwiftColor, for: .normal)

    }

    @IBAction func updatePressed(_ sender: Any) {
        
        if (changeEmail.text != "") {
            Auth.auth().currentUser?.updateEmail(to: changeEmail.text!, completion: nil)
        }
    }
    
//    @IBAction func signOut(_ sender: Any) {
//        do { try Auth.auth().signOut() }
//            catch { print("already logged out") }
//
            // login, add segue to main.storyboard in settings storyboard
//        performSegue(withIdentifier: "BackToStart", sender: nil)
        
//        let loginVC = LoginViewController()
//        present(loginVC, animated: false, completion: nil)
            
//            navigationController?.popToRootViewController(animated: true)
    }
}
