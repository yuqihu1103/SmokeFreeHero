//
//  Post.swift
//  SmokeFreeLife
//
//  Created by Zoey H on 12/5/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Post: Codable, Equatable{
    @DocumentID var id: String?
    var ThreadStarter: String
    var title: String
    var content: String
    var Timestamp: String
    
    init(title: String,content: String, ThreadStarter: String, Timestamp: String) {
        self.ThreadStarter = ThreadStarter
        self.content = content
        self.title = title
        self.Timestamp = Timestamp
    }
}
