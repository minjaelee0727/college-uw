//
//  GeneralPostModel.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-11-13.
//

import Foundation

struct GeneralPostModel: Codable {
    var ownerId: String
    var postId: String
    var date: Double
    
    var board: String
    var title: String
    var body: String
    var mediaUrl: String?
    var polls: [String:Int]?
    
    var views: Int
    var likeCount: Int
    var dislikeCount: Int
    
    var commentsCount: Int
    var reportsCount: Int
    
    var anonymous: Bool
    var removed: Bool
}
