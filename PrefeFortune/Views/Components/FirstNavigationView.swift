//
//  FirstNavigationView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/08.
//

import SwiftUI

struct FirstNavigationView: View {
    @Binding var distance: Double
    @Binding var prefectureName: String
    var body: some View {
        VStack {
            ZStack {
                Image("PopUpImage2")
                    .resizable()
                    .frame(width: 360, height: 220)
                    .scaledToFit()
                    .scaleEffect(x: -1, y: 1)
                CatTravelText(distance: distance, prefectureName: prefectureName)
                    .foregroundColor(Color.black)
                    .frame(width: 360, height: 210)
            }
                .offset(y: 30)
            CatTypeAnimationView(lottieFile: "CatTypeAnimation")
                .frame(width:400, height: 300)
                .padding(.horizontal, 10)
                .spotlightAnchor(at: 1)
        }
    }
}



struct CatTravelText: View {
    var distance: Double
    var prefectureName: String

    var body: some View {
        Text(catTravelAdvice(for: distance, prefectureName: prefectureName))
            .font(.title3)
            .fontDesign(.monospaced)
            .padding()
    }

    func catTravelAdvice(for distance: Double, prefectureName: String) -> String {
        switch distance {
        case 0..<150:
            return "\(prefectureName)まで\(String(format: "%.2f", distance)) kmあるにゃん！実は、上のラッキースポットのカードを押すとスポットの検索ができるにゃん。面白そうな場所だね"
        case 150..<500:
            return "\(prefectureName)まで\(String(format: "%.2f", distance))kmかかるにゃん!少し時間がかかるけど、面白そうな場所がたくさんあるね！上のラッキースポットのカードを押して調べてみてネ"
        case 500..<700:
            return "\(prefectureName)まで\(String(format: "%.2f", distance))kmかかるにゃん！遠いけど、面白そうな場所がたくさんあるよ！上のラッキースポットのカードを押して調べてみてネ"
        case 700...:
            return "ふにゃ〜！\(prefectureName)まで\(String(format: "%.2f", distance))kmかかるにゃ。だいぶ遠いにゃ〜。けど、面白そうな場所がたくさんあるよ。上のラッキースポットのカードを押して調べてみてネ"
        default:
            return "ごめんね。距離がわからなかったにゃん"
        }
    }
}
