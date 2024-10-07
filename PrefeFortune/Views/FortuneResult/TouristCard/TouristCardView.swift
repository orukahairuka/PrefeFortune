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
                ProgressView("Loading nearby places...")
                    .frame(height: 360)
            } else if placesManager.nearbyPlaces.isEmpty {
                Text("No nearby tourist spots found.")
                    .frame(height: 360)
                    .foregroundColor(.gray)
            } else {
                TabView {
                    ForEach(placesManager.nearbyPlaces) { place in
                        TouristCard(place: place)
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 360)
            }
        }
        .onChange(of: latitude) { _ in
            updatePlaces()
        }
        .onChange(of: longitude) { _ in
            updatePlaces()
        }
    }

    private func updatePlaces() {
        if let lat = latitude, let lon = longitude {
            placesManager.fetchNearbyPlaces(latitude: lat, longitude: lon)
        }
    }
}
