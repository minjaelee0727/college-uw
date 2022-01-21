//
//  DynamicTextField.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-11-14.
//

import UIKit
import SwiftUI

struct DynamicTextField: View {
    let placeholderText: String
    @Binding var text: String
    @State var textHeight: CGFloat = 30
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholderText)
                    .font(.title)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(4)
            }
            
            DynamicHeightTextFieldReprsentable(text: $text, height: $textHeight)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .frame(height: textHeight)
    }
    
    private struct DynamicHeightTextFieldReprsentable: UIViewRepresentable {
        @Binding var text: String
        @Binding var height: CGFloat
        
        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
            
            textView.isEditable = true
            textView.isUserInteractionEnabled = true
            
            textView.isScrollEnabled = true
            textView.alwaysBounceVertical = false
            
            textView.text = text
            textView.textColor = UIColor(Color.primary)
            textView.textAlignment = .left
            textView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
            textView.backgroundColor = UIColor.clear
            
            context.coordinator.textView = textView
            textView.delegate = context.coordinator
            textView.layoutManager.delegate = context.coordinator
            
            return textView
        }
        
        func updateUIView(_ uiView: UITextView, context: Context) {
            uiView.text = text
        }
        
        func makeCoordinator() -> Coordinator {
            return Coordinator(dynamicHeightTextField: self)
        }
        
        
        class Coordinator: NSObject, UITextViewDelegate, NSLayoutManagerDelegate {
            
            
            var dynamicHeightTextField: DynamicHeightTextFieldReprsentable
            
            
            init(dynamicHeightTextField: DynamicHeightTextFieldReprsentable) {
                self.dynamicHeightTextField = dynamicHeightTextField
            }
            
            func textViewDidChange(_ textView: UITextView) {
                self.dynamicHeightTextField.text = textView.text
            }
            
            func textView(
                _ textView: UITextView,
                shouldChangeTextIn range: NSRange,
                replacementText text: String) -> Bool {
                    if (text == "\n") {
                        textView.resignFirstResponder()
                        return false
                    }
                    return true
                }
            
            weak var textView: UITextView?
            
            func layoutManager(
                _ layoutManager: NSLayoutManager,
                didCompleteLayoutFor textContainer: NSTextContainer?,
                atEnd layoutFinishedFlag: Bool) {
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let view = self?.textView else {
                            return
                        }
                        let size = view.sizeThatFits(view.bounds.size)
                        if self?.dynamicHeightTextField.height != size.height {
                            self?.dynamicHeightTextField.height = size.height
                        }
                    }
                }
        }
    }

}
