//
//  ButtonStyleModifier.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/08.
//


import SwiftUI

extension View {
    func ButtonStyleModifier() -> some View {
        self
            .padding()
            .font(.title3)
            .fontWeight(.bold)
            .frame(width: 200, height: 100)
            .background(Color.customYellowColor)
            .foregroundColor(.white)
            .cornerRadius(50)
            .opacity(0.8)
            .shadow(color: .black.opacity(0.3), radius: 10, x: 3, y: 3)
    }
}
