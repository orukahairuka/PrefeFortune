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

    var body: some View {
        VStack {
            if placesManager.isLoading {
                LoadingView()
                    .frame(height: 360)
            } else if placesManager.nearbyPlaces.isEmpty {
                MessageView(message: "No nearby tourist spots found.")
                    .frame(height: 360)
            } else {
                TouristPlacesTabView(places: placesManager.nearbyPlaces)
                    .frame(height: 440)
                    .padding(.bottom, 10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: latitude) { _ in updatePlaces() }
        .onChange(of: longitude) { _ in updatePlaces() }
    }

    private func updatePlaces() {
        if let lat = latitude, let lon = longitude {
            placesManager.fetchNearbyPlaces(latitude: lat, longitude: lon)
        }
    }
}

struct MessageView: View {
    let message: String

    var body: some View {
        Text(message)
            .foregroundColor(.gray)
            .whiteRoundedModifier()
    }
}

struct TouristPlacesTabView: View {
    let places: [Place]

    var body: some View {
        TabView {
            ForEach(places) { place in
                TouristCard(place: place)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

