//
//  FirebaseStorage.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-11-14.
//

import Foundation
import FirebaseStorage

class FirebaseStorage {
    static private var storage = Storage.storage()
    
    static private var storageRoot = storage.reference()
    
    static var storagePost = storageRoot.child("posts")
    
    static func storagePostId(postId: String) -> StorageReference {
        return storagePost.child(postId)
    }
}
