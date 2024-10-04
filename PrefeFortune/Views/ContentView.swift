//
//  ContentView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import SwiftUI

struct ContentView: View {
    let fortuneAPIManager: FortuneAPIManager
    let birthday = YearMonthDay(year: 2000, month: 1, day: 27)
    let today = YearMonthDay(year: 2023, month: 5, day: 5)

    var body: some View {
        VStack {
            Text("テスト用")
        }
        .onAppear {
            fortuneAPIManager.fetchFortune(name: "sakurai", birthday: birthday, bloodType: "AB", today: today)
        }
    }
}


