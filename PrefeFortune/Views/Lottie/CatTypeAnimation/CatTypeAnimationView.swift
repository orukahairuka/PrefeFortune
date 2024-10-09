//
//  CatTypeAnimationView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/07.
//

import SwiftUI
import Lottie

struct CatTypeAnimationView: UIViewRepresentable {

    var lottieFile: String
    var loopMode: LottieLoopMode = .loop
    var animationView = LottieAnimationView()

    func makeUIView(context: UIViewRepresentableContext<CatTypeAnimationView>) -> UIView {
        let view = UIView()

        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = loopMode

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        // アニメーションを初回表示時に再生する
        animationView.play()

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<CatTypeAnimationView>) {
        // アニメーションを必要に応じて再生
        animationView.play()
    }
}
