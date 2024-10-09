//
//  StartNavigatinoView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/09.
//

import SwiftUI

struct StartNavigationView: View {
    @State private var displayedText = "あなたと相性のいい都道府県を占うにゃん"

    // 表示するコメントのリスト
    private let comments = [
         "準備はいい？",
        "次の画面であなたの名前と誕生日,血液型を入力して、占うボタンを押すにゃん",
         "そしたらあなたにぴったりの都道府県を見つけることができるにゃん。",
    ]

    @State private var currentCommentIndex = 0
    @State private var buttonLabel = "Tap"
    @State private var tapCount = 0

    var body: some View {
        VStack {
            ZStack {
                Image("PopUpImage2")
                    .resizable()
                    .frame(width: 360, height: 220)
                    .scaledToFit()
                    .scaleEffect(x: -1, y: 1)
                    .opacity(0.9)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 1, y: 1)

                Text(displayedText)
                    .fontWeight(.bold)
                    .frame(width: 360, height: 210)
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
            }
            .offset(y: 30)

            CatTypeAnimationView(lottieFile: "CatTypeAnimation")
                .frame(width: 400, height: 300)
                .padding(.horizontal, 10)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 1, y: 1)

            Button(action: {
                withAnimation {
                    changeText()
                }
            }) {
                Text(buttonLabel)
                    .padding()
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 200, height: 100)
                    .background(Color.customYellowColor)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }
            .opacity(0.8)
            .padding(.top, 20)
            .shadow(color: .black.opacity(0.3), radius: 10, x: 3, y: 3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.customRadialGradient
                .ignoresSafeArea()
        )
    }

    private func changeText() {
        if currentCommentIndex < comments.count - 1 {
            currentCommentIndex += 1
        } else {
            currentCommentIndex = 0
        }

        displayedText = comments[currentCommentIndex]

        tapCount += 1

        if tapCount == 3 {
            buttonLabel = "OK"
        } else {
            buttonLabel = "Tap"
        }
    }
}

#Preview {
    StartNavigationView()
}
