//
//  FirestoreRepository.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-11-10.
//

import Foundation
import FirebaseFirestore

final class FirestoreDB {
    enum Path {
        static let users = "users"
        static let universities = "universities"
        static let boards = "boards"
        static let posts = "posts"
    }
    
    static private let store = Firestore.firestore()
    
    static public func userDoc(_ userId: String) -> DocumentReference {
        return store.collection(Path.users).document(userId)
    }
    
    static public func postsCollection(_ boardName: String) -> CollectionReference {
        return store.collection(Path.boards).document(boardName).collection(Path.posts)
    }
}
