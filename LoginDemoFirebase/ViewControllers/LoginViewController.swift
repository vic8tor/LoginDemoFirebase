//
//  LoginViewController.swift
//  LoginDemoFirebase
//
//  Created by Victor on 30.01.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.shared.styleTextField(firstNameTextField)
        Utilities.shared.styleTextField(lastNameTextField)
        
        Utilities.shared.styleHollowButton(loginButton)
    }

    @IBAction func loginTapped(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
