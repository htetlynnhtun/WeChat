//
//  MomentVO.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct MomentVO: Codable, Identifiable {
    @DocumentID var id: String?
    
    var bookmarks: [UserVO]
    var createdAt: Date
    var description: String
    var likes: [UserVO]
    var mediaFiles: [URL]
    var profilePicture: URL
    var username: String
}
