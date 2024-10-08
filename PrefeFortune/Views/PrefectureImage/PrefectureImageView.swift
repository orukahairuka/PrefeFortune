//
//  PrefectureImageView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import SwiftUI

struct PrefectureImageView: View {
    @Binding var imageUrl: URL?
    @Binding var prefectureName: String?

    var body: some View {
        GeometryReader { geometry in
            if let validUrl = imageUrl {
                ZStack {
                    VStack {
                        if let name = prefectureName {
                            Text(name)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        AsyncImageLoadingView(url: validUrl)
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.7)
                            .clipped()
                    }
                    ClackerAnimationView(lottieFile: "ClackerAnimation")
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.4)
    }
}

