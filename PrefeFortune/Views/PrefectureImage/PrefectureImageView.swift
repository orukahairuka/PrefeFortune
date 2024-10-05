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
        if let validUrl = imageUrl {
            AsyncImageLoadingView(url: validUrl)
        } else {
            PlaceholderView()
        }
    }
}

//MARK: - Preview
#Preview {
    PrefectureImageView(imageUrl: URL(string: "https://japan-map.com/wp-content/uploads/toyama.png"))
}
