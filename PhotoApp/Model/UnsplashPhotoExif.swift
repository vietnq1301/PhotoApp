//
//  UnsplashExif.swift
//  PhotoApp
//
//  Created by Nguyễn Việt on 20/08/2022.
//

import Foundation

struct UnsplashPhotoExif: Codable {
    
   var make: String?
   var model: String?
   var name: String?
   var exposureTime: String?
   var aperture: String?
   var focalLength: String?
   var iso: Int?
    
    init() {
        self.make = ""
        self.model = ""
        self.name = ""
        self.exposureTime = ""
        self.aperture = ""
        self.focalLength = ""
        self.iso = 0
    }
    
    init(make: String, model: String, name: String, exposureTime: String, aperture: String, focalLength: String, iso: Int) {
        self.make = make
        self.model = model
        self.name = name
        self.exposureTime = exposureTime
        self.aperture = aperture
        self.focalLength = focalLength
        self.iso = iso
    }
    
    enum CodingKeys: String, CodingKey {
        case make
        case model
        case name
        case exposureTime = "exposure_time"
        case aperture
        case focalLength = "focal_length"
        case iso
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        make = try? container.decode(String.self, forKey: .make)
        model = try? container.decode(String.self, forKey: .model)
        name = try? container.decode(String.self, forKey: .name)
        exposureTime = try? container.decode(String.self, forKey: .exposureTime)
        aperture = try? container.decode(String.self, forKey: .aperture)
        focalLength = try? container.decode(String.self, forKey: .focalLength)
        iso = try? container.decode(Int.self, forKey: .iso)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(make, forKey: .make)
        try container.encode(model, forKey: .model)
        try container.encode(name, forKey: .name)
        try container.encode(exposureTime, forKey: .exposureTime)
        try container.encode(aperture, forKey: .aperture)
        try container.encode(focalLength, forKey: .focalLength)
        try container.encode(iso, forKey: .iso)
    }
}
