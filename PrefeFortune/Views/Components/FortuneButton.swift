//
//  FortuneButton.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct FortuneButton: View {
    let isFormComplete: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            Spacer()
            Button {
                action()
            } label: {
                Text("占う")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 25)
                    .frame(maxWidth: 200)
                    .frame(minWidth: 100)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.customYellowColor)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.9), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 30)
                    .disabled(!isFormComplete)
                    .opacity(isFormComplete ? 0.8 : 0.5)
            }
            Spacer()
        }
        .frame(height: 60)
    }
}
// MARK: - Preview

#Preview {
    FortuneButton(isFormComplete: true) {
        print("占いボタンが押されました")
    }
}
