//
//  SearchPrefectureResultView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/07.
//

import SwiftUI
import CoreLocation

struct FortuneResultView: View {
    @ObservedObject var fortuneAPIManager: FortuneAPIManager
    @StateObject var latLonManager: LatLonManager = LatLonManager()
    @StateObject var placesAPIManager: PlacesAPIManager = PlacesAPIManager()

    @State private var latitude: Double? = nil
    @State private var longitude: Double? = nil
    @State private var retryCount: Int = 0
    @State private var distance: Double = 0.0
    @State private var isLoading: Bool = true
    @State private var isRetrying: Bool = false

    private let maxRetryCount: Int = 3 // リトライの最大回数

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Spacer()

                // ロゴ表示
                if let logoURL = fortuneAPIManager.decodedLogoURL {
                    PrefectureImageView(imageUrl: .constant(logoURL), prefectureName: $fortuneAPIManager.prefectureName)
                        .whiteRoundedModifier()
                        .padding(.horizontal, 30)
                }

                // 地図表示（緯度・経度が取得できた場合）
                if let latitude = latitude, let longitude = longitude {
                    MapView(latitude: .constant(latitude), longitude: .constant(longitude), destination: .constant(CLLocationCoordinate2D(latitude: latitude, longitude: longitude)), distance: $distance)
                        .whiteRoundedModifier()
                        .padding(.top, 10)
                }

                // 観光情報表示
                if isLoading {
                    ProgressView("データを読み込んでいます...")
                        .whiteRoundedModifier()
                } else if isRetrying {
                    Text("観光情報が見つかりませんでした。もう一度検索中です...")
                        .font(.body)
                        .whiteRoundedModifier()
                } else {
                    if placesAPIManager.nearbyPlaces.isEmpty {
                        Text("観光情報が見つかりませんでした。")
                            .font(.body)
                            .whiteRoundedModifier()
                    } else {
                        TouristCardView(placesManager: placesAPIManager, latitude: $latitude, longitude: $longitude)
                    }
                }

                // ナビゲーションボタン
                CatDistanceNavigationView(
                    distance: $distance,
                    prefectureName: Binding(
                        get: { fortuneAPIManager.prefectureName ?? "不明な県" },
                        set: { fortuneAPIManager.prefectureName = $0 }
                    )
                )

                Spacer()
            }
            .onAppear {
                loadLocationData()
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.customPinkColor, Color.customBlueColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
        .customNavigationBar()
    }

    private func loadLocationData() {
        retryCount = 0
        attemptToLoadDataWithRetry()
    }

    private func attemptToLoadDataWithRetry() {
        Task {
            let success = await executeLoadLocationData()
            if !success && retryCount < maxRetryCount {
                retryCount += 1
                print("リトライ中: \(retryCount) 回目")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    attemptToLoadDataWithRetry()
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isRetrying = !success
                }
                if !success {
                    print("リトライの上限に達したため、停止しました。")
                }
            }
        }
    }


    private func executeLoadLocationData() async -> Bool {
        guard let prefectureName = fortuneAPIManager.prefectureName, !prefectureName.isEmpty else {
            print("場所の名前が見つからないため、終了します。")
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return false
        }

        if let location = await latLonManager.getLatLon(forPrefecture: prefectureName) {
            DispatchQueue.main.async {
                self.latitude = location.latitude
                self.longitude = location.longitude
            }
            let placesLoaded = await fetchPlacesData(latitude: location.latitude, longitude: location.longitude)
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return placesLoaded
        } else {
            DispatchQueue.main.async {
                self.isLoading = false
                self.isRetrying = true // エラー表示用にリトライ状態を設定
            }
            return false
        }
    }


    private func fetchPlacesData(latitude: Double, longitude: Double) async -> Bool {
        print("Fetching places for latitude: \(latitude), longitude: \(longitude)")
        await placesAPIManager.fetchNearbyPlaces(latitude: latitude, longitude: longitude)
        DispatchQueue.main.async {
            self.distance = calculateDistance(from: CLLocation(latitude: latitude, longitude: longitude))
        }
        let placesLoaded = !placesAPIManager.nearbyPlaces.isEmpty
        print("Places loaded: \(placesLoaded)")
        return placesLoaded
    }

    // calculateDistance 関数を追加
    private func calculateDistance(from location: CLLocation) -> Double {
        // 距離計算のために現在地を取得し、場所までの距離を計算
        guard let userLocation = CLLocationManager().location else {
            return 0.0
        }
        let distanceInMeters = userLocation.distance(from: location)
        return distanceInMeters / 1000.0 // 距離をキロメートルで返す
    }
}
