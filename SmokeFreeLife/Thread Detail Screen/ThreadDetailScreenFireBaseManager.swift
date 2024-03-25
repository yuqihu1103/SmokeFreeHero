//
//  ThreadDetailScreenFireBaseManager.swift
//  SmokeFreeLife
//
//  Created by Zoey H on 12/5/23.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

extension ThreadDetailViewController{

    func savePost(thread:Thread){
        if let post = self.rootPostId{
            let collectionMe = db
                .collection("ThreadDetails")
                .document(post)
                .collection("posts")
            do{
                try collectionMe.addDocument(from: thread, completion: {(error) in
                    if error == nil{
                        self.threadScreen.textField.text = ""
                    }
                })
            }catch{
                print("Error adding thread!")
            }
        }
    }

}
