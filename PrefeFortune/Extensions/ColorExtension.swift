//
//  ColorExtension.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/07.
//

import SwiftUI

extension Color {
    static let customPinkColor = Color("PinkColor")
    static let customBlueColor = Color("BlueColor")

    static var customGradient: LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [customPinkColor, customBlueColor]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    static var customRadialGradient: RadialGradient {
        return RadialGradient(
            gradient: Gradient(colors: [customPinkColor, customBlueColor]),
            center: .center,
            startRadius: 5,
            endRadius: 500
        )
    }
}
