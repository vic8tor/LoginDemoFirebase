//
//  SignUpViewViewController.swift
//  LoginDemoFirebase
//
//  Created by Victor on 30.01.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!

    @IBOutlet weak var singUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
        // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        activityIndicator.isHidden = true
    }
   // MARK: - PRivate Methods

    private func setUpElements() {
        errorLabel.alpha = 0
        
        Services.shared.styleTextField(firstNameTextField)
        Services.shared.styleTextField(lastNameTextField)
        Services.shared.styleTextField(emailTextField)
        Services.shared.styleTextField(passwordTextField)
        
        Services.shared.styleHollowButton(singUpButton)
    }
    
    private func showError(_ error: String) {
            
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    // MARK: - Public Methods
    
    func validateFields() -> String? {

        if  Authentification.shared.checkTextField(firstNameTextField) == "" ||
            Authentification.shared.checkTextField(emailTextField) == "" ||
            Authentification.shared.checkTextField(lastNameTextField) == "" ||
            Authentification.shared.checkTextField(passwordTextField) == "" {

            return "Please fill in all fields"
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Services.shared.isPasswordValid(cleanedPassword) == false {
           return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        return nil
    }
    //MARK: - @IBActions

    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()

        if error != nil {
            showError(error!)
        } else {
            let firstName = Authentification.shared.checkTextField(firstNameTextField)
            let lastName = Authentification.shared.checkTextField(lastNameTextField)
            let email = Authentification.shared.checkTextField(emailTextField)
            let password = Authentification.shared.checkTextField(passwordTextField)
            
            activityIndicator.startAnimating()
             
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error != nil {
                    self.showError("Error creating user")
                } else {
                    let db = Firestore.firestore()
                    
                    self.activityIndicator.stopAnimating()
                    
                    db.collection("users").addDocument(data: [
                        "firstname": firstName,
                        "lastName": lastName,
                        "uid": result!.user.uid
                    ]) { error in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
//                    self.translitionHome()
                }
            }
        }
    }
    // MARK: - Navigation

//    private func translitionHome() {
//        let homeVC = storyboard?.instantiateViewController(withIdentifier: "navigationHome") as? UINavigationController
//        view.window?.rootViewController = homeVC
//        view.window?.makeKeyAndVisible()
//    }
}
