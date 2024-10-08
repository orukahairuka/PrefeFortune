//
//  MapView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/08.
//

import SwiftUI
import MapKit
import CoreLocation

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var locationManager = LocationManager()  // 現在地を管理

    // デフォルトの地域（初期値として東京駅を設定）
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.6804, longitude: 139.7690),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    // 緯度と経度を親ビューからバインディングで受け取る
    @Binding var latitude: Double
    @Binding var longitude: Double

    // バインディングされた値から目的地の座標を設定
    @State private var destination: CLLocationCoordinate2D

    @State private var route: MKRoute?  // ルートを格納

    init(latitude: Binding<Double>, longitude: Binding<Double>) {
        self._latitude = latitude
        self._longitude = longitude
        self._destination = State(initialValue: CLLocationCoordinate2D(latitude: latitude.wrappedValue, longitude: longitude.wrappedValue))
    }

    var body: some View {
        VStack {
            if let userLocation = locationManager.userLocation {
                Map(coordinateRegion: Binding(
                        get: { regionWithNewCenter(userLocation) },
                        set: { region = $0 }
                ),
                annotationItems: [MapAnnotationItem(coordinate: userLocation), MapAnnotationItem(coordinate: destination)]) { item in
                    MapPin(coordinate: item.coordinate, tint: .blue)
                }
                .overlay(
                    route != nil ? AnyView(RouteOverlay(route: route!)) : AnyView(EmptyView())
                )
                .frame(height: 400)
                .onAppear {
                    calculateRoute(from: userLocation, to: destination)  // ルート計算
                }
            } else {
                Text("現在地を取得中...")
                    .frame(height: 400)
            }

            Text("Distance: \(calculateDistance(from: locationManager.userLocation ?? region.center, to: destination)) km")
                .padding()
        }
    }

    func regionWithNewCenter(_ center: CLLocationCoordinate2D) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }

    func calculateDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let fromLocation = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let toLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        let distanceInMeters = fromLocation.distance(from: toLocation)
        let distanceInKilometers = distanceInMeters / 1000
        return distanceInKilometers
    }

    func calculateRoute(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = .automobile  // 車でのルートを計算

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else {
                print("ルートの計算に失敗しました: \(error?.localizedDescription ?? "不明なエラー")")
                return
            }
            self.route = route
        }
    }
}
