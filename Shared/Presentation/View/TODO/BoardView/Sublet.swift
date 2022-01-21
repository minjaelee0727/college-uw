//
//  PostView.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-21.
//

import SwiftUI

// Location
// House size
// Sort By
// Filter

struct Sublet: View {
    var body: some View {
        NavigationView {
            Generalize {
                VStack {
                    Header_TitleDismiss(boardTitle: "Find Sublets")
                    
                    ZStack(alignment: .top) {
                        ScrollView {
                            VStack {
                                RidesharePostPreview()
                                Divider()
                            }
                        }
                        .offset(y: screenHeight * 0.05)
                        
                        VStack(spacing: 0) {
                            HStack(alignment: .center) {
                                NavigationLink(destination: Text("")) {
                                    Text("Sort By")
                                        .foregroundColor(.primary)
                                        .padding()
                                        .background(Color.blue)
                                }
                                .frame(maxWidth: .infinity)
                                
                                NavigationLink(destination: Text("")) {
                                    Text("Filter")
                                        .foregroundColor(.primary)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding([.leading, .trailing])
                            .frame(height: screenHeight * 0.05)
                            
                            Divider()
                        }
                        
                    }
                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        Sublet()
    }
}
