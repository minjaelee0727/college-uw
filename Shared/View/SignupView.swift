//
//  SignupView.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-03.
//

import SwiftUI

// MARK: View1
struct SignupView1: View {
    @State var schoolName: String = ""

    var body: some View {
        ZStack() {
            Color(backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {

                SignupHeader(text: "Cancel")
                    .padding(.bottom)
                                
                SignupTitle(mainTitle: "What school do you go to?", subTitle: "Only University of Waterloo Students can register now.")
                    .padding(.bottom)
                 
                ZStack(alignment: .bottomTrailing) {
                    VStack {
                        DropdownTextField(title: "", prompt: "Your School", searchInput: $schoolName, dropDownList: CanadianUniversityList)

                        Spacer()
                    }
                    
                    HStack {
                        
                        NextButton1(text: $schoolName)
                    }
                    .padding()
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SignupHeader: View {
    let text: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                
            }) {
                Text(text)
                    .foregroundColor(.primary)
            }
            
            Divider()
        }
    }
}

struct SignupTitle: View {
    let mainTitle: String
    let subTitle: String
    let subTitle2: String
    
    init (mainTitle: String, subTitle : String, subTitle2: String = "") {
        self.mainTitle = mainTitle
        self.subTitle = subTitle
        self.subTitle2 = subTitle2
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(mainTitle)
                .foregroundColor(.primary)
                .fontWeight(.bold)
                .font(.title)
                .scaledToFill()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Text(subTitle)
                .foregroundColor(.secondary)
                .fontWeight(.regular)
                .font(.subheadline)
                .scaledToFill()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            if (!subTitle2.isEmpty) {
                Text(subTitle2)
                    .foregroundColor(.secondary)
                    .fontWeight(.regular)
                    .font(.subheadline)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
        }
    }
}

struct NextButton1: View {
    @Binding var text: String
    
    var body: some View {
        NavigationLink(destination: SignupView2()) {
            Capsulize(capsuleColor: .green, isTranslucent: text != "University of Waterloo") {
                Text("Next")
                    .foregroundColor(.white)
            }
        }
        .disabled(text != "University of Waterloo")
    }
}

// MARK: View2
struct SignupView2: View {
    @State var emailAddress: String = ""
    
    var body: some View {
        ZStack {
            Color(backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                SignupHeader(text: "Back")
                    .padding(.bottom)
                
                SignupTitle(mainTitle: "What is your school email?", subTitle: "Let us verify you are Waterloo Warriors.")
                    .padding(.bottom)
                
                CustomTextField("Email w/o domain", input: $emailAddress, forcedPlaceHolder: "@uwaterloo.ca", lowercaseOnly: true)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NextButton2(text: $emailAddress)
                }
                .padding()
            }
            .padding()

        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SchoolTextField: View {
    private var prompt: String
    @Binding var input: String
    let fieldHeight: CGFloat = 45
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 0.8
    private var maximumLength: Int
    private var keyboardType: UIKeyboardType
    private var uppercaseOnly: Bool

    init(_ prompt: String, input: Binding<String>, maximumLength: Int = 999, keyboardType: UIKeyboardType = .default, uppercaseOnly: Bool = false) {
        self.prompt = prompt
        self._input = input
        self.maximumLength = maximumLength
        self.keyboardType = keyboardType
        self.uppercaseOnly = uppercaseOnly
    }

    var body: some View {
        VStack {
            ZStack(alignment: .leading){
                let binding = Binding<String>(get: {
                    self.input
                }, set: {
                    self.input = $0
                    if (input.count > maximumLength) {
                        input = String(input.dropLast())
                    }
                })

                if input.isEmpty {
                    Text(prompt)
                        .italic()
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
            
            if input != "" && !CanadianUniversityList.contains(input) {
                ScrollView {
                    ForEach(CanadianUniversityList.filter{$0.capitalized.contains(input.capitalized) || input == ""}, id: \.self) {
                        suggestion in
                        
                        VStack(alignment: .leading) {
                            Button(action: {
                                input = suggestion
                            }) {
                                Text(suggestion)
                                    .foregroundColor(.black)
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

struct NextButton2: View {
    @Binding var text: String
    
    var body: some View {
        NavigationLink(destination: SignupView3()) {
            Capsulize(capsuleColor: .green, isTranslucent: text.isEmpty) {
                Text("Next")
                    .foregroundColor(.white)
            }
        }
        .disabled(text.isEmpty)
    }
}

// MARK: View 3
struct SignupView3: View {
    var body: some View {
        ZStack {
            Color(backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                SignupHeader(text: "Back")
                    .padding(.bottom)
                
                SignupTitle(mainTitle: "Please share us your info", subTitle: "")
                    .padding(.bottom)
                
                VStack {
                    Text("Your gende")
                }
                
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        FUView()
    }
}
