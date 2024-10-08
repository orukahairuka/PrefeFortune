//
//  SpotlightBoundsKey.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/08.
//

import SwiftUI

struct SpotlightBoundsKey: PreferenceKey {
    typealias ID = Int
    static var defaultValue: [ID: Anchor<CGRect>] = [:]

    static func reduce(value: inout [ID: Anchor<CGRect>], nextValue: () -> [ID: Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}

extension View {
    func spotlightAnchor(at id: SpotlightBoundsKey.ID) -> some View {
        self.anchorPreference(key: SpotlightBoundsKey.self, value: .bounds) { [id: $0] }
    }
}

extension View {
    func reverseMask<Content: View>(alignment: Alignment = .center, @ViewBuilder content: () -> Content) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    content()
                        .blendMode(.destinationOut)
                }
        }
    }
}
