//
//  Auth.swift
//  LoginDemoFirebase
//
//  Created by Victor on 31.01.2022.
//

import Foundation
import Firebase
import FirebaseAuth

struct Authentification {
  static let shared = Authentification()
    
    

    func checkTextField(_ textField: UITextField) -> String {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return ""}
        return text
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out", signOutError)
        }
    }
 
    private init() {}
}

