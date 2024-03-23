//
//  EditProfileScreenViewController.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/7/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class EditProfileScreenViewController: UIViewController {

    let editProfileView = EditProfileScreenView()
    var pickedImage:UIImage?
    let storage = Storage.storage()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = editProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Smoking Info"
        editProfileView.saveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        
        // Load user data and populate the fields
        populateUserData()
        
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }

    func populateUserData() {
        guard let currentUser = Auth.auth().currentUser else { return }

        Firestore.firestore().collection("Users")
            .whereField("username", isEqualTo: currentUser.displayName ?? "")
            .getDocuments { [weak self] (snapshot, error) in
                guard let self = self, let snapshot = snapshot else { return }

                if let data = snapshot.documents.first?.data() {
                    DispatchQueue.main.async {
                        self.editProfileView.numCigarettesTextField.placeholder = "\(data["numCigarettes"] as? Int ?? 0)"
                        self.editProfileView.amountSpentTextField.placeholder = "\(data["amountMoney"] as? Double ?? 0.0)"
                    }
                }
        }
    }

    @objc func saveChanges() {
        guard let currentUser = Auth.auth().currentUser,
              let numCigarettesText = editProfileView.numCigarettesTextField.text,
              let amountSpentText = editProfileView.amountSpentTextField.text,
              let numCigarettes = Int(numCigarettesText),
              let amountSpent = Double(amountSpentText) else {
            showAlert(message: "Missing or invalid input! Num Cig must be integer and Amount Spent must be a number!")
            return
        }
        
        guard numCigarettes >= 0, amountSpent >= 0 else {
            showAlert(message: "Both values must be positive!")
            return
        }

        Firestore.firestore().collection("Users")
            .whereField("username", isEqualTo: currentUser.displayName ?? "")
            .getDocuments { [weak self] (snapshot, error) in
                guard let _ = self, let snapshot = snapshot else { return }

                if let document = snapshot.documents.first {
                    let userRef = Firestore.firestore().collection("Users").document(document.documentID)
                    userRef.updateData(["numCigarettes": numCigarettes])
                    userRef.updateData(["amountMoney": amountSpent])
                    self?.notificationCenter.post(
                        name: Notification.Name("infoEdited"),
                        object: nil)
                    self?.navigationController?.popViewController(animated: true)
                }

        }
    }
    
    //MARK: Helper method to show an alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
