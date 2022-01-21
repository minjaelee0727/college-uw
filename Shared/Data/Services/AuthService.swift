//
//  AuthService.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-30.
//

import Combine
import FirebaseAuth

enum AuthError: Error {
    case invalidUserId
    case emailVerifiedError
    case unknown
}

//protocol AuthServiceProtocol {
//    static func currentUser() ->AnyPublisher<User?, Never>
//
//    static func login(with credentials: Credential) -> AnyPublisher<User, Error>
//
//    static func signup(with details: RegistrationModel) -> AnyPublisher<Void, Error>
//}

final class AuthService {
    class func currentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    class func login(with credentials: Credential) -> AnyPublisher<User, Error> {
        return Future<User, Error> {
            promise in
            
            Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) {
                result, error in
                
                if let error = error {
                    return promise(.failure(error))
                } else if let user = result?.user {
                    if user.isEmailVerified {
                        return promise(.success(user))
                    } else {
                        return promise(.failure(AuthError.emailVerifiedError))
                    }
                } else {
                    return promise(.failure(AuthError.unknown))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    class func signup(with details: RegistrationModel) -> AnyPublisher<Void, Error> {
        Deferred {
            Future {
                promise in
                
                Auth.auth().createUser(withEmail: details.email, password: details.password) {
                    res, err in
                    
                    if let err = err {
                        promise(.failure(err))
                    } else {
                        
                        Auth.auth().currentUser?.sendEmailVerification { err in
                            if let err = err {
                                promise(.failure(err))
                            } else {
                                if let userId = res?.user.uid {
                                    let userProfile = StudentUserModel.init(uid: userId, username: nil, preferredName: nil, birthDate: nil, firstName: details.firstName, lastName: details.lastName, gender: nil, academicStatus: details.academicStatus, faculty: details.faculty, program: details.program, academicLevel: nil, clubs: nil, isDriver: nil, driverLicense: nil, drivingYear: nil, carModel: nil, employeeInfo: nil, address1: nil, address2: nil, city: nil, province: nil, country: nil, postalCode: nil)
                                    
                                    NetworkService.updateProfile(profile: userProfile, completion: {
                                        result in
                                        
                                        switch result {
                                        case .success():
                                            promise(.success(()))
                                        case .failure(let err):
                                            promise(.failure(err))
                                        }
                                    })
                                } else {
                                    promise(.failure(AuthError.invalidUserId))
                                }
                            }
                        }
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
