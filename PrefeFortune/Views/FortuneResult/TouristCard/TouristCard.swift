//
//  TouristCard.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/06.
//

import SwiftUI

struct TouristCard: View {

    let place: Place
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            PlaceImageView(photoReference: place.photoReference)
                .frame(height: 200)

            VStack(alignment: .leading, spacing: 4) {
                // 施設名
                Text(place.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.primary)

                // 住所
                Text(place.vicinity)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                // 評価
                if let rating = place.rating {
                    HStack(spacing: 4) {
                        ForEach(0..<Int(rating.rounded())) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                        Text(String(format: "%.1f", rating))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
    }
}
