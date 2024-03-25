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
        let activeForum = db.collection("ThreadDetails")
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
        
        forumScreen.buttonPost.addTarget(self, action: #selector(onButtonPostTapped), for: .touchUpInside)
        
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    
    @objc func onButtonPostTapped(){
        if let title = forumScreen.textFieldTitle.text, !title.isEmpty,
           let content = forumScreen.textFieldContent.text, !content.isEmpty,
           let postStarter = self.currentUserName, !postStarter.isEmpty
        {
            let datetime = Date()
            let df = DateFormatter()
            df.dateFormat = "y/MM/dd H:mm a"
            df.amSymbol = "AM"
            df.pmSymbol = "PM"
            let time = df.string(from: datetime)
            postNewPost(post: Post(title: title, content: content, ThreadStarter: postStarter, Timestamp: time))

        }else{
            showEmptyAlert()
        }
    }
    
    
    func showEmptyAlert(){
        let alert = UIAlertController(title: "Error!", message: "Text Fields must not be empty.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
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
        threadDetailViewController.title = postSelected.title
        navigationController?.pushViewController(threadDetailViewController, animated: true)
    }
    
    func postNewPost(post:Post){
        let col1 = db.collection("ThreadDetails")
        do{
            try col1.addDocument(from: post, completion: {(error) in
                if error == nil{
                    self.forumScreen.textFieldTitle.text = ""
                    self.forumScreen.textFieldContent.text = ""
                }
            })
        }catch{
            print("Error posting! Please try later.")
        }
    }
    


}
