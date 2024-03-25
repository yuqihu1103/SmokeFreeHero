//
//  MainScreenView.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/3/23.
//

import UIKit

class MainScreenView: UIScrollView {
    var labelText: UILabel!
    var buttonForum: UIButton!
    var buttonProfile: UIButton!
    
    var labelSmokeFreeTime: UILabel!
    var labelCigSaved: UILabel!
    var labelMoneySaved: UILabel!
    var buttonSetStartPoint: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelText()
        setupButtonForum()
        setupButtonProfile()
        setupSmokingInfo()
        
        initConstraints()
    }
    
    // MARK: - Initializing UI elements
    
    func setupLabelText() {
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 24)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupButtonForum() {
        buttonForum = UIButton(type: .system)
        buttonForum.setTitle("Forum", for: .normal)
        buttonForum.titleLabel?.font = .systemFont(ofSize: 24)
        buttonForum.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonForum)
    }
    
    func setupButtonProfile() {
        buttonProfile = UIButton(type: .system)
        buttonProfile.setTitle("Profile", for: .normal)
        buttonProfile.titleLabel?.font = .systemFont(ofSize: 24)
        buttonProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonProfile)
    }
    
    func setupSmokingInfo() {
        labelSmokeFreeTime = UILabel()
        labelSmokeFreeTime.font = .systemFont(ofSize: 24)
        labelSmokeFreeTime.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelSmokeFreeTime)
        
        labelCigSaved = UILabel()
        labelCigSaved.font = .systemFont(ofSize: 24)
        labelCigSaved.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCigSaved)
        
        labelMoneySaved = UILabel()
        labelMoneySaved.font = .systemFont(ofSize: 24)
        labelMoneySaved.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelMoneySaved)
        
        buttonSetStartPoint = UIButton(type: .system)
        buttonSetStartPoint.setTitle("Set Start Point", for: .normal)
        buttonSetStartPoint.titleLabel?.font = .systemFont(ofSize: 20)
        buttonSetStartPoint.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSetStartPoint)
    }

    // MARK: - Setting up constraints
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelText.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelSmokeFreeTime.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 32),
            labelSmokeFreeTime.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelCigSaved.topAnchor.constraint(equalTo: labelSmokeFreeTime.bottomAnchor, constant: 10),
            labelCigSaved.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelMoneySaved.topAnchor.constraint(equalTo: labelCigSaved.bottomAnchor, constant: 10),
            labelMoneySaved.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonSetStartPoint.topAnchor.constraint(equalTo: labelMoneySaved.bottomAnchor, constant: 10),
            buttonSetStartPoint.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonForum.topAnchor.constraint(equalTo: buttonSetStartPoint.bottomAnchor, constant: 32),
            buttonForum.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonProfile.topAnchor.constraint(equalTo: buttonForum.bottomAnchor, constant: 20),
            buttonProfile.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


