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
                AsyncImageLoadingView(url: validUrl)
            } else {
                PlaceholderView()
            }
        }
    }
}

