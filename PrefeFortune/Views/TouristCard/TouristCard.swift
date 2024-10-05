//
//  TouristCard.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/06.
//

import SwiftUI

struct TouristCard: View {
    let place: Place // Placeはモデルオブジェクトを想定しています

    var body: some View {
        VStack(alignment: .leading) {
            // 画像の表示
            PlaceImageView(photoReference: place.photoReference)

            // 施設名
            Text(place.name)
                .font(.headline)
                .lineLimit(1)

            // 住所
            Text(place.vicinity)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)

            // 評価
            if let rating = place.rating {
                Text("評価: \(String(format: "%.1f", rating)) ⭐️")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
