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
        
        Auth.auth().addStateDidChangeListener() {
          auth, user in

          if user != nil {
            let temp = TempViewController()
            //self.present(temp, animated: false, completion: nil)
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
          }
        }
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
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
        authViewController.modalPresentationStyle = .fullScreen
        
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
