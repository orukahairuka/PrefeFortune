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
    let zoomOutFactor: Double = 1.2  // 余裕を持たせるズームアウトの倍率

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator  // コーディネータでオーバーレイを描画する
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // 既存のオーバーレイをすべて削除して新しいルートを描画
        uiView.removeOverlays(uiView.overlays)
        uiView.addOverlay(route.polyline)  // ルートのポリラインをオーバーレイとして追加

        // バウンディング矩形を取得
        let boundingRect = route.polyline.boundingMapRect

        // ズームアウト用に矩形を拡大（マージンを追加）
        let adjustedRect = boundingRect.insetBy(dx: -boundingRect.size.width * (zoomOutFactor - 1),
                                                dy: -boundingRect.size.height * (zoomOutFactor - 1))

        // 拡大した矩形を座標領域に変換して地図を設定
        let region = MKCoordinateRegion(adjustedRect)
        uiView.setRegion(region, animated: true)  // 地図をズーム
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
