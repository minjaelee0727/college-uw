//
//  SessionService.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-30.
//

import FirebaseAuth
import Foundation

enum SessionState {
    case loggedIn
    case loggedOut
}

protocol SessionServiceProtocol {
    var state: SessionState { get }
    var userProfile: StudentUserModel? { get }
    func logout()
}

final class SessionService: SessionServiceProtocol, ObservableObject {
    @Published var state: SessionState = .loggedOut
    #if DEBUG
    @Published var userProfile: StudentUserModel? = StudentUserModel.init(uid: "testUID", username: "Gamja Chip", preferredName: "Chris", birthDate: nil, firstName: "Min Jae", lastName: "Lee", gender: "Male", academicStatus: nil, faculty: nil, program: nil, academicLevel: nil, clubs: nil, isDriver: nil, driverLicense: nil, drivingYear: nil, carModel: nil, employeeInfo: nil, address1: nil, address2: nil, city: nil, province: nil, country: nil, postalCode: nil)
    #else
    @Published var userProfile: StudentUserModel?
    #endif
    
    private var handler: AuthStateDidChangeListenerHandle?
    private let firebaseAuth = Auth.auth()
    
    init() {
        setupFirebaseAuthHandler()
    }
    
    private func setLoggedOut() {
        self.state = .loggedOut
    }
    
    private func setLoggedIn() {
        self.state = .loggedIn
    }
    
    public func logout() {
        do {
            try firebaseAuth.signOut()
            print("logout success")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

private extension SessionService {
    func setupFirebaseAuthHandler() {
        handler = firebaseAuth
            .addStateDidChangeListener {
                [weak self] res, user in
                guard let self = self else { return }
                
                if let user = user, user.isEmailVerified {
                    self.setLoggedIn()
                    self.handleRefresh(with: user.uid)
                }
            }
    }
    
    func handleRefresh(with uid: String) {
        FirestoreDB.userDoc(uid).getDocument {
            (document, error) in
            
            if let dict = document?.data() {
                guard let decodedUser = try? StudentUserModel.init(fromDictionary: dict) else {
                    print("CANNOT DECODE")
                    return
                }
                
                self.userProfile = decodedUser
            }
        }
    }
}
