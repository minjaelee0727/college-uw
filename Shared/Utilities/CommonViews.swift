//
//  CommonViews.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-03.
//

import SwiftUI

struct CommonViews: View {
    @State var test: String = ""
    
    var body: some View {
        VStack {
            Rectanglize(rectangleColor: Color.green, isTranslucent: false) {
                Text("Next")
                    .foregroundColor(.white)
            }
            
            Capsulize(capsuleColor: Color.green, isTranslucent: false) {
                Text("Next")
                    .bold()
                    .foregroundColor(.white)
            }
            
            CustomTextField("Your School email", input: $test, forcedPlaceHolder: "@uwaterloo.ca", lowercaseOnly: true)
        }
    }
}

struct Capsulize<Content: View>: View {
    let capsuleColor: Color
    let capsulePaddingSize: CGFloat = 10
    let content: () -> Content
    var isTranslucent: Bool = false

    
    init(capsuleColor: Color, isTranslucent: Bool = true, content: @escaping () -> Content) {
        self.capsuleColor = capsuleColor
        self.content = content
        self.isTranslucent = isTranslucent
    }
    
    var body: some View {
        content()
            .lineLimit(1)
            .padding([.leading, .trailing], capsulePaddingSize/0.5)
            .padding([.top, .bottom], capsulePaddingSize/1.2)
            .background(
                Capsule()
                    .foregroundColor(capsuleColor)
                    .opacity(isTranslucent ? 0.1 : 1)

            )
    }
}

struct Rectanglize<Content: View>: View {
    let rectangleColor: Color
    let rectanglePaddingSize: CGFloat = 10
    let cornerRadius: CGFloat = 10
    let content: () -> Content
    var isTranslucent: Bool = false
    
    init(rectangleColor: Color,isTranslucent: Bool = true, content: @escaping () -> Content) {
        self.rectangleColor = rectangleColor
        self.content = content
        self.isTranslucent = isTranslucent
    }

    var body: some View {
        content()
            .lineLimit(1)
            .padding(rectanglePaddingSize)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(rectangleColor)
                    .opacity(isTranslucent ? 0.1 : 1)
            )
    }
}

struct DropdownTextField: View {
    let title: String
    let prompt: String
    @Binding var searchInput: String
    private var maximumLength: Int
    private var keyboardType: UIKeyboardType
    private var uppercaseOnly: Bool
    let dropDownList: [String]
    let removeButtonSize: CGFloat = 18
    let fieldHeight: CGFloat = 45
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 0.8
    
    init(title:String, prompt: String, searchInput: Binding<String>, dropDownList: [String], maximumLength: Int = 999, keyboardType: UIKeyboardType = .default, uppercaseOnly: Bool = false) {
        self.title = title
        self.prompt = prompt
        self.dropDownList = dropDownList
        self._searchInput = searchInput
        self.maximumLength = maximumLength
        self.keyboardType = keyboardType
        self.uppercaseOnly = uppercaseOnly
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
            
            ZStack(alignment: .leading){
                let binding = Binding<String>(get: {
                    self.searchInput
                }, set: {
                    self.searchInput = $0
                    if (searchInput.count > maximumLength) {
                        searchInput = String(searchInput.dropLast())
                    }
                })

                if searchInput.isEmpty {
                    Text(prompt)
                        .foregroundColor(.gray)
                }

                TextField("", text: binding)
                    .keyboardType(keyboardType)
                    .disableAutocorrection(true)
                    .autocapitalization(uppercaseOnly ? .allCharacters : .words)
            }
            .padding()
            .frame(height: fieldHeight)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.gray, lineWidth: lineWidth)
            )
            
            if searchInput != "" && !dropDownList.contains(searchInput) {
                ScrollView {
                    ForEach(dropDownList.filter{$0.capitalized.contains(searchInput.capitalized) || searchInput == ""}, id: \.self) {
                        suggestion in
                        
                        VStack(alignment: .leading) {
                            Button(action: {
                                searchInput = suggestion
                            }) {
                                Text(suggestion)
                                    .foregroundColor(.primary)
                            }
                            .padding(3)
                            
                            Divider()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct CustomTextField: View {
    private var prompt: String
    @Binding var input: String
    let fieldHeight: CGFloat = 45
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 0.8
    private var forcedPlaceHolder: String
    private var maximumLength: Int
    private var keyboardType: UIKeyboardType
    private var uppercaseOnly: Bool
    private var lowercaseOnly: Bool
    
    init(_ prompt: String, input: Binding<String>, forcedPlaceHolder: String = "", maximumLength: Int = 999, keyboardType: UIKeyboardType = .default, uppercaseOnly: Bool = false, lowercaseOnly: Bool = false) {
        self.prompt = prompt
        self._input = input
        self.forcedPlaceHolder = forcedPlaceHolder
        self.maximumLength = maximumLength
        self.keyboardType = keyboardType
        self.uppercaseOnly = uppercaseOnly
        self.lowercaseOnly = lowercaseOnly
    }

    var body: some View {
        ZStack(alignment: .leading){
            let binding = Binding<String>(get: {
                self.input
            }, set: {
                self.input = $0
                if (input.count > maximumLength) {
                    input = String(input.dropLast())
                }
                if (lowercaseOnly) {
                    input = input.lowercased()
                }
            })

            if (input.isEmpty) {
                Text(prompt)
                    .foregroundColor(.secondary)
            }

            HStack {
                TextField("", text: binding)
                    .keyboardType(keyboardType)
                    .disableAutocorrection(true)
                    .autocapitalization(uppercaseOnly ? .allCharacters : .words)
                
                if (!forcedPlaceHolder.isEmpty) {
                    Text(forcedPlaceHolder)
                        .foregroundColor(.primary)
                }
            }
            
        }
        .padding()
        .frame(height: fieldHeight)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.gray, lineWidth: lineWidth)
        )
    }
}

struct CommonViews_Previews: PreviewProvider {
    static var previews: some View {
        CommonViews()
    }
}
