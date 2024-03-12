//
//  Thread.swift
//  SmokeFreeLife
//
//  Created by Zoey H on 12/5/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Thread: Codable, Equatable{
    @DocumentID var id: String?
    var content: String
    var poster: String
    var Timestamp: String
    
    init(content: String, poster: String, Timestamp: String) {
        self.content = content
        self.poster = poster
        self.Timestamp = Timestamp
    }
}
