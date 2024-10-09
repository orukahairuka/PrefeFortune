//
//  PrefeFortuneApp.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import SwiftUI

@main
struct PrefeFortuneApp: App {
    @StateObject var stateManager = StateManager()

    var body: some Scene {
        WindowGroup {
            if stateManager.isLocationLoading {
                // ローディング中はLanchLoadingViewを表示
                LanchLoadingView()
                    .onAppear {
                        // 位置情報の取得を開始
                        stateManager.setupLocationManager()
                    }
            } else {
                // ローディング完了後にStartNavigationViewを表示
                NavigationStack {
                    StartNavigationView()
                        .environmentObject(stateManager) // StateManagerを共有
                }
            }
        }
    }
}
