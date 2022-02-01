//
//  StorageManager.swift
//  LoginDemoFirebase
//
//  Created by Victor on 30.01.2022.
//

import Foundation
import Firebase

struct StorageManager {
    
    static let shared = StorageManager()
       
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let db = Firestore.firestore()
    

    // MARK: - Initializers
    private init() {}
        
    // MARK: - Public Methods
    func createUser(firstName: String, lastName: String, withEmail email: String, password: String, completion: @escaping ((String) -> Void)) {
    Auth.auth().createUser(withEmail: email, password: password) { results, error in
        if error != nil {
            completion("Error creating user")
        } else {
            db.collection("users").addDocument(data: [
                "firstName": firstName,
                "lastName": lastName,
                "uid": results!.user.uid
            ]) { err in
                if err != nil {
                    completion("Error adding user data")
                    }
                }
            }
        }
    }

    // MARK: - Private Methods
}

