//
//  CongratulationView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/09.
//

import SwiftUI

struct CongratulationView: View {
    @ObservedObject var fortuneAPIManager: FortuneAPIManager
    @State private var navigateToResultView = false // 画面遷移用の状態変数

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("あなたと相性のいい都道府県は\n \(fortuneAPIManager.prefectureName ?? "不明な県")！")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()

                    if let logoURL = fortuneAPIManager.decodedLogoURL {
                        PrefectureAnimationView(fortuneAPIManager: fortuneAPIManager)
                    }
                }
                .padding()

                HStack {
                    Text("ボタンを押して、茨城県のおすすめスポットを見てみよう")
                    minCatAnimationView(lottieFile: "minCatAnimation")
                        .frame(width: 100, height: 100)
                }
                .padding()

                Button {
                    // ボタンを押すと遷移フラグをtrueに
                    navigateToResultView = true
                    print("navigatieToResultView: \(navigateToResultView)")
                } label: {
                    Text("おすすめスポットを見る")
                }
                .ButtonStyleModifier()
            }

            ClackerAnimationView(lottieFile: "ClackerAnimation")
                .frame(width: UIScreen.main.bounds.width)
                .frame(height: UIScreen.main.bounds.width * 0.7)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.customPinkColor, Color.customBlueColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
        .navigationDestination(isPresented: $navigateToResultView) {
            FortuneResultView(fortuneAPIManager: fortuneAPIManager)
        }
        .navigationBarBackButtonHidden(true) // Backボタンを非表示
        .ignoresSafeArea()
    }
}

