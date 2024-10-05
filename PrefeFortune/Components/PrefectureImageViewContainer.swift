//
//  PrefectureImageViewContainer.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct PrefectureImageViewContainer: View {
    @ObservedObject var fortuneAPIManager: FortuneAPIManager

    var body: some View {
        PrefectureImageView(imageUrl: fortuneAPIManager.decodedLogoURL)
            .padding(.vertical)
    }
}
// MARK: - Preview
#Preview {
    PrefectureImageViewContainer(fortuneAPIManager: FortuneAPIManager())
}
