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

    private let maxRetryCount: Int = 3 // リトライの最大回数

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                Spacer()

                if let logoURL = fortuneAPIManager.decodedLogoURL {
                    PrefectureImageView(imageUrl: .constant(logoURL), prefectureName: $fortuneAPIManager.prefectureName)
                        .roundedBackground()
                        .padding(.horizontal, 30)
                }

                if let latitude = latitude, let longitude = longitude {
                    MapView(latitude: .constant(latitude), longitude: .constant(longitude), destination: .constant(CLLocationCoordinate2D(latitude: latitude, longitude: longitude)), distance: $distance)
                        .roundedBackground()
                        .padding(.top, 10)
                }

                if let latitude = latitude, let longitude = longitude {
                    if placesAPIManager.nearbyPlaces.isEmpty && retryCount < maxRetryCount {
                        Text("観光情報が見つかりませんでした。もう一度検索中です...")
                            .font(.body)
                            .roundedBackground()
                            .onAppear {
                                retryLoadLocationData()
                            }
                    } else {
                        TouristCardView(placesManager: placesAPIManager, latitude: $latitude, longitude: $longitude)
                    }
                } else {
                    ProgressView("データを読み込んでいます...")
                        .roundedBackground()
                }

                FirstNavigationView(
                    distance: $distance,
                    prefectureName: Binding(
                        get: { fortuneAPIManager.prefectureName ?? "不明な県" },  // nilなら"不明な県"を返す
                        set: { fortuneAPIManager.prefectureName = $0 }  // バインディングされた値が変更された場合に更新
                    )
                )

                Spacer()
            }
            .onAppear {
                loadLocationData()
            }
        }
        // カスタムナビゲーションバーを設定
        .customNavigationBar(title: "占い結果")
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.customPinkColor, Color.customBlueColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }

    private func loadLocationData() {
        retryCount = 0
        executeLoadLocationData()
    }

    private func retryLoadLocationData() {
        retryCount += 1
        if retryCount <= maxRetryCount {
            print("リトライ中: \(retryCount) 回目")
            executeLoadLocationData()
        } else {
            print("リトライの上限に達したため、停止しました。")
        }
    }

    private func executeLoadLocationData() {
        guard let prefectureName = fortuneAPIManager.prefectureName, !prefectureName.isEmpty else {
            print("場所の名前が見つからないため、終了します。")
            return
        }

        Task {
            if let location = await latLonManager.getLatLon(forPrefecture: prefectureName) {
                DispatchQueue.main.async {
                    self.latitude = location.latitude
                    self.longitude = location.longitude
                }
                await fetchPlacesData(latitude: location.latitude, longitude: location.longitude)
            } else {
                handleLocationFetchFailure()
            }
        }
    }

    private func fetchPlacesData(latitude: Double, longitude: Double) async {
        await placesAPIManager.fetchNearbyPlaces(latitude: latitude, longitude: longitude)

        DispatchQueue.main.async {
            if placesAPIManager.nearbyPlaces.isEmpty && retryCount < maxRetryCount {
                retryLoadLocationData()
            }
        }
    }

    private func handleLocationFetchFailure() {
        DispatchQueue.main.async {
            latitude = nil
            longitude = nil
            if retryCount < maxRetryCount {
                retryLoadLocationData()
            } else {
                print("🐈 緯度と経度が見つからず、リトライ終了")
            }
        }
    }
}
