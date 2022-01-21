//
//  AddGeneralPostViewModel.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-11-14.
//

import Foundation
import SwiftUI
import Combine

class AddGeneralPostViewModel: ObservableObject {
    let board: String
    let titlePlaceholder: String = "Title"
    @Published var title: String = ""
    let bodyPlaceholder: String = "Body (Optional)"
    @Published var textBody: String = ""
    @Published var isAnanymous: Bool = true
    @Published var addImage: Bool = false
    @Published var showImagePicker: Bool = false
    @Published var selectedImage: UIImage?
    @Published var addPoll: Bool = false
    @Published var pollOptions: [String] = ["",""]
    @Published var success: Bool = false
    @Published var error: Bool = false
    @Published var errMsg: String = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(board: String) {
        self.board = board
    }
    
    func textEditorColorTextColor() -> Color {
        return self.textBody == self.bodyPlaceholder ? Color(UIColor.placeholderText) : .primary
    }
    
    func textEditorOnTapGesture() {
        if self.textBody == self.bodyPlaceholder {
            self.textBody.removeAll()
        }
    }
    
    func showImage() -> Bool {
        return self.selectedImage != nil
    }
    
    func showPoll() -> Bool {
        return addPoll
    }
    
    func message() -> String {
        if error {
            return errMsg
        } else {
            return (self.isAnanymous ? "No one" : "Everyone") + " knows who you are"
        }
    }
    
    func anonymousButtonAction() {
        self.isAnanymous.toggle()
    }
    
    func photoButtonAction() {
        if self.addImage {
            self.selectedImage = nil
        } else {
            self.showImagePicker.toggle()
        }
        
        self.addImage.toggle()
    }
    
    func pollButtonAction() {
        if !self.addPoll {
            self.pollOptions = ["",""]
        }
        self.addPoll.toggle()
    }
    
    func isPostValid() -> Bool {
        if addPoll {
            return self.pollOptions.count == NSCountedSet.init(array: pollOptions).count
        }
        return !self.title.isEmpty
    }
    
    func uploadPost() {
        let post = AddGeneralPostModel.init(date: Date().timeIntervalSince1970, board: board, title: title, body: textBody, isAnonymous: isAnanymous, imageData: addImage ? selectedImage?.jpegData(compressionQuality: 0.8) : nil, poll: addPoll ? Dictionary(uniqueKeysWithValues: pollOptions.map{ ($0, 0) }) : nil)
        
        PostService.uploadGeneralPost(post: post)
            .receive(on: RunLoop.main)
            .sink {
                res in
                switch res {
                case .failure(let err):
                    print(err)
                case .finished:
                    break
                }
            } receiveValue: { _ in
                self.success = true
            }
            .store(in: &subscriptions)
            
    }
}
