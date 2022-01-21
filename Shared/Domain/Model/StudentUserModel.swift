//
//  StudentUserModel.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-09-22.
//

import Foundation
import FirebaseFirestore

struct StudentUserModel: Codable {
    var uid: String?
    var username: String?
    var preferredName: String?
    var birthDate: Date?
    var firstName: String?
    var lastName: String?
    var gender: String?
    var academicStatus: String?
    var faculty: String?
    var program: String?
    var academicLevel: String?
    var clubs: [String]?
    var isDriver: Bool?
    var driverLicense: String?
    var drivingYear: Int?
    var carModel: String?
    var employeeInfo: [StudentUserModel_WorkingExperienceInfo]?
    var address1: String?
    var address2: String?
    var city: String?
    var province: String?
    var country: String?
    var postalCode: String?
}

struct StudentUserModel_WorkingExperienceInfo: Hashable, Codable {
    var position: String?
    var company: String?
    var startDate: String?
    var endDate: String?
    var city: String?
    var province: String?
    var description: String?
    
    init() {
        position = ""
        company = ""
        startDate = ""
        endDate = ""
        city = ""
        province = ""
        description = ""
    }
}
