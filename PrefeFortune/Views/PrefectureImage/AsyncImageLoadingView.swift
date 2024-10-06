//
//  AsyncImageLoadingView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct AsyncImageLoadingView: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            case .failure:
                FailureView()
                    .clipped()
            case .empty:
                LoadingView()
                    .clipped()
            @unknown default:
                EmptyView()
            }
        }
    }
}

//MARK: - Preview
#Preview {
    AsyncImageLoadingView(url: URL(string: "https://japan-map.com/wp-content/uploads/toyama.png"))
}
