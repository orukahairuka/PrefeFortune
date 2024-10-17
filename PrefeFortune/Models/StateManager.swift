//
//  StateManager.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/09.
//

import Foundation
import CoreLocation
import SwiftUI
import Alamofire

class StateManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    // 各マネージャーの状態を直接参照
    @ObservedObject var fortuneAPIManager = FortuneAPIManager()
    @ObservedObject var placesAPIManager = PlacesAPIManager()

    @Published var userLocation: CLLocationCoordinate2D?
    @Published var isLocationLoading: Bool = false

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        setupLocationManager()
    }

    // MARK: - Location Management
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        isLocationLoading = true
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
            self.isLocationLoading = false
        }
    }

    // MARK: - 状態の直接利用

    func fetchFortune(name: String, birthday: YearMonthDay, bloodType: String, today: YearMonthDay) async {
        await fortuneAPIManager.fetchFortune(name: name, birthday: birthday, bloodType: bloodType, today: today)
    }

    func fetchNearbyPlaces() {
        if let userLocation = userLocation {
            Task {
                await placesAPIManager.fetchNearbyPlaces(latitude: userLocation.latitude, longitude: userLocation.longitude)
            }
        }
    }
}
