//
//  SignupView.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-03.
//

import SwiftUI

// MARK: USER TYPE
struct Signup_UserType: View {
    @StateObject var signupVM: SignupViewModel = SignupViewModel()
    @State var showBusinessPopover: Bool = false
    @State var showDriverPopover: Bool = false
    @State var showHSPopover: Bool = false
    
    var body: some View {
        Generalize {
            VStack(alignment: .leading) {
                Header_TitleDismiss(dismissName: "Cancel")
                    .padding(.bottom)
                
                TitleHeader(mainTitle: "What describes you best?", subTitle: "Choose your job.")
                    .padding(.bottom)
                
                NavigationLink(destination: Signup_StudentSchool()
                                .environmentObject(signupVM)) {
                    Capsulize(capsuleColor: .green, isTranslucent: false) {
                        Text("University Students")
                            .foregroundColor(.white)
                    }
                }
                
                NavigationLink(destination: Text("")) {
                    Capsulize(capsuleColor: .green, isTranslucent: true) {
                        Text("Staff / Faculty / Alumni")
                            .foregroundColor(.white)
                    }
                }
                .disabled(true)
                
                HStack {
                    NavigationLink(destination: Text("")) {
                        Capsulize(capsuleColor: .green, isTranslucent: true) {
                            Text("Business (Owner/HR/Marketing)")
                                .foregroundColor(.white)
                        }
                    }
                    .disabled(true)
                    
                    Spacer()
                    
                    Popover(showPopover: $showBusinessPopover, prompt: "You can advertise your product or hire university students") {
                        Button(action: {
                            self.showBusinessPopover.toggle()
                        }) {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.secondary)
                                .opacity(0.1)
                        }
                    }
                }
                
                HStack {
                    NavigationLink(destination: Text("")) {
                        Capsulize(capsuleColor: .green, isTranslucent: true) {
                            Text("Local Drivers")
                                .foregroundColor(.white)
                        }
                    }
                    .disabled(true)
                    
                    Spacer()
                    
                    Popover(showPopover: $showDriverPopover, prompt: "You can earn money by driving local university students") {
                        Button(action: {
                            self.showDriverPopover.toggle()
                        }) {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.secondary)
                                .opacity(0.1)
                        }
                    }
                }
                
                HStack {
                    NavigationLink(destination: Text("")) {
                        Capsulize(capsuleColor: .green, isTranslucent: true) {
                            Text("Highschool Students")
                                .foregroundColor(.white)
                        }
                    }
                    .disabled(true)
                    
                    Spacer()
                    
                    Popover(showPopover: $showHSPopover, prompt: "You can ask or find information about admission") {
                        Button(action: {
                            self.showHSPopover.toggle()
                        }) {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.secondary)
                                .opacity(0.1)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: Student School
struct Signup_StudentSchool: View {
    @EnvironmentObject var signupVM: SignupViewModel
    @State var schoolName: String = ""
    
    var body: some View {
        Generalize {
            VStack(alignment: .leading, spacing: 0) {
                
                Header_TitleDismiss(dismissName: "Back")
                    .padding(.bottom)
                
                TitleHeader(mainTitle: "What school do you go to?", subTitle: "Only University of Waterloo students can register now.")
                    .padding(.bottom)
                
                ZStack(alignment: .bottomTrailing) {
                    VStack {
                        DropdownTextField(title: "", prompt: "Your School", searchInput: $schoolName, dropDownList: CanadianUniversityList)
                        
                        Spacer()
                    }
                    
                    HStack {
                        
                        NavigationLink(destination:
                                        SignupStudentInformation()
                                        .environmentObject(signupVM)
                        ) {
                            Capsulize(capsuleColor: .green, isTranslucent: schoolName != "University of Waterloo") {
                                Text("Next")
                                    .foregroundColor(.white)
                            }
                        }
                        .disabled(schoolName != "University of Waterloo")
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}

struct SignupStudentInformation: View {
    @EnvironmentObject var signupVM: SignupViewModel
    @State var done: Bool = false
    
    var body: some View {
        Generalize {
            VStack(alignment: .leading) {
                Header_TitleDismiss(dismissName: "Back")
                    .padding(.bottom)
                
                TitleHeader(mainTitle: signupVM.infoTitle(), subTitle: "")
                    .padding(.bottom)
                
                VStack(alignment: .leading, spacing: screenWidth * 0.05) {
                    if ((signupVM.details.facultyIndex != nil) && (signupVM.details.academicStatusIndex != nil)) {
                        VStack(alignment: .leading, spacing: 3) {
                            if (!signupVM.details.program.isEmpty) {
                                Text("Program")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            TextField("Program", text: $signupVM.details.program)
                            
                            Rectangle()
                                .foregroundColor(signupVM.details.program.isEmpty ? .green : .secondary)
                                .frame(height: 2)
                        }
                    }
                    
                    if (signupVM.details.academicStatusIndex != nil) {
                        VStack(alignment: .leading, spacing: 3) {
                            if (signupVM.details.academicStatusIndex != nil) {
                                Text("Faculty")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            PickerField("Faculty", data: UWaterlooFaculty, selectionIndex: $signupVM.details.facultyIndex)
                                .frame(height: screenHeight * 0.03)
                            
                            Rectangle()
                                .foregroundColor((signupVM.details.facultyIndex == nil) ? .green : .secondary)
                                .frame(height: 2)
                        }
                    }
                    
                    if (!signupVM.details.firstName.isEmpty && !signupVM.details.lastName.isEmpty) {
                        VStack(alignment: .leading, spacing: 3) {
                            if (signupVM.details.academicStatusIndex != nil) {
                                Text("Academic Status")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            PickerField("Academic Status", data: ConstantOption.AcademicStatusOption, selectionIndex: $signupVM.details.academicStatusIndex)
                                .frame(height: screenHeight * 0.03)
                            
                            Rectangle()
                                .foregroundColor(signupVM.details.academicStatusIndex == nil ? .green : .secondary)
                                .frame(height: 2)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 3) {
                        if (!signupVM.details.firstName.isEmpty && !signupVM.details.lastName.isEmpty) {
                            Text("Name")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            VStack {
                                TextField("First Name", text: $signupVM.details.firstName)
                                
                                Rectangle()
                                    .foregroundColor(signupVM.details.firstName.isEmpty ? .green : .secondary)
                                    .frame(height: 2)
                            }
                            
                            Spacer()
                            
                            VStack {
                                TextField("Last Name", text: $signupVM.details.lastName)
                                
                                Rectangle()
                                    .foregroundColor(signupVM.details.lastName.isEmpty ? .green : .secondary)
                                    .frame(height: 2)
                            }
                        }
                    }
                    
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: SignupStudentCredential()
                                    .environmentObject(signupVM)) {
                        Capsulize(capsuleColor: .green, isTranslucent: signupVM.checkMissingInfo()) {
                            Text("Next")
                                .foregroundColor(.white)
                        }
                    }
                                    .disabled(signupVM.checkMissingInfo())
                }
            }
            .padding()
        }
    }
}

// MARK: Student Credentials
struct SignupStudentCredential: View {
    @EnvironmentObject var signupVM: SignupViewModel
    
    var body: some View {
        Generalize {
            VStack(alignment: .leading, spacing: 0) {
                Header_TitleDismiss(dismissName: "Back")
                    .padding(.bottom)
                
                TitleHeader(mainTitle: "What is your school email?", subTitle: self.signupVM.error ? self.signupVM.errMsg : "Let us verify you are Waterloo Warriors.")
                    .padding(.bottom)
                
                CustomTextField("Email w/o domain", input: $signupVM.details.email, forcedPlaceHolder: "@uwaterloo.ca", lowercaseOnly: true, strokeColor: self.signupVM.error ? Color.red : Color.gray)
                    .padding(.bottom)
                
                if (!signupVM.details.email.isEmpty) {
                    VStack(alignment: .leading) {
                        if (!self.signupVM.error) {
                            Text("Now it's time to set up your password")
                                .foregroundColor(.secondary)
                                .fontWeight(.regular)
                                .font(.subheadline)
                                .scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                        
                        PasswordTextField_Secure("Password", password: $signupVM.details.password, strokeColor: self.signupVM.error ? Color.red : Color.gray)
                        
                        ReenterPasswordTextField("Re-enter Password", password: signupVM.details.password, passwordInput: $signupVM.details.rePassword, warning: self.signupVM.error)
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: LoginView()) {
                        Button(action: {
                            signupVM.signup()
                        }) {
                            Capsulize(capsuleColor: .green, isTranslucent: !signupVM.checkCredential()) {
                                Text("Next")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .disabled(!signupVM.checkCredential())
                }
                .padding()
            }
            .padding()
        }
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


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        FUView()
    }
}
