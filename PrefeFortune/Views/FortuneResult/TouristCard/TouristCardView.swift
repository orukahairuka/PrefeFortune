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
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal)
            } else if placesManager.nearbyPlaces.isEmpty {
                Text("No nearby tourist spots found.")
                    .frame(height: 360)
                    .foregroundColor(.gray)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0.2, y: 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal)
            } else {
                TabView {
                    ForEach(placesManager.nearbyPlaces) { place in
                        TouristCard(place: place)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 440)
                .padding(.bottom, 10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
