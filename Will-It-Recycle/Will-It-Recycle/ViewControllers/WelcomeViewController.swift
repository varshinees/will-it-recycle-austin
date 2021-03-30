//
//  WelcomeViewController.swift
//  Will-It-Recycle
//
//  Created by Chelsie Barrientos on 3/30/21.
//

import UIKit

//
// A class which coordinates communication between the data
// and view components of the Welcome View Controller.
//
class WelcomeViewController: UIViewController {
    @IBOutlet weak var dogButton: UIButton!
    
    @IBOutlet weak var birdButton: UIButton!
    
    @IBOutlet weak var fishButton: UIButton!
    
    @IBOutlet weak var catButton: UIButton!
    
    @IBOutlet weak var frogButton: UIButton!
    
    @IBOutlet weak var horseButton: UIButton!
    
    @IBOutlet weak var dragonButton: UIButton!
    
    @IBOutlet weak var hippoButton: UIButton!
    
    // A method which signals that the program is ready.
    override func viewDidLoad() {
        super.viewDidLoad()

        dogButton.showsTouchWhenHighlighted = true
        birdButton.showsTouchWhenHighlighted = true
        fishButton.showsTouchWhenHighlighted = true
        catButton.showsTouchWhenHighlighted = true
        frogButton.showsTouchWhenHighlighted = true
        horseButton.showsTouchWhenHighlighted = true
        dragonButton.showsTouchWhenHighlighted = true
        hippoButton.showsTouchWhenHighlighted = true
    }
}
