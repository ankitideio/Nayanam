//
//  SearchModel.swift
//  Nayanam
//
//  Created by meet sharma on 10/05/24.
//

import Foundation

// MARK: - SearchModel

struct SearchModel: Codable {
    let feedItemModelVec: [FeedItemModelVec]?
}

// MARK: - FeedItemModelVec
struct FeedItemModelVec: Codable {
    let feedItemType: FeedItemType?
    let postModel: PostModelSearch?
}

enum FeedItemType: String, Codable {
    case kPostCreate = "kPostCreate"
}

// MARK: - PostModel
struct PostModelSearch: Codable {
    let commentModelVec: String?
    let createdAt: Double?
    let id: Int?
    let locked: Bool?
    let ownerModel: OwnerModelSearch?
    let photoModelVec: [PhotoModelSearch]?
    let quality: String?
    let text, title, urlText: String?
    let likeCount,commentCount: Int?
}

// MARK: - OwnerModel
struct OwnerModelSearch: Codable {
    let emailVerified: Bool?
    let firstName, lastName: String?
    let photoModel: PhotoModelSearch?
    let socialProfilePhotoURL: String?
    let tagModelVec: String?
    let userID: Int?
    let userRole: String?

    enum CodingKeys: String, CodingKey {
        case emailVerified, firstName, lastName, photoModel
        case socialProfilePhotoURL = "socialProfilePhotoUrl"
        case tagModelVec
        case userID = "userId"
        case userRole
    }
}

// MARK: - PhotoModel
struct PhotoModelSearch: Codable {
    let id: Int?
    let specMap: SpecMapSearch?
}

// MARK: - SpecMap
struct SpecMapSearch: Codable {
    let lg, md, sm, xl: LgSearch?
}

// MARK: - Lg
struct LgSearch: Codable {
    let height: Int?
    let name: String?
    let url: String?
    let width: Int?
}
