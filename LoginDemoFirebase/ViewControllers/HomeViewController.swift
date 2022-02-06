//
//  HomeViewController.swift
//  LoginDemoFirebase
//
//  Created by Victor on 30.01.2022.
//

import UIKit
import Firebase

class HomeViewController: UITableViewController {
   
    // MARK: - IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWelcome()
    }
    
    // MARK: - @IBActions
    
    @IBAction func signOutTapped(_ sender: Any) {
        if let _ = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()
                dismiss(animated: true, completion: nil)
            } catch {
                print("Error")
            }
        }
    }
    
    @IBAction func createTaskTapped(_ sender: Any) {
    
        let alertController = UIAlertController(title: "New Task", message: "Add new task", preferredStyle: .alert)
        alertController.addTextField()
        
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
        }
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(save)
            alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }

    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func displayWelcome() {
        UIView.animate(
            withDuration: 3,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: { [weak self] in
                self?.welcomeLabel.alpha = 0
            }) { [weak self] complete in
                self?.welcomeLabel.alpha = 0
            }
    }
}

extension HomeViewController {
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        cell.backgroundColor = .clear
        content.text = "This is cell number \(indexPath.row)"
        content.textProperties.color = .black
        cell.contentConfiguration = content

        return cell
    }
}
