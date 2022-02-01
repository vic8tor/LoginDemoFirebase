//
//  LoginViewController.swift
//  LoginDemoFirebase
//
//  Created by Victor on 30.01.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.shared.styleTextField(emailTextField)
        Utilities.shared.styleTextField(passwordTextField)
        
        Utilities.shared.styleHollowButton(loginButton)
    }

    @IBAction func loginTapped(_ sender: Any) {
        let email = Authentification.shared.checkTextField(emailTextField)
        let password = Authentification.shared.checkTextField(passwordTextField )
     
        Auth.auth().signIn(withEmail: email, password: password) { resuts, error in
            if error != nil {
                self.errorLabel.text = error?.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "navigationHome") as? UINavigationController
                self.view.window?.rootViewController = homeVC
                self.view.window?.makeKeyAndVisible()
            }
        }
    
    }
    
    @IBAction func remindPassword(_ sender: UIButton) {
    }
    

}
