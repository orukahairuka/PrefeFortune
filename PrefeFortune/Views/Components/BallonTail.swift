//
//  BallonTail.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/08.
//

import SwiftUI

struct BalloonView: View {
    var body: some View {
        ZStack {
            // 吹き出し本体部分
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .frame(width: 200, height: 100)
                .overlay(
                    Text("吹き出しテキスト")
                        .foregroundColor(.white)
                        .padding(),
                    alignment: .center
                )

            // 吹き出しのしっぽ部分
            BalloonTail()
                .fill(Color.blue)
                .frame(width: 30, height: 30)
                .offset(x: 0, y: 55)
        }
    }
}

// 吹き出しのしっぽ部分を描画
struct BalloonTail: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct BalloonView_Previews: PreviewProvider {
    static var previews: some View {
        BalloonView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
