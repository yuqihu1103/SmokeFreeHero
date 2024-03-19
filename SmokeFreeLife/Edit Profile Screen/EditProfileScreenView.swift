//
//  EditProfileScreenView.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/7/23.
//

import UIKit

class EditProfileScreenView: UIView {
    var scrollView: UIScrollView!
    var numCigarettesLabel: UILabel!
    var numCigarettesTextField: UITextField!
    var amountSpentLabel: UILabel!
    var amountSpentTextField: UITextField!
    var saveButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        numCigarettesLabel = UILabel()
        numCigarettesLabel.text = "Number of cigarettes per day"
        numCigarettesLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(numCigarettesLabel)
        
        numCigarettesTextField = UITextField()
        numCigarettesTextField.placeholder = "Enter number"
        numCigarettesTextField.keyboardType = .numberPad
        numCigarettesTextField.borderStyle = .roundedRect
        numCigarettesTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(numCigarettesTextField)
        
        amountSpentLabel = UILabel()
        amountSpentLabel.text = "Amount of money spent per day"
        amountSpentLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(amountSpentLabel)
        
        amountSpentTextField = UITextField()
        amountSpentTextField.placeholder = "Enter amount"
        amountSpentTextField.keyboardType = .decimalPad
        amountSpentTextField.borderStyle = .roundedRect
        amountSpentTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(amountSpentTextField)
        
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save Changes", for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(saveButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            numCigarettesLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            numCigarettesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            numCigarettesTextField.topAnchor.constraint(equalTo: numCigarettesLabel.bottomAnchor, constant: 8),
            numCigarettesTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            numCigarettesTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            amountSpentLabel.topAnchor.constraint(equalTo: numCigarettesTextField.bottomAnchor, constant: 20),
            amountSpentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            amountSpentTextField.topAnchor.constraint(equalTo: amountSpentLabel.bottomAnchor, constant: 8),
            amountSpentTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            amountSpentTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: amountSpentTextField.bottomAnchor, constant: 40),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
