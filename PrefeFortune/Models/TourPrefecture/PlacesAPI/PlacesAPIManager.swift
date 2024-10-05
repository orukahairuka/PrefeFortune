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

    //typeをカスタムできるようにしてもよき
    func fetchNearbyPlaces(latitude: Double, longitude: Double, radius: Int = 5000, type: String = "tourist_attraction") {
        let parameters: [String: Any] = [
            "location": "\(latitude),\(longitude)",
            "radius": radius,
            "type": type,
            "keyword": "名所",
            "key": apiKey
        ]

        AF.request(baseURL, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode(PlacesResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.nearbyPlaces = decodedResponse.results
                    }
                } catch {
                    print("デコードエラー: \(error)")
                    DispatchQueue.main.async {
                        self.nearbyPlaces = []
                    }
                }

            case .failure(let error):
                print("エラー: \(error)")
                DispatchQueue.main.async {
                    self.nearbyPlaces = []
                }
            }
        }
    }
}
