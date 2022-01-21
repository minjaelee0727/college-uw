//
//  LogInView.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-03.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        Generalize {
            VStack(alignment: .leading) {
                Header_TitleDismiss(dismissName: "Cancel")
                    .padding(.bottom)
                
                TitleHeader(mainTitle: "Let's get started", subTitle: self.loginVM.errMsg)
                    .padding(.bottom)
                
                CustomTextField("Email", input: $loginVM.credentials.email, keyboardType: .emailAddress, lowercaseOnly: true, strokeColor: (self.loginVM.state == LoginState.failed  ? Color.red : Color.gray))
                
                PasswordTextField_Secure("Password", password: $loginVM.credentials.password, strokeColor: (self.loginVM.state == LoginState.failed ? Color.red : Color.gray))
                
                Spacer()
                
                HStack {
                    Button(action: {}) {
                        Text("Forgot Password?")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.loginVM.login()
                    }) {
                        Capsulize(capsuleColor: .green, isTranslucent: (self.loginVM.credentials.isEmpty())) {
                            Text("Sign In")
                                .foregroundColor(.white)
                        }
                    }
                    .disabled(self.loginVM.credentials.isEmpty())
                }
                .padding()
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        FUView()
    }
}
