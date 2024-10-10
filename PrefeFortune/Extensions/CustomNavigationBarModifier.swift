//
//  CustomNavigationBarModifier.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/09.
//

import SwiftUI
import CoreLocation

struct CustomNavigationBarModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss
    @State private var navigateToUserInfoInput = false

    func body(content: Content) -> some View {
        ZStack {
            Color.clear
                .background(
                    Color.customRadialGradient
                        .ignoresSafeArea(edges: .top)
                )

            content
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            // カスタム戻るボタン
                            Button(action: {
                                dismiss()
                            }) {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                    Text("戻る")
                                }
                            }
                            .tint(Color.customTextColor)
                        }
                    }

                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            navigateToUserInfoInput = true
                        } label: {
                            Text("もう一度占う")
                                .foregroundStyle(Color.customTextColor)
                                .whiteRoundedModifier()
                        }
                    }

                }
                .navigationDestination(isPresented: $navigateToUserInfoInput) {
                    UserInfoInputView()
                }
        }
    }
}

extension View {
    func customNavigationBar() -> some View {
        self.modifier(CustomNavigationBarModifier())
    }
}
