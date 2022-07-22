//
//  RoverPhotos.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let roverPhoto = try? newJSONDecoder().decode(RoverPhoto.self, from: jsonData)



// MARK: - RoverPhoto
struct RoverPhoto: Codable {
    let photos: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id: Int
    let imgSrc: String
    let earthDate: String


    enum CodingKeys: String, CodingKey {
        case id
        case imgSrc = "img_src"
        case earthDate = "earth_date"

    }
}


