//
//  AddGeneralPostModel.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-11-16.
//

import Foundation

struct AddGeneralPostModel {
    let date: Double
    let board: String
    let title: String
    let body: String
    let isAnonymous: Bool
    let imageData: Data?
    let poll: [String: Int]?
}
