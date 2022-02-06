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
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logInAnonim: UIButton!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    self.presentHomeController()
                }
            }
        }
    
    // MARK: - @IBActions

    @IBAction func loginTapped(_ sender: Any) {
        let email = Authentification.shared.checkTextField(emailTextField)
        let password = Authentification.shared.checkTextField(passwordTextField )
        
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { results, error in
            if error != nil {
                self.errorLabel.text = error?.localizedDescription
                self.errorLabel.alpha = 1
                self.activityIndicator.stopAnimating()
                return
            } else {
                self.activityIndicator.stopAnimating()
                self.presentHomeController()
//                self.performSegue(withIdentifier: "loginHome", sender: nil)
//                guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "navigationHome") as? UINavigationController else { return }
//                self.present(homeVC, animated: true, completion: nil)
//                self.view.window?.rootViewController = homeVC
//                self.view.window?.makeKeyAndVisible()
            }
        }
    
    }
    
        @IBAction func anonimTapped(_ sender: Any) {
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    Services.shared.showAlert(on: self, style: .alert, title: "Sign in Error", message: error.localizedDescription)
                    return
                } else {
                    guard let user = result?.user else { return }
                    let isAnonymous = user.isAnonymous
                    let uid = user.uid
                    print(uid)
                }
            }
        }
    
    @IBAction func remindPassword(_ sender: UIButton) {
    }
    
    // MARK: - Private Methods
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Services.shared.styleTextField(emailTextField)
        Services.shared.styleTextField(passwordTextField)
        
        Services.shared.styleHollowButton(singUpButton)
        Services.shared.styleHollowButton(logInAnonim)
        Services.shared.styleHollowButton(loginButton)
    }
    
    private func presentHomeController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "navigationHome")
        present(homeVC, animated: true, completion: nil)
    }
}
