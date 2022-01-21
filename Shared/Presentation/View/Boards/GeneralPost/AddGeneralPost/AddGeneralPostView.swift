//
//  AddGeneralPost.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-11-14.
//

import SwiftUI

struct AddGeneralPostView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var addPostVM: AddGeneralPostViewModel = AddGeneralPostViewModel(board: "Waterloo Warriors")
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        Generalize {
            VStack(spacing: 0) {
                // MARK: HEADER
                Header_TitleDismiss(boardTitle: "", dismissName: "Cancel")
                    .padding([.leading, .trailing])
                
                // MARK: BODY
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center) {
                        DynamicTextField(placeholderText: self.addPostVM.titlePlaceholder, text: self.$addPostVM.title)
                                                
                        ZStack(alignment: .topLeading) {
                            if self.addPostVM.textBody.isEmpty {
                                Text("Post anything you want to share")
                                    .foregroundColor(Color(UIColor.placeholderText))
                                    .padding(4)
                            }
                            
                            TextEditor(text: self.$addPostVM.textBody)
                                .foregroundColor(self.addPostVM.textEditorColorTextColor())
                                .onTapGesture {
                                    self.addPostVM.textEditorOnTapGesture()
                                }
                            
                            Text(self.addPostVM.textBody).opacity(0)
                        }
                        
                        if self.addPostVM.showImage() {
                            Image(uiImage: self.addPostVM.selectedImage!)
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(12)
                                .padding()
                        }
                        
                        if self.addPostVM.showPoll() {
                            HStack(alignment: .firstTextBaseline) {
                                VStack {
                                    ForEach(0..<self.addPostVM.pollOptions.count, id: \.self) { i in
                                        CustomTextField("Option " + String(i + 1), input: self.$addPostVM.pollOptions[i], maximumLength: 25, strokeColor: Color.gray)
                                    }
                                }
                                
                                Button(action: {
                                    self.addPostVM.pollOptions.append("")
                                }) {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: screenWidth * 0.06, height: screenWidth * 0.06)
                                        .foregroundColor(.primary)
                                }
                            }
                            .padding()
                            .background(Color(UIColor.systemBackground))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray))
                            
                        }
                    }
                    .padding()
                }
                
                // MARK: FOOTER
                VStack(alignment: .leading, spacing: 0) {
                    
                    Divider()
                    
                    Text(self.addPostVM.message())
                        .font(.caption)
                        .padding(.horizontal)
                        .padding(.vertical, screenWidth * 0.01)
                    
                    Divider()
                    
                    HStack(alignment: .center) {
                        Button(action: {
                            self.addPostVM.anonymousButtonAction()
                        }) {
                            if self.addPostVM.isAnanymous {
                                Image(systemName: "person.fill.questionmark")
                                    .resizable()
                                    .frame(width: screenWidth * 0.05, height: screenWidth * 0.05)
                                    .scaledToFit()
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "person.fill.checkmark")
                                    .resizable()
                                    .frame(width: screenWidth * 0.05, height: screenWidth * 0.05)
                                    .scaledToFit()
                                    .foregroundColor(.green)
                            }
                        }
                        
                        Button(action: {
                            self.addPostVM.photoButtonAction()
                        }) {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: screenWidth * 0.05, height: screenWidth * 0.05)
                                .scaledToFit()
                                .foregroundColor(.green)
                                .opacity(self.addPostVM.addImage ? 1 : 0.5)
                            
                        }
                        
                        Button(action: {
                            self.addPostVM.pollButtonAction()
                        }) {
                            Image(systemName: "align.horizontal.left.fill")
                                .resizable()
                                .frame(width: screenWidth * 0.05, height: screenWidth * 0.05)
                                .scaledToFit()
                                .foregroundColor(.green)
                                .opacity(self.addPostVM.addPoll ? 1 : 0.5)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.addPostVM.uploadPost()
                        }) {
                            Capsulize(capsuleColor: .green, isTranslucent: !(self.addPostVM.isPostValid())) {
                                Text("Post")
                                    .fontWeight(.regular)
                                    .foregroundColor(.white)
                            }
                        }
                        .disabled(!(self.addPostVM.isPostValid()))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, screenWidth * 0.02)
                }
            }
            .sheet(isPresented: self.$addPostVM.showImagePicker) {
                ImagePicker(selectedImage: self.$addPostVM.selectedImage)
            }
        }
    }
}

struct AddGeneralPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddGeneralPostView()
    }
}
