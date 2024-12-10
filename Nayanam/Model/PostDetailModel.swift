//
//  PostDetailModel.swift
//  Nayanam
//
//  Created by meet sharma on 10/05/24.
//

import Foundation

// MARK: - Welcome
struct DetailModel: Codable {
    let postDetailModel: PostDetailModel?
}

// MARK: - PostDetailModel
struct PostDetailModel: Codable {
    let commentModelVec: [CommentModelVec]
    let ownerModel: OwnerModelDetail?
    let photoModelVec: [PhotoModelDetail]?
    let postModel: PostModel?
}

// MARK: - CommentModelVec
struct CommentModelVec: Codable {
    let createdAt: Double?
    let id: Int?
    let ownerModel: OwnerModelDetail?
    let text: String?
}

// MARK: - OwnerModel
struct OwnerModelDetail: Codable {
    let emailVerified: Bool?
    let firstName, lastName: String?
    let socialProfilePhotoURL: String?
    let tagModelVec: String?
    let userID: Int?
    let userRole: String?
    let linkedinProfileURL: String?
    let photoModel: PhotoModelDetail?

    enum CodingKeys: String, CodingKey {
        case emailVerified, firstName, lastName
        case socialProfilePhotoURL = "socialProfilePhotoUrl"
        case tagModelVec
        case userID = "userId"
        case userRole
        case linkedinProfileURL = "linkedinProfileUrl"
        case photoModel
    }
}

// MARK: - PhotoModel
struct PhotoModelDetail: Codable {
    let id: Int?
    let specMap: SpecMapDetail?
}

// MARK: - SpecMap
struct SpecMapDetail: Codable {
    let lg, md, sm, xl: LgDetail?
}

// MARK: - Lg
struct LgDetail: Codable {
    let height: Int?
    let name: String?
    let url: String?
    let width: Int?
}

// MARK: - PostModel
struct PostModel: Codable {
    let commentCount: Int?
    let commentModelVec: String?
    let createdAt: Double?
    let id, likeCount: Int?
    let photoModelVec: String?
    let quality, text, urlText: String?
}
