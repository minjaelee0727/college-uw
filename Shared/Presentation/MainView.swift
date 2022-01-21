//
//  MainView.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021/07/25.
//

import SwiftUI

struct MainView: View {
    @State var containedViewType: ContainedViewType = .home
    
    
    func containedView() -> AnyView {
         switch containedViewType {
         case .home: return AnyView(HomeView())
         case .time: return AnyView(TimeView())
         case .board: return AnyView(BoardMainView())
         case .profile: return AnyView(ProfileView())
         }
    }
        
    var body: some View {
        Generalize {
            VStack(alignment: .leading) {
                
                containedView()
                
                Spacer()
                
                MainTapBar(containedViewType: $containedViewType)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

//MARK: Tabbar
struct MainTapBar: View {
    @Binding var containedViewType: ContainedViewType
    
    var body: some View {
        HStack (spacing: 60) {
            Button(action: {
                self.containedViewType = .home
            })
            {
                VStack {
                    Image(systemName: "house")
                        .font(.system(size: 26))
                        .foregroundColor(.primary)
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.primary)
                        .opacity(self.containedViewType == .home ? 1 : 0)
                }
            }
            Button(action: {
                self.containedViewType = .board
            })
            {
                VStack {
                    Image(systemName: "doc.plaintext")
                        .font(.system(size: 26))
                        .foregroundColor(.primary)
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.primary)
                        .opacity(self.containedViewType == .board ? 1 : 0)
                }
            }
            Button(action: {
                self.containedViewType = .time
            })
            {
                 VStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 26))
                        .foregroundColor(.primary)
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.primary)
                        .opacity(self.containedViewType == .time ? 1 : 0)
                }
            }
            Button(action: {
                self.containedViewType = .profile
            })
            {
                VStack {
                    Image(systemName: "cube")
                        .font(.system(size: 26))
                        .foregroundColor(.primary)
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.primary)
                        .opacity(self.containedViewType == .profile ? 1 : 0)
                }
            }
        }
        .padding([.leading, .trailing,.bottom])
        .frame(maxWidth: .infinity)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
