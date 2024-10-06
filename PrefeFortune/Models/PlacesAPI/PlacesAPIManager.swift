//
//  PlacesAPIManager.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//
import Foundation
import Alamofire

class PlacesAPIManager: ObservableObject {
    private let apiKey = "AIzaSyAq-cdDFvJSXTIvfVEkBwWMpbAZSoupLh4"
    private let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"

    @Published var nearbyPlaces: [Place] = []

    /// 指定した位置の近隣の施設を取得
    func fetchNearbyPlaces(latitude: Double, longitude: Double, radius: Int = 5000, type: String = "tourist_attraction") {
        let parameters = createRequestParameters(latitude: latitude, longitude: longitude, radius: radius, type: type)

        // APIリクエスト
        AF.request(baseURL, parameters: parameters).responseData { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let data):
                self.handleSuccessResponse(data)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }

    // MARK: - Private Methods

    /// リクエストパラメータを生成
    private func createRequestParameters(latitude: Double, longitude: Double, radius: Int, type: String) -> [String: Any] {
        return [
            "location": "\(latitude),\(longitude)",
            "radius": radius,
            "type": type,
            "keyword": "名所",
            "key": apiKey
        ]
    }

    /// 成功レスポンスを処理
    private func handleSuccessResponse(_ data: Data) {
        do {
            let decodedResponse = try JSONDecoder().decode(PlacesResponse.self, from: data)
            DispatchQueue.main.async {
                self.nearbyPlaces = decodedResponse.results
            }
        } catch {
            print("デコードエラー: \(error)")
            updateNearbyPlaces(with: [])
        }
    }

    /// 失敗レスポンスを処理
    private func handleFailureResponse(_ error: AFError) {
        print("ネットワークエラー: \(error)")
        updateNearbyPlaces(with: [])
    }

    /// NearbyPlacesの更新
    private func updateNearbyPlaces(with places: [Place]) {
        DispatchQueue.main.async {
            self.nearbyPlaces = places
        }
    }
}
