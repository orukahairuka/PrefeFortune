//
//  PrefeFortuneApp.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import SwiftUI

@main
struct PrefeFortuneApp: App {
    private let fortuneAPIManager = FortuneAPIManager()
    @StateObject private var placesAPIManager = PlacesAPIManager()
    var body: some Scene {
        WindowGroup {
            TouristCardView(placesManager: placesAPIManager)
        }
    }
}
