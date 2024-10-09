//
//  ResultCongratulateView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/09.
//

import SwiftUI

import SwiftUI

struct PrefectureAnimationView: View {
    @ObservedObject var fortuneAPIManager: FortuneAPIManager
    @State private var isAnimating = false
    @State private var rotationAngle: Double = 0

    var body: some View {
        if let logoURL = fortuneAPIManager.decodedLogoURL {
            ZStack {
                PrefectureImageView(imageUrl: .constant(logoURL), prefectureName: $fortuneAPIManager.prefectureName)
                    .whiteRounded()
                    .padding(.horizontal, 30)
                    // X軸方向に回転（奥に向かって回る感じ）
                    .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
                    .onAppear {
                        isAnimating = true
                        // アニメーションの開始
                        withAnimation(.linear(duration: 0.5)) {
                            rotationAngle = 720 // 最初は0.5秒で速く2回転
                        }
                        // 0.5秒後に減速しつつ停止
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.spring(response: 1.5, dampingFraction: 0.5, blendDuration: 0.5)) {
                                rotationAngle = 1080 // 合計で3回転して、自然に止まる
                            }
                        }
                    }
            }
        }
    }
}


