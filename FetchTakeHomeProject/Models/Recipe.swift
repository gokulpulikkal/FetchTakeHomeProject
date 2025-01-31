//
//  Recipe.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import Foundation

struct Recipe: Identifiable, Decodable, Equatable {
    var id: String {
        uuid
    }

    let cuisine: String
    let name: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let uuid: String
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case uuid
        case youtubeURL = "youtube_url"
    }
}
