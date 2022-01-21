//
//  Data.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-03.
//

import Foundation

// MARK: Enum
enum ContainedViewType {
    case home
    case time
    case board
    case profile
}

enum TimeTableSubViewType {
    case timetable
    case calendar
}

enum ConstantOption {
    static let GenderOption: [String] = ["Male", "Female", "Transgender", "Non-binary", "Prefer not to respond"]
    static let AcademicStatusOption: [String] = ["Undergraduate", "Masters", "PhD", "Post-Doc"]
}

// MARK: School Info
let CanadianUniversityList: [String] = ["Algoma University", "Brock University", "Carleton University", "University of Guelph", "Lakehead University", "Laurentian University", "McMaster University", "Nipissing University","OCAD University","Ontario Tech University","University of Ottawa", "Queen’s University", "Royal Military College of Canada","Ryerson University","University of Toronto", "Trent University","University of Waterloo","Western University","Wilfrid Laurier University","University of Windsor","York University"]

let UWaterlooPrograms: [String] = ["Accounting and Financial Management", "Architectural Engineering", "Architecture", "Biomedical Engineering", "Biotechnology/CPA", "BA/CS (Double Degree)", "BA/Math (Double Degree)", "Chemical Engineering", "Civil Engineering", "Computer Engineering", "Computer Science", "CFM", "Electrical Engineering", "Environmental Engineering", "Environmental Science", "Environment and Business", "Environment, Resources and Sustainability", "Geography and Aviation", "Geography and Environmental Management", "Geological Engineering", "Geomatics", "Global Business and Digital Arts", "Health Studies", "Honours Arts", "Honours Arts & Business", "Honours Science", "International Development", "Kinesiology", "Knowledge Integration", "Life Sciences", "Management Engineering", "Mathematics/Business Administration", "Mathematics/CPA", "Mathematics/FARM", "Mathematics", "Mechanical Engineering", "Mechatronics Engineering", "Nanotechnology Engineering", "Physical Sciences", "Planning", "Public Health", "Recreation & Leisure Studies", "Science and Aviation", "Science and Business", "Software Engineering", "Systems Design Engineering"]
let UWaterlooFaculty: [String] = ["Arts", "Engineering", "Environment", "Health", "Mathematics", "Science"]


