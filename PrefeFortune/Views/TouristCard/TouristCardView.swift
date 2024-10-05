//
//  touristCardView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//
import SwiftUI

struct TouristCardView: View {
    @ObservedObject var placesManager: PlacesAPIManager
    @Binding var latitude: Double?
    @Binding var longitude: Double?

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ScrollView (.horizontal, showsIndicators: false){
            LazyHStack(spacing: 16) {
                ForEach(placesManager.nearbyPlaces) { place in
                    TouristCard(place: place)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .padding(.vertical, 8)
                }
            }
            .padding()
            .onAppear {
                // TouristCardViewが表示されたときに観光地のデータを更新
                if let lat = latitude, let lon = longitude {
                    placesManager.fetchNearbyPlaces(latitude: lat, longitude: lon)
                }
            }
        }
        .frame(height: 300) // 4. スクロールビュー全体の高さを設定
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) // 5. ページング風の表示（必要ならTabViewで包んで実現することも可能）
    }
}

