//
//  PostService.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-11-16.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Combine
import SwiftUI

final class PostService: ObservableObject {
    private static func getPostDoc(board: String, postId: String) -> DocumentReference {
        return FirestoreDB.postsCollection(board).document(postId)
    }
    
    private static func createPostDocumentId(board: String) -> String {
        return FirestoreDB.postsCollection(board).document().documentID
    }
    
    private static func getStorageRef(postId: String) -> StorageReference {
        return FirebaseStorage.storagePostId(postId: postId)
    }
    
    private static func savePostPhoto(storageRef: StorageReference, imageData: Data) -> AnyPublisher<Void, NetworkError> {
        return Future<Void, NetworkError> {
            promise in
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            storageRef.putData(imageData, metadata: metaData) {
                (StorageMetadata, error) in
                
                if let error = error {
                    return promise(.failure(NetworkError.error(description: error.localizedDescription)))
                }
                
                return promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private static func getURL(storageRef: StorageReference) -> AnyPublisher<String, NetworkError> {
        return Future<String, NetworkError> {
            promise in
            storageRef.downloadURL {
                url, error in
                
                if let error = error {
                    return promise(.failure(NetworkError.error(description: error.localizedDescription)))
                }
                
                if let url = url?.absoluteString {
                    return promise(.success(url))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

extension PostService {
    public static func uploadGeneralPost(post: AddGeneralPostModel) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> {
            promise in
            
            guard let userId = AuthService.currentUser()?.uid else {
                return
            }
            
            let postId = createPostDocumentId(board: post.board)
            var mediaUrl: String?
            
            if let imageData = post.imageData {
//                let storageRef = getStorageRef(postId: postId)
//                
//                savePostPhoto(storageRef: storageRef, imageData: imageData) {
//                    result in
//                    
//                    switch result {
//                    case .success(()):
//                        getURL(storageRef: storageRef) {
//                            result in
//                            switch result {
//                            case .success(let url):
//                                mediaUrl = url
//                            case .failure(let err):
//                                print(err.localizedDescription)
//                            }
//                        }
//                    case .failure(let err):
//                        print(err.localizedDescription)
//                    }
//                }
            }
            
            let postRef = getPostDoc(board: post.board, postId: postId)
            
            let post = GeneralPostModel.init(ownerId: userId, postId: postId, date: post.date, board: post.board, title: post.title, body: post.body, mediaUrl: mediaUrl, polls: post.poll,views: 0, likeCount: 0, dislikeCount: 0, commentsCount: 0, reportsCount: 0, anonymous: post.isAnonymous, removed: false)
            
            guard let dict = try? post.asDictionary() else {
                print("Cannot convert to dict")
                return
            }
            
            postRef.setData(dict) {
                (error) in
                
                if let err = error {
                   return promise(.failure(err))
                }
                
                return promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
}
