//
//  RegisterFirebaseManager.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/3/23.
//

import Foundation
import FirebaseAuth

extension RegisterScreenViewController{
    
    func registerNewAccount(name: String, email: String, password: String) {
        //MARK: create a Firebase user with email and password...
        Auth.auth().createUser(withEmail: email, password: password, completion:  { result, error in
            if let error = error as NSError? {
                if let authError = AuthErrorCode.Code(rawValue: error.code){
                    // Check Firebase error codes and handle them accordingly
                    switch authError {
                        case .emailAlreadyInUse:
                            self.showAlert(message: "Email is already in use. Please use a different email.")
                        case .invalidEmail:
                            self.showAlert(message: "Invalid email format. Please enter a valid email.")
                        case .weakPassword:
                            self.showAlert(message: "Password is too weak. Please use a stronger password.")
                        default:
                            self.showAlert(message: "Error with creating the user: \(error.localizedDescription)")
                    }
                }
            } else {
                //MARK: if no error, the user creation is successful...
                self.setNameOfTheUserInFirebaseAuth(name: name)
            }
        })
    }

    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if let error = error as NSError? {
                self.showAlert(message: "Error with creating the user: \(error.localizedDescription)")
            } else {
                //MARK: the profile update is successful...
                self.navigationController?.popViewController(animated: true)
            }

        })
    }
}



