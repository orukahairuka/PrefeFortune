//
//  ContentView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var fortuneManager = FortuneAPIManager()

    var body: some View {
        VStack {
            
            if fortuneManager.isLoading {
                ProgressView()
            } else if let fortune = fortuneManager.fortuneResponse {
                VStack(alignment: .leading) {
                    Text("名前: \(fortune.name)")
                    Text("都市: \(fortune.capital)")
                    if let citizenDay = fortune.citizenDay {
                        Text("zitizenDay: \(citizenDay.month)/\(citizenDay.day)")
                    }
                    Text("詳細: \(fortune.brief)")
                }
                .padding()
            }

            Button(action: {
                fortuneManager.fetchFortune(
                    name: "ゆめみ",
                    birthday: YearMonthDay(year: 2000, month: 1, day: 27),
                    bloodType: "ab",
                    today: YearMonthDay(year: 2023, month: 5, day: 5)
                )
            }) {
                Text("占う")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(fortuneManager.isLoading)
        }
    }
}


