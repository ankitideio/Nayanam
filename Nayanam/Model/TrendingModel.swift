//
//  TrendingModel.swift
//  Nayanam
//
//  Created by meet sharma on 09/05/24.
//

import Foundation



struct TrendingModel: Codable {
    let postModelVec: [PostModelVec]?
}

// MARK: - PostModelVec
struct PostModelVec: Codable {
    let commentModelVec: String?
    let createdAt: Double?
    let id, likeCount: Int?
    let ownerModel: OwnerModel?
    let photoModelVec: [PhotoModel]?
    let quality: String?
    let text, urlText, title: String?
    let commentCount: Int?
    let htmlDesc: String?
}

// MARK: - OwnerModel
struct OwnerModel: Codable {
    let emailVerified: Bool?
    let firstName: String?
    let lastName: String?
    let linkedinProfileURL: String?
    let photoModel: PhotoModel?
    let tagModelVec: String?
    let userID: Int?
    let userRole: String?

    enum CodingKeys: String, CodingKey {
        case emailVerified, firstName, lastName
        case linkedinProfileURL = "linkedinProfileUrl"
        case photoModel, tagModelVec
        case userID = "userId"
        case userRole
    }
}

enum FirstName: String, Codable {
    case praveen = "Praveen"
}

enum LastName: String, Codable {
    case yarlagadda = "Yarlagadda"
}

// MARK: - PhotoModel
struct PhotoModel: Codable {
    let id: Int?
    let specMap: SpecMap?
}

// MARK: - SpecMap
struct SpecMap: Codable {
    let lg, md, sm, xl: Lg?
}

// MARK: - Lg
struct Lg: Codable {
    let height: Int?
    let name: String?
    let url: String?
    let width: Int?
}

