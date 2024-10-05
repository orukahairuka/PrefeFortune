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
        VStack(alignment: .leading, spacing: 5) {
            Text("名前")
                .font(.headline)
            TextField("名前を入力してください", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
        }
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
