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
                    .frame(width: 350, height: 200)
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
        case 0..<60:
            return "にゃん！\(prefectureName)は近いにゃ！電車でピューっと30分で行けるにゃ〜。"
        case 60..<150:
            return "\(prefectureName)まで新幹線で30分くらいかかるにゃん。もう少し時間かけたいなら、特急や車でも2時間くらいにゃ！"
        case 150..<500:
            return "東京まで新幹線なら2時間半くらいかかるにゃ！飛行機もあるけど、車なら6〜7時間かかるにゃ。夜行バスでのんびりもアリ。"
        case 500..<700:
            return "\(prefectureName)は新幹線で4時間くらいにゃ。飛行機だと1時間半くらいでビューンだ！車なら10時間かかるから、慎重に考えてネ。"
        case 700...:
            return "ふにゃ〜！\(prefectureName)は遠いにゃ〜。飛行機で2時間が一番楽だにゃ。新幹線で行くなら10時間くらい。車は20時間もかかるからやめたほうがいいヨ。"
        default:
            return "ごめんね。距離がわからなかったにゃん"
        }
    }
}
