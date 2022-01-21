//
//  SignupViewModel.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-11-01.
//

import Combine
import FirebaseAuth
import Foundation

//enum SignupState {
//    case successfull
//    case failed(error: String)
//    case none
//    case unknown
//}

class SignupViewModel: ObservableObject {
    @Published var error: Bool = false
    @Published var details: RegistrationModelTEMP = RegistrationModelTEMP.new
    @Published var errMsg: String = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    func signup() {
        self.errMsg = ""
        
        let userModel = RegistrationModel.init(email: self.details.email + "@uwaterloo.ca", password: self.details.password, userType: "Student", school: self.details.school, firstName: self.details.firstName, lastName: self.details.lastName, academicStatus: ConstantOption.AcademicStatusOption[self.details.academicStatusIndex!], faculty: UWaterlooFaculty[self.details.facultyIndex!], program: self.details.program)
        
        AuthService
            .signup(with: userModel)
            .receive(on: RunLoop.main)
            .sink {
                res in
                print(res)
                switch res {
                case .failure(let err):
                    self.error = true
                    self.errMsg = err.localizedDescription
                default: break
                }
            } receiveValue : {
                _ in
                self.error = false
            }
            .store(in: &subscriptions)
    }
    
    func checkCredential() -> Bool {
        return !details.password.isEmpty && (details.rePassword == details.password) && !details.email.isEmpty
    }
    
    func checkMissingInfo() -> Bool {
        return (details.firstName.isEmpty || details.lastName.isEmpty || details.academicStatusIndex == nil || details.facultyIndex == nil || details.program.isEmpty)
    }
    
    func infoTitle() -> String {
        if details.firstName.isEmpty || details.lastName.isEmpty {
            return "What is your name?"
        }
        if (details.academicStatusIndex == nil) {
            return "What is your academic status?"
        }
        if (details.facultyIndex == nil) {
            return "What is your faculty?"
        }
        if details.program.isEmpty {
            return "What is your program?"
        }
        
        return "Check your info!"
    }
}
