//
//  BuyUsed.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-09.
//

import SwiftUI

struct BuyUsed: View {
    @State var searchInput: String = ""
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Generalize {
                VStack(spacing: 0){
                    Header_TitleDismiss(boardTitle: "Buy Used")
                    
                    SearchBar(input: $searchInput)
                    
                    ScrollView {
                        ForEach((1...10), id:\.self) {
                            _ in
                            VStack(alignment: .leading) {
                                ProductPreview()
                                Divider()
                            }
                        }
                    }
                    
                    Spacer()
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            
            NavigationLink(destination: AddProduct()) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: screenWidth * 0.15, height: screenWidth * 0.15)
                    .foregroundColor(.green)
            }
            .padding()
        }
    }
}

struct SearchBar: View {
    @Binding var input: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("What are you looking for?", text: $input)
                    .disableAutocorrection(true)
                
                Button(action: {}) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .frame(height: screenHeight * 0.048)
            .background(Color(UIColor.systemBackground))

            
            Divider()
        }
    }
}

struct ProductPreview: View {
    var body: some View {
        HStack(spacing: screenWidth * 0.05) {
            Image(systemName: "desktopcomputer")
                .resizable()
                .frame(width: screenHeight * 0.1, height: screenHeight * 0.1)
            
            VStack(alignment: .leading) {
                Text("LG 4K 27inch Monitor")
                
                Text("254 Phillip Street")
                    .font(.caption)
                
                Spacer()
                
                Text("$200")
                    .bold()
                
                Spacer()

                HStack {
                    Text("1 min ago.")
                        .font(.caption)
                    
                    Spacer()
                    
//                    Image(systemName: "bubble.left.and.bubble.right")
//                        .font(.caption)
                }
            }
        }
        .padding()
    }
}

struct AddProduct: View {
    @State var usedName: String = ""
    @State var usedPrice: String = ""
    @State var usedDescription: String = ""
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Generalize {
            VStack {
                VStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        Text("Sell Used")
                            .foregroundColor(.primary)
                            .font(.title3)
                            .fontWeight(.regular)
                        Spacer()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Post")
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding([.leading, .trailing])
                    
                    Divider()
                }
                
                VStack {
                    VStack {
                        ScrollView(.horizontal) {
                            HStack {
                                Button(action: {}) {
                                    Image(systemName: "plus.square")
                                        .resizable()
                                        .frame(width: screenWidth * 0.2, height: screenWidth * 0.15)
                                        .scaledToFit()
                                        .foregroundColor(.secondary)
                                        .padding()
                                }
                            }
                        }
                        
                        Divider()
                    }
                    
                    VStack {
                        
                        TextField("Used Name", text: $usedName)
                            .padding([.top, .bottom])
                        
                        Divider()
                    }
                    
                    VStack {
                        
                        TextField("$ Price", text: $usedPrice)
                            .padding([.top, .bottom])
                        
                        Divider()
                    }
                    
                    VStack {
                        
                        TextField("Description", text: $usedDescription)
                            .padding([.top, .bottom])
                        
                    }
                    
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct BuyUsed_Previews: PreviewProvider {
    static var previews: some View {
        BuyUsed()
    }
}
