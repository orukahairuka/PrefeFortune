//
//  RouteOverlay.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/08.
//

import SwiftUI
import MapKit

struct RouteOverlay: UIViewRepresentable {
    let route: MKRoute  // ルート情報を保持

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator  // コーディネータでオーバーレイを描画する
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // 既存のオーバーレイをすべて削除して新しいルートを描画
        uiView.removeOverlays(uiView.overlays)
        uiView.addOverlay(route.polyline)  // ルートのポリラインをオーバーレイとして追加
    }

    // コーディネータを作成してルートを描画
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .blue  // ルートの色を設定
                renderer.lineWidth = 5.0  // ルートの太さを設定
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}
