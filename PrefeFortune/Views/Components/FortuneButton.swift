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
            }
            .background(.pink)
            .cornerRadius(10)
            .shadow(radius: 3)
            .frame(height: 100)
            .disabled(!isFormComplete)
            Spacer()
        }
    }
}
// MARK: - Preview

#Preview {
    FortuneButton(isFormComplete: true) {
        print("占いボタンが押されました")
    }
}
