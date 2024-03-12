//
//  RegisterScreenView.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/3/23.
//

import UIKit

class RegisterScreenView: UIView {
    var scrollView: UIScrollView!
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var textFieldRepeatPassword: UITextField!
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPassword: UILabel!
    var labelRepeatPassword: UILabel!
    var buttonRegister: UIButton!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        // Initialize UIScrollView
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        // Initialize UI elements
        setuptextFieldName()
        setuptextFieldEmail()
        setuptextFieldPassword()
        setupbuttonRegister()
        setuptextFieldRepeatPassword()
        setupLabels()
        
        initConstraints()
    }
    
    func setuptextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.keyboardType = .default
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(textFieldName)
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
    
    func setuptextFieldRepeatPassword(){
        textFieldRepeatPassword = UITextField()
        textFieldRepeatPassword.placeholder = "Re-enter Password"
        textFieldRepeatPassword.textContentType = .password
        textFieldRepeatPassword.isSecureTextEntry = true
        textFieldRepeatPassword.borderStyle = .roundedRect
        textFieldRepeatPassword.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(textFieldRepeatPassword)
    }
    
    func setupbuttonRegister(){
        buttonRegister = UIButton(type: .system)
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonRegister)
    }
    
    func setupLabels() {
            labelName = UILabel()
            labelName.text = "Name"
            labelName.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(labelName)

            labelEmail = UILabel()
            labelEmail.text = "Email"
            labelEmail.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(labelEmail)

            labelPassword = UILabel()
            labelPassword.text = "Password"
            labelPassword.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(labelPassword)

            labelRepeatPassword = UILabel()
            labelRepeatPassword.text = "Re-enter Password"
            labelRepeatPassword.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(labelRepeatPassword)
        }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            // Scroll View Constraints
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Text Field Name Constraints
            textFieldName.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 32),
            textFieldName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            textFieldName.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            
            // Text Field Email Constraints
            textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 40), // Increased spacing
            textFieldEmail.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            textFieldEmail.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            
            // Text Field Password Constraints
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 40), // Increased spacing
            textFieldPassword.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            textFieldPassword.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            
            // Text Field Repeat Password Constraints
            textFieldRepeatPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 40), // Increased spacing
            textFieldRepeatPassword.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            textFieldRepeatPassword.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            
            // Button Register Constraints
            buttonRegister.topAnchor.constraint(equalTo: textFieldRepeatPassword.bottomAnchor, constant: 32),
            buttonRegister.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            buttonRegister.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // Label Name Constraints
            labelName.bottomAnchor.constraint(equalTo: textFieldName.topAnchor, constant: -8),
            labelName.leadingAnchor.constraint(equalTo: textFieldName.leadingAnchor),

            // Label Email Constraints
            labelEmail.bottomAnchor.constraint(equalTo: textFieldEmail.topAnchor, constant: -8),
            labelEmail.leadingAnchor.constraint(equalTo: textFieldEmail.leadingAnchor),

            // Label Password Constraints
            labelPassword.bottomAnchor.constraint(equalTo: textFieldPassword.topAnchor, constant: -8),
            labelPassword.leadingAnchor.constraint(equalTo: textFieldPassword.leadingAnchor),

            // Label Repeat Password Constraints
            labelRepeatPassword.bottomAnchor.constraint(equalTo: textFieldRepeatPassword.topAnchor, constant: -8),
            labelRepeatPassword.leadingAnchor.constraint(equalTo: textFieldRepeatPassword.leadingAnchor),
        ])
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
