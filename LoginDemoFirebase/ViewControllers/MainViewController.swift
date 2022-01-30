//
//  ViewController.swift
//  LoginDemoFirebase
//
//  Created by Victor on 30.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
    }
    @IBAction func loginTapped(_ sender: Any) {
    }
    
    func setUpElements() {
        Utilities.shared.styleHollowButton(loginButton)
        Utilities.shared.styleHollowButton(singUpButton)
    }
}
