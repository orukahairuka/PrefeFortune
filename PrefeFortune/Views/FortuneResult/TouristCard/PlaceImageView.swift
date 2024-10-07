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
            let photoURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoReference)&key=AIzaSyAq-cdDFvJSXTIvfVEkBwWMpbAZSoupLh4"

            AsyncImage(url: URL(string: photoURL)) { phase in
                switch phase {
                case .empty:
                    // ロード中の表示
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .success(let image):
                    // 画像が正常にロードされた場合の表示
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                        .cornerRadius(16)
                        .clipped()
                case .failure:
                    // エラーが発生した場合の表示
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                        Text("画像を取得できませんでした")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                    .background(Color.gray)
                    .cornerRadius(16)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            // photoReferenceがない場合のプレースホルダー
            Color.gray
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                .cornerRadius(16)
                .overlay(
                    Text("画像なし")
                        .foregroundColor(.white)
                        .font(.caption)
                )
        }
    }
}
