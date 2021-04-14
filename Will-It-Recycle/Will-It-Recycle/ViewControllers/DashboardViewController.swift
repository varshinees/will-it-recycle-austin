//
//  DashboardViewController.swift
//  Will-It-Recycle
//
//  Created by Chelsie Barrientos on 3/26/21.
//

import UIKit
import Firebase
import MaterialComponents
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

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
    
    @IBOutlet weak var leader1: UILabel!
    @IBOutlet weak var leader2: UILabel!
    @IBOutlet weak var leader3: UILabel!
    @IBOutlet weak var leader4: UILabel!
    @IBOutlet weak var leader5: UILabel!
    
    @IBOutlet weak var leader1Label: UILabel!
    @IBOutlet weak var leader2Label: UILabel!
    @IBOutlet weak var leader3Label: UILabel!
    @IBOutlet weak var leader4Label: UILabel!
    @IBOutlet weak var leader5Label: UILabel!
    
    // A method which signals that the program is ready.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateDashboard()
    }
    
    // A method which signals that the view will appear.
    func viewWillAppear() {
        super.viewWillAppear(false)
        
        populateDashboard()
    }
    
    // A method which populates the Dashboard according to the current user's specifications.
    func populateDashboard() {
        
        // Populate the leaderboard.
        DispatchQueue.main.async() {
            var ref: DatabaseReference!
            ref = Database.database().reference()
             
            let users = ref.child("users").queryOrdered(byChild: "allTimeLeaves").queryLimited(toFirst: 6)

            users.observe(.value, with: { (snapshot) in
              if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                var index = 1
                for snap in snapshot.reversed() {
                    let user = snap.value as! [String:Any]
                    
                    if (user["leaderboard"] as! Int == 1) {
                        if index == 1 {
                            self.leader1.text = user["displayName"] as? String
                            self.leader1Label.text = String(Int(user["allTimeLeaves"] as! Int)) + " Leaves"
                            
                        } else if index == 2 {
                            self.leader2.text = user["displayName"] as? String
                            self.leader2Label.text = String(Int(user["allTimeLeaves"] as! Int)) + " Leaves"
                            
                        } else if index == 3 {
                            self.leader3.text = user["displayName"] as? String
                            self.leader3Label.text = String(Int(user["allTimeLeaves"] as! Int)) + " Leaves"
                            
                        } else if index == 4 {
                            self.leader4.text = user["displayName"] as? String
                            self.leader4Label.text = String(Int(user["allTimeLeaves"] as! Int)) + " Leaves"
                            
                        } else {
                            self.leader5.text = user["displayName"] as? String
                            self.leader5Label.text = String(Int(user["allTimeLeaves"] as! Int)) + " Leaves"
                        }
                        index += 1
                    }
                }
              }
            })
        }
        
        // Display the current user's name, all time leaves, and current leaves.
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
                    let displayName =  user["displayName"] as! String
                    
                    self.nameLabel.text = "Welcome, " + displayName + "!"
                    
                    self.totalLeaves.text = "You have earned " + String(Int(user["allTimeLeaves"] as! Int)) + " leaves total."
                    
                    self.currentLeaves.text = "You have " + String(Int(user["currentLeaves"] as! Int)) + " leaves unredeemed."
                }
            }
            else {
                print("User does not exist")
            }
        }
        
        // Add elevation to Dashboard Cards.
        statsCard.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
        leaderboardCard.setShadowElevation(ShadowElevation(rawValue: 10),for: .normal)
    }
}
