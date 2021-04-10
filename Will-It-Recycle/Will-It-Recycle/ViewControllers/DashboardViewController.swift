//
//  DashboardViewController.swift
//  Will-It-Recycle
//
//  Created by Chelsie Barrientos on 3/26/21.
//

import UIKit
import Firebase
import MaterialComponents
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming
import MaterialComponents.MaterialCards

//
// A class which coordinates communication between the data
// and view components of the Dashboard View Controller.
//
class DashboardViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var totalLeaves: UILabel!
    
    @IBOutlet weak var currentLeaves: UILabel!
    
    @IBOutlet weak var statsCard: MDCCard!
    
    @IBOutlet weak var leaderboardCard: MDCCard!
    
    // A method which signals that the program is ready.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds elevation to Dashboard Cards.
        statsCard.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
        leaderboardCard.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
        
        nameLabel.text = "Welcome, " + Auth.auth().currentUser!.displayName!
        
        //totalLeaves = Auth.auth().currentUser!.
        
        if (leaderboard) {
            
            let ref = Database.database().reference()
            
            let topFiveLeaders = ref.child("users").queryOrdered(byChild: "currentLeaves").queryLimited(toFirst: 5)
            
            topFiveLeaders.observeSingleEvent(of: .value, with: {
                (snapshot) in
                
                // cast snapshot to struct
                // dict of string any?
                
                print(snapshot.value!)
                
                }) { (error) in
                  print(error.localizedDescription)
            }

        }
    }
}
