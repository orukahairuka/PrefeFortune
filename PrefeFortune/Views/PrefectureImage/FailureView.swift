//
//  FailureView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct FailureView: View {
    var body: some View {
        Image(systemName: "exclamationmark.triangle")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(.red)
    }
}


//MARK: - Preview

#Preview("FailureView") {
    FailureView()
}

#Preview ("LoadingView"){
    LoadingView()
}
