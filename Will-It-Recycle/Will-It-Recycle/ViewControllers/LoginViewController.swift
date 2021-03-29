//
//  LoginViewController.swift
//  Will-It-Recycle
//
//  Created by Varshinee - School on 3/18/21.
//

import UIKit
import FirebaseUI
import Firebase

class LoginViewController: UIViewController, FUIAuthDelegate {
    
    var newUser:Bool? = nil {
        didSet {
            if newUser == true {
                self.performSegue(withIdentifier: "WelcomeSegue", sender: nil)
            } else {
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            return
        }
        
        // Do any additional setup after loading the view.
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self
        
        let providers: [FUIAuthProvider] = [
            FUIEmailAuth(),
            FUIGoogleAuth()
        ]
        authUI?.providers = providers
        
        let authViewController = authUI!.authViewController()
        //authViewController.navigationBar.set
        authViewController.modalPresentationStyle = .fullScreen
        
        present(authViewController, animated: false, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
      // handle user (`authDataResult.user`) and error as necessary
        if error == nil {
            //performSegue(withIdentifier: "LoginSegue", sender: nil)
            if authDataResult!.additionalUserInfo!.isNewUser {
                newUser = true
            } else {
                newUser = false
            }
        }
    }
}
