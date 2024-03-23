//
//  ProfileScreenViewController.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/6/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileScreenViewController: UIViewController {
    let profileView = ProfileScreenView()
    let defaultProfileImage = UIImage(named: "default_profile_image") // Placeholder image
    
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        fetchUserProfile()
        
        profileView.buttonEdit.addTarget(self, action: #selector(onButtonEditTapped), for: .touchUpInside)
        
        //MARK: observing text if it is updated in NotificationCenter...
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForTextChanged(notification:)),
            name: Notification.Name("infoEdited"),
            object: nil)
    }
    
    @objc func notificationReceivedForTextChanged(notification: Notification){
        self.fetchUserProfile()
    }
    
    func fetchUserProfile() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        Firestore.firestore().collection("Users").document(currentUser.uid).getDocument { [weak self] (snapshot, error) in
            guard let self = self, let data = snapshot?.data() else { return }
            
            DispatchQueue.main.async {
                self.profileView.nameLabel.text = data["username"] as? String ?? "No Name"
                self.profileView.emailLabel.text = currentUser.email ?? "No Email"
                self.profileView.numCigarettesLabel.text = "Cigarettes per day: \(data["numCigarettes"] as? Int ?? 0)"
                self.profileView.amountSpentLabel.text = "Amount spent per day: \(data["amountMoney"] as? Double ?? 0.0)"
                self.loadProfileImage(for: currentUser)
            }
        }
    }
    
    func loadProfileImage(for user: FirebaseAuth.User) {
        if let photoURL = user.photoURL {
            loadImage(from: photoURL)
        } else {
            profileView.profileImageView.image = defaultProfileImage
        }
    }
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self, let data = data, error == nil else {
                self?.profileView.profileImageView.image = self?.defaultProfileImage
                return
            }
            
            DispatchQueue.main.async {
                self.profileView.profileImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    @objc func onButtonEditTapped() {
        let editProfileScreen = EditProfileScreenViewController()
        navigationController?.pushViewController(editProfileScreen, animated: true)
    }
}
