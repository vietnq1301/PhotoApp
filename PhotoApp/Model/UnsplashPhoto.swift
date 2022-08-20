//
//  Photo.swift
//  PhotoApp
//
//  Created by Nguyễn Việt on 20/08/2022.
//

import Foundation
import CarPlay

struct UnsplashPhotoUrl: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}

struct UnsplashPhotoLink: Codable {
    var own: String
    var html: String
    var download: String
    var downloadLocation: String
    
    enum CodingKeys: String, CodingKey {
        case own = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

struct UnsplashPhoto: Codable {
    var id: String
    var width: Int
    var height: Int
    var color: String?
    var blurHash: String?
    var description: String?
    var exif: UnsplashPhotoExif
    var urls: UnsplashPhotoUrl
    var links: UnsplashPhotoLink
    var likesCount: Int?
    var downloadsCount: Int?
    var viewsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case color
        case blurHash = "blur_hash"
        case likesCount = "likes"
        case description
        case exif
        case urls
        case links
        case downloadsCount = "downloads"
        case viewsCount = "views"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        color = try? container.decode(String.self, forKey: .color)
        blurHash = try? container.decode(String.self, forKey: .blurHash)
        description = try? container.decode(String.self, forKey: .description)
        exif = try container.decode(UnsplashPhotoExif.self, forKey: .exif)
        urls =  try container.decode(UnsplashPhotoUrl.self, forKey: .urls)
        links = try container.decode(UnsplashPhotoLink.self, forKey: .links)
        likesCount = try? container.decode(Int.self, forKey: .likesCount)
        downloadsCount = try? container.decode(Int.self, forKey: .downloadsCount)
        viewsCount = try? container.decode(Int.self, forKey: .viewsCount)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
        try container.encode(color, forKey: .color)
        try container.encode(blurHash, forKey: .blurHash)
        try container.encode(likesCount, forKey: .likesCount)
        try container.encode(description, forKey: .description)
        try container.encode(urls, forKey: .urls)
        try container.encode(links, forKey: .links)
        try container.encode(downloadsCount, forKey: .downloadsCount)
        try container.encode(viewsCount, forKey: .viewsCount)
        try container.encode(exif, forKey: .exif)

    }
  
}
