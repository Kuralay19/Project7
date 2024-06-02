//
//  Posts.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 17.02.2024.
//

import Foundation
import UIKit
struct User {
    
    let uid: String
    let username: String
    let profileImageUrl: String
    
    init(uid: String,dictionary: [String:Any]?) {
        self.uid = uid
        self.username = dictionary?["username"] as? String ?? ""
        self.profileImageUrl = dictionary?["profileImageUrl"]  as? String ?? ""
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uid == rhs.uid
    }
}
struct Post {
    
    var id: String?
     
    let user: User?
    let imageUrl: String
    let caption: String
    let creationDate: Date
    
    var hasLiked = false
    var likedUsers = [String]()
    
    init(user: User,dictionary: [String: Any]) {
        self.user = user
        self.id = dictionary["id"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
        self.likedUsers = dictionary["likedUsers"] as? [String] ?? [String]()
    }
}

extension Post: Hashable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.user == rhs.user && lhs.caption == rhs.caption && lhs.imageUrl == rhs.imageUrl && lhs.creationDate == rhs.creationDate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
struct LikedPost {
    let postOwner: String
    let like: Bool
    let likeUser: String
    func creaateDictionary() -> [AnyHashable: Any] {
        return ["postOwner": postOwner,
                "like": like,
                "likedUser": likeUser]
    }
}
