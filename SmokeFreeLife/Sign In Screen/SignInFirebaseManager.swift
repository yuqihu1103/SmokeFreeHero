//
//  SignInFirebaseManager.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/3/23.
//

import Foundation
import FirebaseAuth

extension SignInScreenViewController {
    
    //MARK: authenticating the user...
    func signInToFirebase(email:String, password:String){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if let error = error as NSError? {
                if let authError = AuthErrorCode.Code(rawValue: error.code){
                    // Check Firebase error codes and handle them accordingly
                    switch authError {
                        case .userDisabled:
                            self.showAlert(message: "User is disabled.")
                        case .invalidEmail:
                            self.showAlert(message: "Invalid email format. Please enter a valid email.")
                        case .wrongPassword:
                            self.showAlert(message: "Email and password do not match. Please try again.")
                        default:
                            self.showAlert(message: "Error with signing in: \(error.localizedDescription)")
                    }
                }
            } else {
                //MARK: if no error, the user login is successful...
                self.notificationCenter.post(
                    name: Notification.Name("userChanged"),
                    object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
}
