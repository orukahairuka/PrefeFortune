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
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(placesManager.nearbyPlaces) { place in
                    TouristCard(place: place)
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
    }
}

