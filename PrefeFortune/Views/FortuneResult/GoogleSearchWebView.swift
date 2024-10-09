//
//  GoogleSearchWebView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/08.
//

import SwiftUI
import WebKit

struct GoogleSearchWebView: UIViewRepresentable {
    let query: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()

        if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let urlString = "https://www.google.com/search?q=\(encodedQuery)"
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        print("🐶")
    }
}

