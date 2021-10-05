//
//  College_UWApp.swift
//  Shared
//
//  Created by Min Jae Lee on 2021/07/24.
//

import SwiftUI
import Firebase

@main
struct College_UWApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    var body: some Scene {
        WindowGroup {
//            ContentView().environmentObject(SessionStore())
            ContentView()
        }
    }
}

// Firebase ...

class Delegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}
