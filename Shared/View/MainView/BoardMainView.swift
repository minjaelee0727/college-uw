//
//  BoardMainView.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021/07/25.
//

import SwiftUI

struct BoardMainView: View {
    let iconSize: CGFloat = screenWidth * 0.07
    let textWidth: CGFloat = screenWidth * 0.15
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Quick Boxes")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .padding()
                
                ScrollView(.horizontal) {
                    HStack {
                        VStack(alignment: .center) {
                            Button(action: {})
                            {
                                Image(systemName: "note.text")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: iconSize, height: iconSize)
                                    .foregroundColor(.blue)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color(red: 246/255, green: 255/255, blue: 255/255))
                                    )
                            }
                            
                            Text("My Posts")
                                .foregroundColor(.primary)
                                .opacity(0.8)
                        }
                        .padding([.leading, .trailing])
                        
                        VStack(alignment: .center) {
                            Button(action: {})
                            {
                                Image(systemName: "bookmark.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: iconSize, height: iconSize)
                                    .foregroundColor(.yellow)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color(red: 246/255, green: 255/255, blue: 255/255))
                                    )
                            }
                            
                            Text("Saved Posts")
                                .foregroundColor(.primary)
                                .opacity(0.8)

                        }
                        .padding([.leading, .trailing])
                        
                        VStack(alignment: .center) {
                            Button(action: {})
                            {
                                Image(systemName: "flame.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: iconSize, height: iconSize)
                                    .foregroundColor(.red)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color(red: 246/255, green: 255/255, blue: 255/255))
                                    )
                            }
                            
                            Text("Hot Posts")
                                .foregroundColor(.primary)
                                .opacity(0.8)
                        }
                        .padding([.leading, .trailing])

                    }
                }
            }
            
            
            ScrollView {
                
            }
            
            Spacer()
        }
    }
}



struct BoardMainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(containedViewType: .board)
    }
}
