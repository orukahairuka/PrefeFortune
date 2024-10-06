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
        GeometryReader { geometry in
            if let validUrl = imageUrl {
                AsyncImageLoadingView(url: validUrl)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.9)
                    .clipped()
            } else {
                PlaceholderView()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.9)
                    .clipped()
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.4)
    }
}

//MARK: - Preview
#Preview {
    PrefectureImageView(imageUrl: URL(string: "https://japan-map.com/wp-content/uploads/hokkaido.png"))
}
