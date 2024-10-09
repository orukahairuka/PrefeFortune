//
//  RoudedBackground.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/08.
//

//白いすけた透明部分のフレーム

import SwiftUI

extension View {
    func whiteRounded() -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    )
            )
            .frame(maxWidth: .infinity)
    }
}
