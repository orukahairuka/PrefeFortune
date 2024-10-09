//
//  ClackerAnimationView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/07.
//

import SwiftUI
import Lottie

struct ClackerAnimationView: UIViewRepresentable {

    var lottieFile: String
    var loopMode: LottieLoopMode = .playOnce
    var animationView = LottieAnimationView()

    func makeUIView(context: UIViewRepresentableContext<ClackerAnimationView>) -> UIView {
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

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ClackerAnimationView>) {
        animationView.play { (finished) in
            if finished {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    animationView.play { secondFinished in
                    }
                }
            }
        }
    }
}
