//
//  ThreadDetailViewController.swift
//  SmokeFreeLife
//
//  Created by Zoey H on 12/5/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ThreadDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let threadScreen = ThreadDetailView()
    let db = Firestore.firestore()
    var currentUserName: String?
    var threads = [Thread]()
    var currentPost: String?
    var rootPost: Post?
    var rootPostId: String?
    
    override func loadView() {
        view = threadScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let threadID = rootPostId {
            let currentPost = db.collection("ThreadDetails").document(threadID)
            
            currentPost.addSnapshotListener(includeMetadataChanges: false) { [weak self] querySnapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching threads: \(error.localizedDescription)")
                    return
                }
                
                guard let document = querySnapshot else {
                    print("No threads found")
                    return
                }
                
               
                let title = document.data()?["title"] as? String ?? ""
                let threadStarter = document.data()?["ThreadStarter"] as? String ?? ""
                let timestamp = document.data()?["Timestamp"] as? String ?? ""
                let content = document.data()?["content"] as? String ?? ""
                print(title)
                    
                let post = Post(title: title, content: content, ThreadStarter: threadStarter, Timestamp: timestamp)
                
                self.rootPost = post
                threadScreen.labelContent.text = rootPost?.content
                threadScreen.Timestamp.text = rootPost?.Timestamp
                threadScreen.ThreadStarterName.text = rootPost?.ThreadStarter
                
            }
            
        }
        
        
        if let threadID = rootPostId {
            let threadsRef = db.collection("ThreadDetails").document(threadID).collection("posts")
            
            threadsRef.addSnapshotListener(includeMetadataChanges: false) { [weak self] querySnapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching threads: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No threads found")
                    return
                }
                
                // Parse new threads
                var newThreads = [Thread]()
                for document in documents {
                    let content = document.data()["content"] as? String ?? ""
                    let poster = document.data()["poster"] as? String ?? ""
                    let timestamp = document.data()["Timestamp"] as? String ?? ""
                    
                    let thread = Thread(content: content, poster: poster, Timestamp: timestamp)
                    newThreads.append(thread)
                }
                
                
                newThreads.sort { thread1, thread2 in
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
                
                
                
                // Assign the sorted threads back to the 'threads' array
                self.threads = newThreads
                
                // Reload the table view to reflect changes
                self.threadScreen.threadTableView.reloadData()
                
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                        
        threadScreen.threadTableView.dataSource = self
        threadScreen.threadTableView.delegate = self
        threadScreen.threadTableView.separatorStyle = .none
        // These three must cannot be put behind the function below
        threadScreen.threadTableView.reloadData()
        threadScreen.buttonPost.addTarget(self, action: #selector(onButtonPostTapped), for: .touchUpInside)
    }
    
    
    @objc func onButtonPostTapped(){
    
        if let text = threadScreen.textField.text, let poster = currentUserName{
            if !text.isEmpty{
                let datetime = Date()
                //format it to a readable string...
                let df = DateFormatter()
                df.dateFormat = "y/MM/dd H:mm a"
                df.amSymbol = "AM"
                df.pmSymbol = "PM"
                let time = df.string(from: datetime)
                savePost(thread: Thread(content: text,poster:poster,Timestamp:time))
            }else{
                showErrrorAlert()
            }
        }
        
    }
    
    func showErrrorAlert(){
        let alert = UIAlertController(title: "Error!", message: "Textfield is empty.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return threads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "threads", for: indexPath) as! ThreadsTableViewCell
        
        cell.labelPoster.text = threads[indexPath.row].poster
        cell.labelContent.text = threads[indexPath.row].content
        cell.labelDt.text = threads[indexPath.row].Timestamp
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}
