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
                if isFormComplete {
                    action()
                }
            } label: {
                Text("占う")
                    .ButtonStyleModifier()
            }
            .disabled(!isFormComplete)
            .opacity(isFormComplete ? 0.8 : 0.5)
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
