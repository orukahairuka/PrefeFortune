//
//  PrefeFortuneApp.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import SwiftUI

@main
struct PrefeFortuneApp: App {
    @StateObject var fortuneAPIManager = FortuneAPIManager()
    @StateObject var placesAPIManager = PlacesAPIManager()
    @StateObject var latLogAPIManager = LatLonManager()
    var body: some Scene {
        WindowGroup {
            SearchPrefectureView(fortuneAPIManager: fortuneAPIManager, latLonManager: latLogAPIManager)
        }
    }
}
