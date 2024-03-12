//
//  SignInScreenView.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/3/23.
//

import UIKit

class SignInScreenView: UIView {
    var scrollView: UIScrollView!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonSignIn: UIButton!
    var labelEmail: UILabel!
    var labelPassword: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        // Initialize UIScrollView
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        // Initialize UI elements
        setuptextFieldEmail()
        setuptextFieldPassword()
        setupbuttonSignIn()
        setupLabels()  // Call the new function
        
        initConstraints()
    }
    
    func setuptextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(textFieldEmail)
    }
    
    func setuptextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.textContentType = .password
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(textFieldPassword)
    }
    
    func setupbuttonSignIn(){
        buttonSignIn = UIButton(type: .system)
        buttonSignIn.setTitle("Sign In", for: .normal)
        buttonSignIn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonSignIn.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonSignIn)
    }
    
    func setupLabels() {
        labelEmail = UILabel()
        labelEmail.text = "Email"
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelEmail)
        
        labelPassword = UILabel()
        labelPassword.text = "Password"
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelPassword)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            // Scroll View Constraints
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Label Email Constraints
            labelEmail.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 32),
            labelEmail.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            // Text Field Email Constraints
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 8),
            textFieldEmail.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textFieldEmail.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            
            // Label Password Constraints
            labelPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            labelPassword.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            // Text Field Password Constraints
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 8),
            textFieldPassword.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textFieldPassword.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            
            // Button Sign In Constraints
            buttonSignIn.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 32),
            buttonSignIn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            buttonSignIn.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
