//
//  touristCardView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//
import SwiftUI

struct TouristCardView: View {
    // PlacesAPIManagerのインスタンスを外部から受け取り監視する
    @ObservedObject var placesManager: PlacesAPIManager

    // カードレイアウト用のグリッドアイテム
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(placesManager.nearbyPlaces) { place in
                        VStack(alignment: .leading) {
                            // 画像の表示
                            if let photoReference = place.photoReference {
                                let photoURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoReference)&key=AIzaSyAq-cdDFvJSXTIvfVEkBwWMpbAZSoupLh4"
                                AsyncImage(url: URL(string: photoURL)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(8)
                                        .clipped()
                                } placeholder: {
                                    // プレースホルダーの表示
                                    ProgressView()
                                        .frame(width: 150, height: 150)
                                }
                            }

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
                .padding()
            }
            .navigationTitle("周辺の施設")
            .onAppear {
                // ビューが表示されたときにデータを取得する
                placesManager.fetchNearbyPlaces(latitude: 35.6895, longitude: 139.6917)
            }
        }
    }
}
