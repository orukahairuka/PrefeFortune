//
//  PlaceImageView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/06.
//

import SwiftUI

struct PlaceImageView: View {
    let photoReference: String?

    var body: some View {
        if let photoReference = photoReference {
            let photoURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference=\(photoReference)&key=AIzaSyAq-cdDFvJSXTIvfVEkBwWMpbAZSoupLh4"

            AsyncImage(url: URL(string: photoURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit) // 画像がフレーム内に収まるように変更
                        .frame(maxWidth: .infinity) // 親ビューの幅に合わせる
                        .frame(height: 250) // 高さを統一して指定
                        .cornerRadius(20)
                        .clipped()
                case .failure:
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                        Text("画像を取得できませんでした")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .background(Color.gray)
                    .cornerRadius(20)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Color.gray
                .frame(maxWidth: .infinity, maxHeight: 250)
                .cornerRadius(20)
                .overlay(
                    Text("画像なし")
                        .foregroundColor(.white)
                        .font(.caption)
                )
        }
    }
}
