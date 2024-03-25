//
//  ForumScreenView.swift
//  SmokeFreeLife
//
//  Created by XuanShichun on 12/6/23.
//

import UIKit

class ForumScreenView: UIScrollView {
    
    var labelTitle: UILabel!
    var postTableView: UITableView!
    
    var textFieldTitle:UITextField!
    var textFieldContent:UITextField!
    var buttonPost:UIButton!
    var bottomAddView:UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLabelTitle()
        setupPostTableView()
        setupBottomAddView()
        setupTextFieldTitle()
        setupTextFieldContent()
        setupButtonPost()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelTitle(){
        labelTitle = UILabel()
        labelTitle.text = "Online Forum"
        labelTitle.font = UIFont.monospacedSystemFont(ofSize: 24, weight: .regular)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTitle)
    }
    
    func setupPostTableView(){
        postTableView = UITableView()
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: "posts")
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(postTableView)
    }
    
    func setupBottomAddView(){
        bottomAddView = UIView()
        bottomAddView.backgroundColor = .white
        bottomAddView.layer.cornerRadius = 6
        bottomAddView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomAddView.layer.shadowOffset = .zero
        bottomAddView.layer.shadowRadius = 4.0
        bottomAddView.layer.shadowOpacity = 0.7
        bottomAddView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomAddView)
    }
    
    func setupTextFieldTitle(){
        textFieldTitle = UITextField()
        textFieldTitle.placeholder = "Title"
        textFieldTitle.borderStyle = .roundedRect
        textFieldTitle.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(textFieldTitle)
    }
    
    func setupTextFieldContent(){
        textFieldContent = UITextField()
        textFieldContent.placeholder = "Body text"
        textFieldContent.borderStyle = .roundedRect
        textFieldContent.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(textFieldContent)
    }
    
    func setupButtonPost(){
        buttonPost = UIButton(type: .system)
        buttonPost.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonPost.setTitle("Post", for: .normal)
        buttonPost.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(buttonPost)
    }
    
    func initConstraints(){
            NSLayoutConstraint.activate([
                
                labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
                labelTitle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

                postTableView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
                postTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -35),
                postTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                postTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                
                
                bottomAddView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
                bottomAddView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                bottomAddView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                
                buttonPost.bottomAnchor.constraint(equalTo: bottomAddView.bottomAnchor, constant: -8),
                buttonPost.leadingAnchor.constraint(equalTo: bottomAddView.leadingAnchor, constant: 4),
                buttonPost.trailingAnchor.constraint(equalTo: bottomAddView.trailingAnchor, constant: -4),
                
                
                textFieldContent.bottomAnchor.constraint(equalTo: buttonPost.topAnchor, constant: -8),
                textFieldContent.leadingAnchor.constraint(equalTo: buttonPost.leadingAnchor, constant: 4),
                textFieldContent.trailingAnchor.constraint(equalTo: buttonPost.trailingAnchor, constant: -4),
                
                textFieldTitle.bottomAnchor.constraint(equalTo: textFieldContent.topAnchor, constant: -8),
                textFieldTitle.leadingAnchor.constraint(equalTo: buttonPost.leadingAnchor, constant: 4),
                textFieldTitle.trailingAnchor.constraint(equalTo: buttonPost.trailingAnchor, constant: -4),
                
                bottomAddView.topAnchor.constraint(equalTo: textFieldTitle.topAnchor, constant: -8),
                

            ])
        }
    
    
    
    


}
