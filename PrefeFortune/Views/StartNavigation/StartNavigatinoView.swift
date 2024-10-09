//
//  StartNavigatinoView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/09.
//

import SwiftUI

struct StartNavigationView: View {
    @State private var displayedText = "あなたと相性のいい都道府県を占うにゃん"
    private let tutorialSteps = [
        "準備はいい？",
        "次の画面であなたの名前と誕生日,血液型を入力して、占うボタンを押すにゃん",
        "そしたらあなたにぴったりの都道府県を見つけることができるにゃん。",
    ]
    @State private var currentStepIndex = 0
    @State private var buttonText = "Tap"
    @State private var tapCount = 1
    @State private var isInputViewActive = false
    @AppStorage("hasSeenTutorial") private var hasSeenTutorial: Bool = false

    var body: some View {
        if !hasSeenTutorial {
            NavigationStack {
                VStack {
                    tutorialImage
                    CatTypeAnimationView(lottieFile: "CatTypeAnimation")
                        .frame(width: 400, height: 300)
                        .padding(.horizontal, 10)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 1, y: 1)

                    actionButton
                        .padding(.top, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color.customRadialGradient
                        .ignoresSafeArea()
                )
                .navigationDestination(isPresented: $isInputViewActive) {
                    UserInfoInputView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EmptyView()
                    }
                }
            }
        } else {
            UserInfoInputView()
        }
    }

    private var tutorialImage: some View {
        ZStack {
            Image("PopUpImage2")
                .resizable()
                .frame(width: 360, height: 220)
                .scaledToFit()
                .scaleEffect(x: -1, y: 1)
                .opacity(0.9)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 1, y: 1)

            Text(displayedText)
                .foregroundStyle(Color.black)
                .fontWeight(.bold)
                .frame(width: 360, height: 210)
                .multilineTextAlignment(.center)
                .transition(.opacity)
        }
        .offset(y: 30)
    }

    private var actionButton: some View {
        Button {
            withAnimation {
                handleButtonTap()
            }
        }label: {
            Text(buttonText)
        }
        .ButtonStyleModifier()
    }

    private func handleButtonTap() {
        if tapCount < 3 {
            updateDisplayedText()
        }

        tapCount += 1

        if tapCount == 3 {
            buttonText = "OK"
        } else if tapCount == 4 {
            navigateToInputView()
        }
    }

    private func updateDisplayedText() {
        currentStepIndex = (currentStepIndex + 1) % tutorialSteps.count
        displayedText = tutorialSteps[currentStepIndex]
    }

    private func navigateToInputView() {
        isInputViewActive = true
        hasSeenTutorial = true
    }
}
