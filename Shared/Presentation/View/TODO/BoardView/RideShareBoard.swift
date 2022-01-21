//
//  RideShareBoard.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-12.
//

import SwiftUI

let locationList = ["Waterloo", "Toronto", "Union Station", "Richmond Hill", "North York", "Markham", "London", "Hamilton", "Scarborough", "Guelph"]

struct RideShareBoard: View {
    @State var fromLocation: String = "Waterloo"
    @State var toLocation: String = "Toronto"
    
    var body: some View {
        Generalize {
            VStack {
                Header_TitleDismiss(boardTitle: "Find Ride Share")
                
                ZStack(alignment: .top) {
                    ScrollView {
                        VStack {
                            RidesharePostPreview()
                            Divider()
                        }
                    }
                    .offset(y: screenHeight * 0.05)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("From")
                            Spacer()
                            Dropdown(height: 150, options: locationList, selection: $fromLocation)
                            Spacer()
                            Text("To")
                            Spacer()
                            Dropdown(height: 150, options: locationList, selection: $toLocation)
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

struct RidesharePostPreview: View {
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.2.circle")
                .resizable()
                .frame(width: screenHeight * 0.05, height: screenHeight * 0.05)
                .padding()
            
            VStack(alignment: .leading) {
                Text("September 10th")
                    .bold()
                
                Text("Looking for a ride for two people from waterloo to toronto")
                
                HStack {
                    Image(systemName: "person.fill")
                    
                    Text("4")
                    
                    Image(systemName: "person.badge.plus")
                    
                    Image(systemName: "person.fill.xmark")
                }
                .background(
                    RoundedRectangle(cornerRadius: 5).stroke(Color.gray)
                )
            }
        }
    }
}

struct RideShareBoard_Previews: PreviewProvider {
    static var previews: some View {
        RideShareBoard()
    }
}
