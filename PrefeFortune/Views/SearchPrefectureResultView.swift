//
//  SearchPrefectureResultView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/07.
//

import SwiftUI

struct SearchPrefectureResultView: View {
    @ObservedObject var fortuneAPIManager: FortuneAPIManager
    @StateObject var latLonManager: LatLonManager = LatLonManager()
    @StateObject var placesAPIManager: PlacesAPIManager = PlacesAPIManager()
    @State private var latitude: Double? = nil
    @State private var longitude: Double? = nil
    @State private var isLoading: Bool = true
    @State private var retryCount: Int = 0
    private let maxRetryCount: Int = 3 // リトライの最大回数

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Spacer()

                if isLoading {
                    ProgressView("データを読み込んでいます...")
                } else {
                    if let logoURL = fortuneAPIManager.decodedLogoURL {
                        PrefectureImageView(imageUrl: .constant(logoURL))
                    }

                    if let latitude = latitude, let longitude = longitude, !placesAPIManager.nearbyPlaces.isEmpty {
                        TouristCardView(placesManager: placesAPIManager, latitude: $latitude, longitude: $longitude)
                    } else {
                        Text("観光情報が見つかりませんでした。もう一度検索中です...")
                            .onAppear {
                                if retryCount < maxRetryCount {
                                    retryLoadLocationData()
                                } else {
                                    isLoading = false
                                    print("リトライの上限に達したため、停止しました。")
                                }
                            }
                    }
                }

                Spacer()
            }
            .padding()
            .onAppear {
                if let prefectureName = fortuneAPIManager.prefectureName, !prefectureName.isEmpty {
                    loadLocationData()
                } else {
                    print("運勢情報が準備されていないため、ロードをスキップ")
                    isLoading = false // 運勢情報がなければロードを終了
                }
            }
        }
    }

    private func loadLocationData() {
        isLoading = true // ロードを開始
        retryCount = 0 // 初回読み込みのためリトライカウントをリセット
        executeLoadLocationData()
    }

    private func retryLoadLocationData() {
        retryCount += 1
        print("リトライ中: \(retryCount) 回目")
        executeLoadLocationData()
    }

    private func executeLoadLocationData() {
        guard let prefectureName = fortuneAPIManager.prefectureName, !prefectureName.isEmpty else {
            isLoading = false
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
                print("観光地が見つかりませんでした。リトライします。")
                retryLoadLocationData()
            } else {
                isLoading = false
                print("ロード完了またはリトライの上限に達しました。")
            }
        }
    }

    private func handleLocationFetchFailure() {
        DispatchQueue.main.async {
            latitude = nil
            longitude = nil
            if retryCount < maxRetryCount {
                retryLoadLocationData() // 観光地情報が見つからない場合は再検索
            } else {
                isLoading = false // 最大リトライ回数に達した場合はローディングを終了
                print("🐈 緯度と経度が見つからず、リトライ終了")
            }
        }
    }
}
