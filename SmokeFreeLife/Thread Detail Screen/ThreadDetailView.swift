//
//  ThreadDetailView.swift
//  SmokeFreeLife
//
//  Created by Zoey H on 12/5/23.
//

import UIKit

class ThreadDetailView: UIScrollView {
    
    var labelContent: UILabel!
    var ThreadStarterName:UILabel!
    var Timestamp:UILabel!
    
    var threadTableView: UITableView!
    var textField: UITextField!
    var buttonPost: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLabels()
        setupthreadTableView()
        setupTextField()
        setupbuttonPost()
        initConstraints()
    }
    
    func setupLabels() {
        labelContent = UILabel()
        labelContent.text = ""
        labelContent.font = UIFont.monospacedSystemFont(ofSize: 30, weight: .regular)
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelContent)
        
        ThreadStarterName = UILabel()
        ThreadStarterName.text = ""
        ThreadStarterName.font = UIFont.boldSystemFont(ofSize: 20)
        ThreadStarterName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ThreadStarterName)
        
        Timestamp = UILabel()
        Timestamp.text = ""
        Timestamp.font = UIFont.monospacedSystemFont(ofSize: 15, weight: .light)
        Timestamp.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(Timestamp)
    }
    
    func setupthreadTableView(){
        threadTableView = UITableView()
        threadTableView.register(ThreadsTableViewCell.self, forCellReuseIdentifier: "threads")
        threadTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(threadTableView)
    }
    
    func setupbuttonPost() {
        buttonPost = UIButton(type: .system)
        buttonPost.setTitle("post", for: .normal)
        buttonPost.titleLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .semibold)
        buttonPost.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonPost)
    }
    
    func setupTextField(){
        textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
    }
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            ThreadStarterName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            ThreadStarterName.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            
            Timestamp.topAnchor.constraint(equalTo: ThreadStarterName.bottomAnchor, constant: 5),
            Timestamp.leftAnchor.constraint(equalTo: ThreadStarterName.leftAnchor, constant: 0),
            
            labelContent.topAnchor.constraint(equalTo: Timestamp.bottomAnchor, constant: 5),
            labelContent.leftAnchor.constraint(equalTo: ThreadStarterName.leftAnchor, constant: 0),
            
            threadTableView.topAnchor.constraint(equalTo: labelContent.bottomAnchor, constant: 8),
            threadTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            threadTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            threadTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            textField.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            textField.widthAnchor.constraint(equalTo: threadTableView.widthAnchor, multiplier: 0.8),
            
            buttonPost.heightAnchor.constraint(equalToConstant: 30),
            buttonPost.leftAnchor.constraint(equalTo: textField.rightAnchor, constant: 8),
            buttonPost.topAnchor.constraint(equalTo: textField.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
