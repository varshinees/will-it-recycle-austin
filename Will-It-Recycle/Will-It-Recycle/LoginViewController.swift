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

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello")

        //Auth.auth().signOut()
        
        Auth.auth().addStateDidChangeListener() {
          auth, user in

          if user != nil {
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
          }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self
        
        let providers: [FUIAuthProvider] = [
          FUIGoogleAuth()
        ]
        authUI?.providers = providers
        
        let authViewController = authUI!.authViewController()
        
        present(authViewController, animated: false, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
      // handle user (`authDataResult.user`) and error as necessary
        if error == nil {
            //performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
