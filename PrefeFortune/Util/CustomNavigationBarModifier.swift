//
//  CustomNavigationBarModifier.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/09.
//

import SwiftUI
import CoreLocation

// カスタムナビゲーションバーのViewModifierを作成
struct CustomNavigationBarModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss

    var title: String

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true) // デフォルトの戻るボタンを隠す
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        // カスタム戻るボタン
                        Button(action: {
                            dismiss() // 戻る機能を持つ
                        }) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("戻る")
                            }
                        }
                        .tint(.white) // ボタンの色

                        // カスタムのアクションボタン
                        Button(action: {
                            print("カスタムボタンが押されました")
                        }) {
                            Image(systemName: "star.fill")
                        }
                        .tint(.white) // ボタンの色
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white) // タイトルの色
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("右側のボタンが押されました")
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .tint(.white) // 右側のカスタムボタン
                }
            }
            .toolbarBackground(Color.blue, for: .navigationBar) // ナビゲーションバーの背景色
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

// Viewのextensionにすることで再利用可能に
extension View {
    func customNavigationBar(title: String) -> some View {
        self.modifier(CustomNavigationBarModifier(title: title))
    }
}
