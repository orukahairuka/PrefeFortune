//
//  CongratulationView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/09.
//

import SwiftUI

struct CongratulationView: View {
    @ObservedObject var fortuneAPIManager: FortuneAPIManager

    var body: some View {
        VStack {
            VStack {
                Text("あなたと相性のいい都道府県は \(fortuneAPIManager.prefectureName ?? "不明な県")！")
                    .font(.title2)
                    .fontWeight(.bold)

                if let logoURL = fortuneAPIManager.decodedLogoURL {
                    PrefectureAnimationView(fortuneAPIManager: fortuneAPIManager)
                }
            }
            ZStack {
                Image("PopUpImage2")
                    .resizable()
                    .frame(width: 300, height: 100)
                    .scaledToFit()
                    .scaleEffect(x: -1, y: 1)
                    .opacity(0.9)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 1, y: 1)
                Text("おめでとう")
            }
            minCatAnimationView(lottieFile: "minCatAnimation")
                .frame(width: 100, height: 100)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.customPinkColor, Color.customBlueColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}
