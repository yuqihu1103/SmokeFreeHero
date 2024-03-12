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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelText()
        setupButtonForum()
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
    
    // MARK: - Setting up constraints
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelText.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonForum.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 20),
            buttonForum.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            // Add more constraints as needed
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


