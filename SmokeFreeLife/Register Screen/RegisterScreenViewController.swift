//
//  RegisterScreenViewController.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/3/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterScreenViewController: UIViewController {

    let registerView = RegisterScreenView()
    
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: set up title
        title = "Register"
        
        registerView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)

    }
    
    //MARK: handle register
    @objc func onRegisterTapped(){
        //MARK: validate that name is not empty
        guard let name = registerView.textFieldName.text, !name.isEmpty else {
            //MARK: Show an alert indicating that the name is empty
            showAlert(message: "Please enter your name.")
            return
        }
        
        //MARK: validate that email is not empty and is correctly formatted
        guard let email = registerView.textFieldEmail.text, !email.isEmpty else {
            //MARK: Show an alert indicating that the email is empty or not in a valid format
            showAlert(message: "Please enter a email.")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(message: "Email format invalid.")
            return
        }
        
        //MARK: validate that password is not empty
        guard let password = registerView.textFieldPassword.text, !password.isEmpty else {
            //MARK: Show an alert indicating that the password is empty
            showAlert(message: "Please enter your password.")
            return
        }
        
        //MARK: validate that repeat password is not empty and passwords match
        guard let repeatPassword = registerView.textFieldRepeatPassword.text, !repeatPassword.isEmpty else {
            //MARK: Show an alert indicating that the password is empty
            showAlert(message: "Please re-enter your password.")
            return
        }
        
        if password != repeatPassword {
            showAlert(message: "Passwords must match.")
            return
        }
        
        //MARK: creating a new user on Firebase...
        self.registerNewAccount(name:name, email:email, password:password)
    }
    
    //MARK: Helper method to validate a email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: Helper method to show an alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

