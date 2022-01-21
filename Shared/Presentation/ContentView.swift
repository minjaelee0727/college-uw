//
//  ContentView.swift
//  Shared
//
//  Created by Min Jae Lee on 2021/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var sessionService = SessionService()
    
    var body: some View {
        Group {
            switch sessionService.state {
            case .loggedOut:
                FUView()
            case .loggedIn:
                MainView()
                    .environmentObject(sessionService)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
