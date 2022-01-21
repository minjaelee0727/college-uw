//
//  BoardMainView.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021/07/25.
//

import SwiftUI

struct BoardMainView: View {
    var body: some View {
        NavigationView {
            Generalize {
                VStack {
                    HStack {
                        Text("Boards")
                            .fontWeight(.bold)
                            .font(.title)
                        
                        Spacer()
                    }
                    .padding()
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            NavigationLink(destination: WaterlooWarriorsBoard()) {
                                BoardButton(icon: "🟡", boardTitle: "Waterloo Warriors")
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: BuyUsed()) {
                                BoardButton(icon: "🛒", boardTitle: "Sell/Buy Used")
                            }
                            
                            NavigationLink(destination: RideShareBoard()) {
                                BoardButton(icon: "🚗", boardTitle: "Rideshare")
                            }
                        }
                        .padding()
                    }
                    .onAppear(perform: {
                       UIScrollView.appearance().bounces = false
                     })
                }
            }
        }
    }
}

struct BoardButton: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    let icon: String
    let boardTitle: String
    let color: Color = Color.yellow
    
    var body: some View {
        HStack() {
            Text(icon)
                .foregroundColor(.black)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.white))
                .padding(.horizontal)
            
            Text(boardTitle)
                .foregroundColor(.black)
                .font(.title3)
                .fontWeight(.regular)
                .lineLimit(2)
                .minimumScaleFactor(0.01)
            
            Spacer()
        }
        .frame(width: screenWidth * 0.9, height: screenHeight * 0.1)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(20)
    }
}

struct BoardMainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(containedViewType: .board)
            .environmentObject(SessionService())
    }
}
