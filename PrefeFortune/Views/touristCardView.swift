//
//  touristCardView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//
import SwiftUI

struct TouristCardView: View {
    @StateObject private var placesManager = PlacesAPIManager()

    var body: some View {
        NavigationView {
            List(placesManager.nearbyPlaces) { place in
                VStack(alignment: .leading) {
                    Text(place.name)
                        .font(.headline)
                    Text(place.vicinity)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    if let rating = place.rating {
                        Text("評価: \(String(format: "%.1f", rating)) ⭐️")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 5)
            }
            .navigationTitle("周辺の施設")
            .onAppear {
                // ビューが表示されたときにデータを取得する
                placesManager.fetchNearbyPlaces(latitude: 35.6895, longitude: 139.6917)
            }
        }
    }
}
