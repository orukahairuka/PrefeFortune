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
        Button {
            action()
        } label: {
            Text("占う")
                .frame(width: 100, height: 100)
                .background(.pink)
                .cornerRadius(15)
        }
        .padding()
        .disabled(!isFormComplete)
    }
}
