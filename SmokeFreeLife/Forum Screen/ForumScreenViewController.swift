//
//  ForumScreenViewController.swift
//  SmokeFreeLife
//
//  Created by XuanShichun on 12/6/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


class ForumScreenViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    let forumScreen = ForumScreenView()
    let db = Firestore.firestore()
    var currentUserName: String?
    var posts = [Post]()
    
    override func loadView() {
        view = forumScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let activeForum = db.collection("Threads")
        activeForum.addSnapshotListener(includeMetadataChanges: false) { [weak self] querySnapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error accessing forum: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No posts found")
                return
            }
            
            var activePosts = [Post]()
            for document in documents{
                let title = document.data()["title"] as? String ?? ""
                let timestamp = document.data()["Timestamp"] as? String ?? ""
                var tempPost = Post(title:title,content: "", ThreadStarter: "", Timestamp: timestamp)
                tempPost.id = document.documentID
                activePosts.append(tempPost)

            }
            
            activePosts.sort { thread1, thread2 in
                // DateFormatter to convert string to Date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "y/MM/dd H:mm a"
                
                // Convert Timestamp strings to Date objects
                guard let date1 = dateFormatter.date(from: thread1.Timestamp),
                      let date2 = dateFormatter.date(from: thread2.Timestamp) else {
                    return false // Handle any case where date conversion fails
                }
                
                // Sort based on the converted Date objects
                return date1 < date2
            }
            self.posts = activePosts
            
            self.forumScreen.postTableView.reloadData()
        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forumScreen.postTableView.dataSource = self
        forumScreen.postTableView.delegate = self
        forumScreen.postTableView.separatorStyle = .none
        forumScreen.postTableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "posts", for: indexPath) as! PostTableViewCell
        cell.labelTitle.text = posts[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postSelected = posts[indexPath.row]
        let threadDetailViewController = ThreadDetailViewController()
        
        threadDetailViewController.currentUserName = self.currentUserName
        threadDetailViewController.rootPostId = postSelected.id
        navigationController?.pushViewController(threadDetailViewController, animated: true)
    }


}
