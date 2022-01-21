//
//  RandomBoard.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-09.
//

import SwiftUI

struct WaterlooWarriorsBoard: View {
    var body: some View {
        Generalize {
            ZStack(alignment: .bottomTrailing) {
                
                
                VStack(spacing: 0) {
                    Header_TitleDismiss(boardTitle: "Waterloo Warriors")
                    
                    ScrollView() {
                        ForEach((1...10), id:\.self) { _ in
                            PostPreview()
                                .padding(.bottom)
                        }
                    }
                    .background(Color.gray.opacity(0.1))
                    .edgesIgnoringSafeArea(.bottom)
                }
                
                NavigationLink(destination: AddGeneralPostView()) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: screenWidth * 0.15, height: screenWidth * 0.15)
                        .foregroundColor(.green)
                        .background(
                            Circle()
                                .foregroundColor(.white)
                        )
                }
                .padding()
            }
        }
    }
}

struct PostPreview: View {    
    var body: some View {
        NavigationLink(destination: Text("d")) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "app.fill")
                        .resizable()
                        .frame(width: screenWidth * 0.1, height: screenWidth * 0.1)
                        .scaledToFit()
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                Text("Etiam at lacus sit amet lorem fermentum fermentum eu eget felis. Mauris cursus enim id mauris pretium pretium. Fusce non metus tristique, rhoncus neque dapibus, consectetur turpis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Praesent ac dui ligula. Aenean a tellus a leo commodo feugiat non in mauris. Nullam sollicitudin dignissim bibendum. Curabitur ultricies lectus sit amet mi aliquet imperdiet. Suspendisse vitae quam faucibus libero fermentum ultricies. Vestibulum convallis sodales mollis. In nec felis vehicula, posuere lacus vel, auctor velit. Nullam consequat eleifend ante, quis ultrices orci imperdiet ac. Sed elementum tincidunt eros vel iaculis. Donec ac turpis laoreet, maximus dui et, dignissim nulla. Nunc semper vestibulum est nec maximus. Pellentesque eu magna pellentesque, bibendum sapien vel, mattis ex.")
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Text("")
                
                HStack {
                    Text("17h ago")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "heart")
                            .foregroundColor(.green)
                        
                        Text("13")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Image(systemName: "bubble.right")
                            .foregroundColor(.green)
                        
                        Text("7")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
        }
    }
}

struct WaterlooWariorsBoard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WaterlooWarriorsBoard()
        }
    }
}
