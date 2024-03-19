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
    
    override func loadView() {
        view = editProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Smoking Info"
        editProfileView.saveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        
        // Load user data and populate the fields
        populateUserData()
    }
    
    // Inside the EditProfileScreenViewController

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
                }
                self?.navigationController?.popViewController(animated: true)
        }
    }

}
