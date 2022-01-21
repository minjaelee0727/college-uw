//
//  LoginViewModel.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-30.
//

import Combine
import FirebaseAuth

enum LoginState {
    case successfull
    case failed
    case none
    case unknown
}

class LoginViewModel: ObservableObject {
    @Published var state: LoginState = .none
    @Published var credentials: Credential = Credential.new
    @Published var errMsg: String = ""
    
    private var subscriptions = Set<AnyCancellable>()
        
    func login() {
        AuthService
            .login(with: credentials)
            .sink { res in
                switch res {
                case .failure(AuthError.emailVerifiedError):
                    self.state = .failed
                    self.errMsg = "Please verify your email first"
                case .failure(let err):
                    if let errCode = AuthErrorCode(rawValue: err._code) {
                        self.state = .failed
                        switch errCode {
                        case .wrongPassword:
                            self.errMsg = "Please check your email or password"
                        case .unverifiedEmail:
                            self.errMsg = "Please verify your email"
                        case .invalidEmail:
                            self.errMsg = "Please check your email or password"
                        case .userNotFound:
                            self.errMsg = "Please check your email or password"
                        default:
                            self.errMsg = "Contact to service team or please try later"
                        }
                    }
                case .finished:
                    self.state = .successfull
                    self.errMsg = "Welcome to College, Warrior"
                }
            } receiveValue: { _ in
                self.state = .successfull
            }
            .store(in: &subscriptions)
    }
    
}
