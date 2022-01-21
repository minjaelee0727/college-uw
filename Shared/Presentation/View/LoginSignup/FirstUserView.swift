//
//  FirstUserView.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-03.
//

import SwiftUI

// MARK: View
struct FUView: View {
    
    var body: some View {
        NavigationView {
            Generalize {
                VStack(alignment: .leading) {
                    FUHeader
                    
                    Spacer()
                    
                    FUBody
                    
                    Spacer()
                    
                    LoginLinkButton()
                    
                    FUDivider()
                    
                    SignupLinkButton()

                    Spacer()
                }
                .padding()
                .padding()
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
    
    var FUHeader: some View {
        HStack {
            Image(systemName: "graduationcap")
                .font(.title3)
        }
    }
    
    var FUBody: some View {
        VStack(alignment: .leading) {
            Text("Get all")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.primary)
            Text("you need in")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.primary)
            Text("your university now.")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.primary)
        }
    }
}

// MARK: Divider
struct FUDivider: View {
    
    var line: some View {
        VStack {
            Divider()
        }
    }
    
    var body: some View {
        HStack {
            
            line
            
            Text("Or")
                .foregroundColor(.secondary)
                .fontWeight(.thin)
                .font(.caption)
            
            line
        }
    }
}

// MARK: LoginLinkButton
struct LoginLinkButton: View {
    var body: some View {
        NavigationLink(destination: LoginView()) {
            Text("Log in")
                .fontWeight(.bold)
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .foregroundColor(.green)
                )
        }
    }
}

// MARK: SignupLinkButton
struct SignupLinkButton: View {
    var body: some View {
        NavigationLink(destination: Signup_UserType()) {
            Text("Create account")
                .bold()
                .fontWeight(.bold)
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .foregroundColor(.green)
                )
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        FUView()
    }
}
