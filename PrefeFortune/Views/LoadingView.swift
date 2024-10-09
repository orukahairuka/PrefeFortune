//
//  LoadingView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/09.
//

import SwiftUI

struct LanchLoadingView: View {
    var body: some View {
        VStack {
            LoadingAnimationView(lottieFile: "LoadingAnimation")
                .frame(width: 360, height: 330)
            DogAnimationView(lottieFile: "dogAnimation")
                .frame(width: 300, height: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.customRadialGradient
                .ignoresSafeArea()
        )
    }
}

#Preview {
    LanchLoadingView()
}

struct LoadingView: View {
    var body: some View {
        LoadingAnimationView(lottieFile: "LoadingAnimation")
            .frame(width: 100, height: 100)
    }
}
