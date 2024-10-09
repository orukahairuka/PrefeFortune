//
//  SpotlightModifier.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/08.
//

import SwiftUI

struct SpotlightModifier: ViewModifier {
    @Binding var enable: Bool
    @Binding var spotlightingID: SpotlightBoundsKey.ID

    func body(content: Content) -> some View {
        content
            .overlayPreferenceValue(SpotlightBoundsKey.self) { values in
                GeometryReader { proxy in
                    if let preference = values.first(where: { $0.key == spotlightingID }) {
                        let rect = proxy[preference.value]
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .dark)
                            .opacity(enable ? 0.7 : 0)
                            .reverseMask(alignment: .topLeading) { // 修正された reverseMask を適用
                                RoundedRectangle(cornerRadius: 8)
                            }
                            .onTapGesture {
                                if spotlightingID < 3 {
                                    spotlightingID += 1
                                } else {
                                    enable = false
                                }
                            }
                    }
                }
                .ignoresSafeArea()
                .animation(.easeInOut, value: enable)
                .animation(.easeInOut, value: spotlightingID)
            }
    }
}
