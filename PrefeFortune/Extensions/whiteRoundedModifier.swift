//
//  ButtonStyleModifier.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/08.
//


import SwiftUI

extension View {
    func whiteRoundedModifier() -> some View {
        self
            .padding(10)
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
