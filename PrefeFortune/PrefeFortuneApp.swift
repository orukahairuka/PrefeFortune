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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
