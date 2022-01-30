//
//  SignUpViewViewController.swift
//  LoginDemoFirebase
//
//  Created by Victor on 30.01.2022.
//

import UIKit

class SignUpViewViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!

    @IBOutlet weak var singUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.shared.styleTextField(firstNameTextField)
        Utilities.shared.styleTextField(lastNameTextField)
        Utilities.shared.styleTextField(emailTextField)
        Utilities.shared.styleTextField(passwordTextField)
        
        Utilities.shared.styleHollowButton(singUpButton)
    }
    
    func validateFields() -> String {
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.shared.isPasswordValid(cleanedPassword) == false {
           return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        return ""
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()
        //Validate the fields
        if error != nil {
        showError(error)
        } else {
            
        }
    }
        
        func showError(_ error: String) {
            
            errorLabel.text = error
            errorLabel.alpha = 1
            }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
