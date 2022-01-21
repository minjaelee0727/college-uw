//
//  LoginCredentialsModel.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-30.
//

import Foundation

struct Credential {
    var email: String
    var password: String
}

extension Credential {
    static var new: Credential {
        Credential(email: "", password: "")
    }
    
    func isEmpty() -> Bool {
        return self.email.isEmpty || self.password.isEmpty
    }
}
