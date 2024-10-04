//
//  FortuneAPIModels.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import Foundation

struct FortuneRequest: Codable {
    let name: String
    let birthday: YearMonthDay
    let bloodType: String
    let today: YearMonthDay

    enum CodingKeys: String, CodingKey {
        case name
        case birthday
        case bloodType = "blood_type"
        case today
    }
}

struct YearMonthDay: Codable {
    let year: Int
    let month: Int
    let day: Int
}

struct FortuneResponse: Codable {
    let name: String
    let capital: String
    let citizenDay: MonthDay?
    let hasCoastLine: Bool
    let logoURL: String
    let brief: String

    enum CodingKeys: String, CodingKey {
        case name
        case capital
        case citizenDay = "citizen_day"
        case hasCoastLine = "has_coast_line"
        case logoURL = "logo_url"
        case brief
    }
}

struct MonthDay: Codable {
    let month: Int
    let day: Int
}
