//
//  TouristCardViewContainer.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct TouristCardViewContainer: View {
    @ObservedObject var placesAPIManager: PlacesAPIManager
    @Binding var latitude: Double?
    @Binding var longitude: Double?

    var body: some View {
        TouristCardView(placesManager: placesAPIManager, latitude: $latitude, longitude: $longitude)
            .padding(.vertical)
    }
}
