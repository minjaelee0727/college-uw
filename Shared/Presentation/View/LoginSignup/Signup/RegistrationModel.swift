//
//  RegistrationDetails.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-30.
//

import Foundation

struct RegistrationModelTEMP {
    var email: String
    var password: String
    var rePassword: String
    var userType: String
    var school: String
    var firstName: String
    var lastName: String
    var academicStatus: String
    var academicStatusIndex: Int?
    var faculty: String
    var facultyIndex: Int?
    var program: String
}

extension RegistrationModelTEMP {
    static var new: RegistrationModelTEMP {
        RegistrationModelTEMP(email: "", password: "", rePassword: "", userType: "Student", school: "", firstName: "", lastName: "", academicStatus: "", academicStatusIndex: nil, faculty: "", facultyIndex: nil, program: "")
    }
    
    func isEmpty() -> Bool {
        return self.email.isEmpty || self.password.isEmpty || self.school.isEmpty || self.firstName.isEmpty || self.lastName.isEmpty || self.academicStatus.isEmpty || self.faculty.isEmpty || self.program.isEmpty || (self.facultyIndex != nil) || (self.academicStatusIndex != nil)
    }
}

struct RegistrationModel {
    var email: String
    var password: String
    var userType: String
    var school: String
    var firstName: String
    var lastName: String
    var academicStatus: String
    var faculty: String
    var program: String
}
