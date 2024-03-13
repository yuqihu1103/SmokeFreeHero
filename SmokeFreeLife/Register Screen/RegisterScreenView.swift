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
    
    var textFieldNumCigarettes: UITextField!
    var textFieldAmountMoney: UITextField!
    var labelNumCigarettes: UILabel!
    var labelAmountMoney: UILabel!
    
    var labelPhoto:UILabel!
    var buttonTakePhoto: UIButton!
    
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
        
        setuptextFieldNumCigarettes()
        setuptextFieldAmountMoney()
        setupLabelsForAdditionalInfo()
        
        setuplabelPhoto()
        setupbuttonTakePhoto()
        
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
    
    func setuptextFieldNumCigarettes() {
            textFieldNumCigarettes = UITextField()
            textFieldNumCigarettes.placeholder = "Number of cigarettes per day"
            textFieldNumCigarettes.keyboardType = .numberPad
            textFieldNumCigarettes.borderStyle = .roundedRect
            textFieldNumCigarettes.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(textFieldNumCigarettes)
        }
        
        func setuptextFieldAmountMoney() {
            textFieldAmountMoney = UITextField()
            textFieldAmountMoney.placeholder = "Amount of money spent per day"
            textFieldAmountMoney.keyboardType = .decimalPad
            textFieldAmountMoney.borderStyle = .roundedRect
            textFieldAmountMoney.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(textFieldAmountMoney)
        }
        
        func setupLabelsForAdditionalInfo() {
            labelNumCigarettes = UILabel()
            labelNumCigarettes.text = "Number of cigarettes per day"
            labelNumCigarettes.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(labelNumCigarettes)

            labelAmountMoney = UILabel()
            labelAmountMoney.text = "Amount of money spent per day"
            labelAmountMoney.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(labelAmountMoney)
        }
    
    func setuplabelPhoto(){
        labelPhoto = UILabel()
        labelPhoto.text = "Add Profile Photo"
        labelPhoto.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelPhoto)
    }
    
    func setupbuttonTakePhoto(){
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.setImage(UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        //buttonTakePhoto.setImage(UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonTakePhoto)
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
            buttonRegister.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 32),
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
        
            // Text Field Num Cigarettes Constraints
                    textFieldNumCigarettes.topAnchor.constraint(equalTo: textFieldRepeatPassword.bottomAnchor, constant: 40),
                    textFieldNumCigarettes.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                    textFieldNumCigarettes.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
                    
                    // Text Field Amount Money Constraints
                    textFieldAmountMoney.topAnchor.constraint(equalTo: textFieldNumCigarettes.bottomAnchor, constant: 40),
                    textFieldAmountMoney.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                    textFieldAmountMoney.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
                    
                    // Label Num Cigarettes Constraints
                    labelNumCigarettes.bottomAnchor.constraint(equalTo: textFieldNumCigarettes.topAnchor, constant: -8),
                    labelNumCigarettes.leadingAnchor.constraint(equalTo: textFieldNumCigarettes.leadingAnchor),
                    
                    // Label Amount Money Constraints
                    labelAmountMoney.bottomAnchor.constraint(equalTo: textFieldAmountMoney.topAnchor, constant: -8),
                    labelAmountMoney.leadingAnchor.constraint(equalTo: textFieldAmountMoney.leadingAnchor),
            
            // Label Photo Constraints
            labelPhoto.topAnchor.constraint(equalTo: textFieldAmountMoney.bottomAnchor, constant: 8),
            labelPhoto.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // Button Take Photo Constraints
            buttonTakePhoto.topAnchor.constraint(equalTo: labelPhoto.bottomAnchor, constant: 8),
            buttonTakePhoto.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 40),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


