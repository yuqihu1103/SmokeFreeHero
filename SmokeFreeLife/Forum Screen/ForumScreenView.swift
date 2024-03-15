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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLabelTitle()
        setupPostTableView()
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
    
    func initConstraints(){
            NSLayoutConstraint.activate([
                
                labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
                labelTitle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

                postTableView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
                postTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -35),
                postTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                postTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8)
                

            ])
        }
    
    
    
    


}
