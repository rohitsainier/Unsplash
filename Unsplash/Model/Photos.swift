//
//  Photos.swift
//  Unsplash
//
//  Created by App Knit on 16/04/21.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let id, photoDescription: String
    let user: User?
    let urls: Urls?

    enum CodingKeys: String, CodingKey {
        case id
        case photoDescription = "description"
        case user, urls
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

// MARK: - User
struct User: Codable {
    let id, name, location: String
    let profileImage: ProfileImage

    enum CodingKeys: String, CodingKey {
        case id, name, location
        case profileImage = "profile_image"
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small: String
}
