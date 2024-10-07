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
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .clipped()

            VStack(alignment: .leading, spacing: 4) {
                // 施設名
                Text(place.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.white)

                // 住所
                Text(place.vicinity)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(2)

                // 評価
                if let rating = place.rating {
                    HStack(spacing: 4) {
                        ForEach(0..<Int(rating.rounded()), id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                        Text(String(format: "%.1f", rating))
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
        .frame(width: UIScreen.main.bounds.width * 0.85)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                )
        )
        .padding(.horizontal, 10)
    }
}
