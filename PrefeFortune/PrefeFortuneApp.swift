//
//  PrefeFortuneApp.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import SwiftUI
import UIKit

@main
struct PrefeFortuneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
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


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait // 縦向きに固定
    }
}
