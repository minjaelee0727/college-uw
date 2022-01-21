//
//  HomeView.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021/07/25.
//

import SwiftUI

//MARK: View
struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HomeHeader()
            
            Divider()

            
            ScrollView {
                
            }
            
        }
    }
}

//MARK: Header
struct HomeHeader: View {
    @EnvironmentObject var session: SessionService
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hello,")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Text(session.userProfile?.firstName ?? "")
                    .font(.title)
                    .foregroundColor(.primary)

            }
            
            Spacer()
            
            Image(systemName: "person.circle.fill")
                .font(.system(size: 26))
        }
        .frame(height: screenHeight * 0.1)
        .padding([.leading, .trailing])
    }
}
//
//struct NextClassView: View {
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Next Class")
//                .font(.title3)
//                .foregroundColor(.primary)
//
//            Divider()
//
//            VStack(alignment: .leading){
//                HStack {
//                    Image(systemName: "circle")
//                    Text("CS246 Assignment")
//                }
//
//                HStack {
//                    Image(systemName: "checkmark.circle")
//                    Text("MATH136 WA")
//                }
//                HStack {
//                    Image(systemName: "checkmark.circle")
//                    Text("Resume")
//                }
//            }
//
//            Spacer()
//        }
//        .padding()
//        .frame(width: screenWidth * 0.5, height: screenHeight * 0.2)
//        .background(Color.white)
//        .cornerRadius(30)
//    }
//}
//
//struct TodoView: View {
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("TODO List")
//                .font(.title3)
//                .foregroundColor(.primary)
//
//            Divider()
//
//            VStack(alignment: .leading){
//                HStack {
//                    Image(systemName: "circle")
//                    Text("CS246 Assignment")
//                }
//
//                Spacer()
//
//                HStack {
//                    Image(systemName: "checkmark.circle")
//                    Text("MATH136 WA")
//                }
//                HStack {
//                    Image(systemName: "checkmark.circle")
//                    Text("Resume")
//                }
//            }
//
//            Spacer()
//        }
//        .padding()
//        .frame(width: screenWidth * 0.5, height: screenHeight * 0.2)
//        .background(Color.white)
//        .cornerRadius(30)
//    }
//}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(containedViewType: .home)
            .environmentObject(SessionService())
    }
}
