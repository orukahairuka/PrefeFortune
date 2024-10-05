//
//  PlaceholderView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        Text("画像がありません")
            .frame(width: 240, height: 126)
            .foregroundColor(.gray)
    }
}

//MARK: - Preview
#Preview {
    PlaceholderView()
}
