//
//  LoadingView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/09.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.customRadialGradient
                .ignoresSafeArea()
        )
    }
}

#Preview {
    LoadingView()
}
