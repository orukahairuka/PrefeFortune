//
//  MapView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/08.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.6804, longitude: 139.7690),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    // 北海道の座標を指定
    @State private var destination = CLLocationCoordinate2D(latitude: 43.06417, longitude: 141.34694)

    @State private var route: MKRoute?

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
                    calculateRoute(from: userLocation, to: destination)
                }
            } else {
                Text("現在地を取得中...")
                    .frame(height: 400)
            }

            Text("Distance: \(calculateDistance(from: locationManager.userLocation ?? region.center, to: destination)) km")
                .padding()
        }
    }

    // 現在地を中心にしたマップのリージョンを設定
    func regionWithNewCenter(_ center: CLLocationCoordinate2D) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }

    // 2点間の距離を計算
    func calculateDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let fromLocation = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let toLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        let distanceInMeters = fromLocation.distance(from: toLocation)
        let distanceInKilometers = distanceInMeters / 1000
        return distanceInKilometers
    }

    // ルートを計算
    func calculateRoute(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = .automobile  // 車での移動ルートを計算

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

struct MapAnnotationItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

// ルートの描画用オーバーレイ
struct RouteOverlay: UIViewRepresentable {
    let route: MKRoute

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)
        uiView.addOverlay(route.polyline)  // ルートをオーバーレイとして追加
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .blue
                renderer.lineWidth = 5.0
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}
