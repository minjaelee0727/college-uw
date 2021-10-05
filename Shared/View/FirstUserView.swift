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
            ZStack() {
                Color(backgroundColor)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    FUHeader()
                    
                    Spacer()
                    
                    FUBody()
                    
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarHidden(true)
        }
    }
}

// MARK: Header
struct FUHeader: View {
    
    var body: some View {
        HStack {
            Image(systemName: "graduationcap")
                .font(.title3)
        }
    }
}

// MARK: Body
struct FUBody: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("See what's")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.black)
            Text("happening in")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.black)
            Text("your university now.")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.black)
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
        NavigationLink(destination: SignupView1()) {
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
