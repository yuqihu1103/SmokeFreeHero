//
//  ProfileScreenView.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/6/23.
//

import UIKit

class ProfileScreenView: UIView {
    var scrollView: UIScrollView!
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var numCigarettesLabel: UILabel!
    var amountSpentLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "hourglass")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(profileImageView)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(nameLabel)
        
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(emailLabel)
        
        numCigarettesLabel = UILabel()
        numCigarettesLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(numCigarettesLabel)
        
        amountSpentLabel = UILabel()
        amountSpentLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(amountSpentLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            numCigarettesLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            numCigarettesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            amountSpentLabel.topAnchor.constraint(equalTo: numCigarettesLabel.bottomAnchor, constant: 10),
            amountSpentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            amountSpentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
