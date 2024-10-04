//
//  PrefectureImageView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import SwiftUI

struct PrefectureImageView: View {
    let imageUrl = URL(string: "https://japan-map.com/wp-content/uploads/okinawa.png")

        var body: some View {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 240, height: 126)
        }
}

#Preview {
    PrefectureImageView()
}
