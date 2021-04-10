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

public struct UserObject {
    let allTimeLeaves: Int
    let currentLeaves: Int
    let displayName: String
    let leaderboard: Int
    let notifications: Int
    let rewardsForToday: Int
    let history: [String:Any]
}

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
        
        let ref = Database.database().reference()
        
        // Adds elevation to Dashboard Cards.
        statsCard.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
        leaderboardCard.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
        
        nameLabel.text = "Welcome, " + Auth.auth().currentUser!.displayName!
        
        ref.child("users/\(Auth.auth().currentUser!.uid)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                guard let user = snapshot.value as? [String: Any] else {
                      return
                    }
                
                DispatchQueue.main.async() {
                    self.totalLeaves.text = "You have earned " + String(Int(user["allTimeLeaves"] as! Int)) + " leaves total."
                    
                    self.currentLeaves.text = "You have " + String(Int(user["currentLeaves"] as! Int)) + " leaves unredeemed."
                }
            }
            else {
                print("User does not exist")
            }
        }
        
        if (leaderboard) {
            
            // let topFiveLeaders = ref.child("users").queryOrdered(byChild: "currentLeaves").queryLimited(toFirst: 5)
            
            
            ref.child("users").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    guard let users = snapshot.value as? [String: Any] else {
                          return
                        }
                    
                    var maxLeaves = 0
                    var maxUser = ""
                    
                    for (_, user) in users {
                        guard let currentUser = user as? [String: Any] else {
                              return
                            }
                        if (Int((currentUser["allTimeLeaves"] as? Int)!) > maxLeaves) {
                            maxLeaves = (currentUser["allTimeLeaves"] as? Int)!
                            maxUser = (currentUser["displayName"] as? String)!
                        }
                    }


                    
                }
                else {
                    print("User does not exist")
                }
            }

        }
    }
}
