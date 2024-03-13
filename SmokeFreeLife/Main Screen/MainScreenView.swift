//
//  MainScreenView.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/3/23.
//

import UIKit

class MainScreenView: UIView {
    var labelText: UILabel!
    var buttonForum: UIButton!
    var buttonProfile: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelText()
        setupButtonForum()
        setupButtonProfile()
        
        initConstraints()
    }
    
    // MARK: - Initializing UI elements
    
    func setupLabelText() {
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 32)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupButtonForum() {
        buttonForum = UIButton(type: .system)
        buttonForum.setTitle("Forum", for: .normal)
        buttonForum.titleLabel?.font = .systemFont(ofSize: 32)
        buttonForum.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonForum)
    }
    
    func setupButtonProfile() {
        buttonProfile = UIButton(type: .system)
        buttonProfile.setTitle("Profile", for: .normal)
        buttonProfile.titleLabel?.font = .systemFont(ofSize: 32)
        buttonProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonProfile)
    }
    
    // MARK: - Setting up constraints
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelText.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonForum.topAnchor.constraint(equalTo: buttonProfile.bottomAnchor, constant: 20),
            buttonForum.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonProfile.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 20),
            buttonProfile.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


