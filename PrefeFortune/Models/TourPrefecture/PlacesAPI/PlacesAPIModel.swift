//
//  PlacesAPIModel.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import Foundation

struct PlacesResponse: Codable {
    let results: [Place]
}

struct Place: Codable, Identifiable {
    let id: String
    let name: String
    let vicinity: String
    let rating: Double?
    let geometry: Geometry?
    let openingHours: OpeningHours?
    let types: [String]?
    let userRatingsTotal: Int?

    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case name
        case vicinity
        case rating
        case geometry
        case openingHours = "opening_hours"
        case types
        case userRatingsTotal = "user_ratings_total"
    }
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

struct OpeningHours: Codable {
    let openNow: Bool?

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}
