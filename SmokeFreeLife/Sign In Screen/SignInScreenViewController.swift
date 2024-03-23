//
//  SignInScreenViewController.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/3/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignInScreenViewController: UIViewController {

    let signInView = SignInScreenView()
    
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: set up title
        title = "Sign In"
        
        signInView.buttonSignIn.addTarget(self, action: #selector(onSignInTapped), for: .touchUpInside)
        
        
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)

    }
    
    //MARK: handle sign in
    @objc func onSignInTapped(){
        //MARK: validate that email is not empty and is correctly formatted
        guard let email = signInView.textFieldEmail.text, !email.isEmpty, isValidEmail(email) else {
            //MARK: Show an alert indicating that the email is empty or not in a valid format
            showAlert(message: "Please enter a valid email.")
            return
        }
        
        //MARK: validate that password is not empty
        guard let password = signInView.textFieldPassword.text, !password.isEmpty else {
            //MARK: Show an alert indicating that the password is empty
            showAlert(message: "Please enter your password.")
            return
        }
        
        //MARK: creating a new user on Firebase...
        self.signInToFirebase(email:email, password:password)
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
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
}


