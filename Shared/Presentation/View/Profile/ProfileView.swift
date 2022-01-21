//
//  UserView.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021/07/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: SessionService
    var body: some View {
        NavigationView {
            Generalize {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: screenWidth * 0.25, height: screenWidth * 0.25)
                            .padding(.trailing)
                        
                        HStack {
                            Text("Set Your Profile!")
                                .bold()
                            
                            Text("")
                                .bold()
                        }
                    }
                    .padding()
                    
                    Divider()
                    
                    NavigationLink(destination:
                        Text("")
                    ) {
                        Rectanglize(rectangleColor: Color.green, isTranslucent: true) {
                            Text("Edit Profile")
                                .foregroundColor(.green)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    NavigationLink(destination:
                        Button(action: {
                        self.session.logout()
                        }) {
                            Text("Log Out")
                        })
                    {
                        Rectanglize(rectangleColor: Color.green, isTranslucent: true) {
                            Text("Settings")
                                .foregroundColor(.green)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    Divider()
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(containedViewType: .profile)
        //        EditProfileView()
    }
}
