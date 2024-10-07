//
//  NameInputField.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct NameInputField: View {
    @Binding var name: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("名前")
                .font(.headline)
                .foregroundColor(.white)

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    )
                HStack {
                    TextField("名前を入力してください", text: $name)
                        .font(.body)
                        .padding()
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .padding(.horizontal, 30)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
// MARK: - Preview

//#Preview内でStateが使えないためラップビュー追加
struct NameInputFieldPreviewWrapper: View {
    @State var name: String = "テストユーザー"

    var body: some View {
        NameInputField(name: $name)
    }
}

#Preview {
    NameInputFieldPreviewWrapper()
}
