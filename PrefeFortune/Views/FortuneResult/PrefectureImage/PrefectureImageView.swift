//
//  PrefectureImageView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import SwiftUI

struct PrefectureImageView: View {
    @Binding var imageUrl: URL?

    var body: some View {
        GeometryReader { geometry in
            if let validUrl = imageUrl {
                ZStack {
                    Text("a")
                        .font(.title)
                        .fontWeight(.bold)
                    AsyncImageLoadingView(url: validUrl)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.9)
                        .clipped()
                    ClackerAnimationView(lottieFile: "ClackerAnimation")
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.4)
    }
}

