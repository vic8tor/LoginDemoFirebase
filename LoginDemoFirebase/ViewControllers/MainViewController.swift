//
//  ViewController.swift
//  LoginDemoFirebase
//
//  Created by Victor on 30.01.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class MainViewController: UIViewController {

    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                let homeVC = self?.storyboard?.instantiateViewController(withIdentifier: "navigationHome") as? UINavigationController
                self?.view.window?.rootViewController = homeVC
                self?.view.window?.makeKeyAndVisible()
            }
        }
    }
    
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
