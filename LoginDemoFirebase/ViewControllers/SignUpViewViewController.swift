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

    
        // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self, selector: #selector(kbDidShow),
            name: UIResponder.keyboardDidShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    
        setUpElements()
        
    }
   // MARK: - PRivate Methods

    private func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.shared.styleTextField(firstNameTextField)
        Utilities.shared.styleTextField(lastNameTextField)
        Utilities.shared.styleTextField(emailTextField)
        Utilities.shared.styleTextField(passwordTextField)
        
        Utilities.shared.styleHollowButton(singUpButton)
    }
    
    private func showError(_ error: String) {
            
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    // MARK: - Public Methods
    
    @objc func kbDidShow(notifications: Notification) {
        guard let userInfo = notifications.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width,
                                                          height: self.view.bounds.height + kbFrameSize.height)
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: kbFrameSize.height,
            right: 0
        )
    
    }
    @objc func kbDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width,
                                                          height: self.view.bounds.height)
    }
    
    func validateFields() -> String? {
        
        if  Authentification.shared.checkTextField(firstNameTextField) == "" ||
            Authentification.shared.checkTextField(emailTextField) == "" ||
            Authentification.shared.checkTextField(lastNameTextField) == "" ||
            Authentification.shared.checkTextField(passwordTextField) == "" {
            
            return "Please fill in all fields"
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.shared.isPasswordValid(cleanedPassword) == false {
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

            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error != nil {
                    self.showError("Error creating user")
                } else {
                    let db = Firestore.firestore()

                    db.collection("users").addDocument(data: [
                        "firstname": firstName,
                        "lastName": lastName,
                        "uid": result!.user.uid
                    ]) { error in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
                    self.translitionHome()
                }

            }
        }
    }
    // MARK: - Navigation

    private func translitionHome() {
        let homeVC = storyboard?.instantiateViewController(withIdentifier: "navigationHome") as? UINavigationController
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
}
