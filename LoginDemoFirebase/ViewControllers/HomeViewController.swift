//
//  HomeViewController.swift
//  LoginDemoFirebase
//
//  Created by Victor on 30.01.2022.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBAction func signOutTapped(_ sender: Any) {
        
        Authentification.shared.signOut()
        dismiss(animated: true, completion: nil)
    }
}
