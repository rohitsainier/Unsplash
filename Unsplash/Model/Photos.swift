//
//  Photos.swift
//  Unsplash
//
//  Created by App Knit on 16/04/21.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let id, photoDescription: String?
    let user: User?
    let urls: Urls?

    enum CodingKeys: String, CodingKey {
        case id
        case photoDescription = "description"
        case user, urls
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DecodeDefaultValues.Empty.string
        photoDescription = try values.decodeIfPresent(String.self, forKey: .photoDescription) ?? DecodeDefaultValues.Empty.string
        user = try values.decodeIfPresent(User.self, forKey: .user) ?? nil
        urls = try values.decodeIfPresent(Urls.self, forKey: .urls) ?? nil
    }
    
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        raw = try values.decodeIfPresent(String.self, forKey: .raw) ?? DecodeDefaultValues.Empty.string
        full = try values.decodeIfPresent(String.self, forKey: .full) ?? DecodeDefaultValues.Empty.string
        regular = try values.decodeIfPresent(String.self, forKey: .regular) ?? DecodeDefaultValues.Empty.string
        small = try values.decodeIfPresent(String.self, forKey: .small) ?? DecodeDefaultValues.Empty.string
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb) ?? DecodeDefaultValues.Empty.string
    }
}

// MARK: - User
struct User: Codable {
    let id, name, location: String
    let profileImage: ProfileImage?

    enum CodingKeys: String, CodingKey {
        case id, name, location
        case profileImage = "profile_image"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DecodeDefaultValues.Empty.string
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? DecodeDefaultValues.Empty.string
        location = try values.decodeIfPresent(String.self, forKey: .location) ?? DecodeDefaultValues.Empty.string
        profileImage = try values.decodeIfPresent(ProfileImage.self, forKey: .profileImage) ?? nil
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small: String
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        small = try values.decodeIfPresent(String.self, forKey: .small) ?? DecodeDefaultValues.Empty.string
    }
}

