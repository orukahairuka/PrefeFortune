//
//  PrefectureImageView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import SwiftUI

struct PrefectureImageView: View {
    let imageUrl: URL?

    var body: some View {
        Group {
            if let validUrl = imageUrl {
                AsyncImage(url: validUrl) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 240, height: 126)
                            .clipped()
                    case .failure:
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                    case .empty:
                        ProgressView()
                            .frame(width: 240, height: 126)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Text("画像がありません")
                    .frame(width: 240, height: 126)
                    .foregroundColor(.gray)
            }
        }
}

