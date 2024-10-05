//
//  BirthdayInputView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct BirthdayInputView: View {
    @Binding var birthday: YearMonthDay

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("生年月日")
                .font(.headline)
            HStack {
                TextField("年", text: Binding(
                    get: { birthday.year != 0 ? String(birthday.year) : "" },
                    set: { birthday.year = Int($0) ?? 0 }
                ))
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 80)

                TextField("月", text: Binding(
                    get: { birthday.month != 0 ? String(birthday.month) : "" },
                    set: { birthday.month = Int($0) ?? 0 }
                ))
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 50)

                TextField("日", text: Binding(
                    get: { birthday.day != 0 ? String(birthday.day) : "" },
                    set: { birthday.day = Int($0) ?? 0 }
                ))
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 50)
            }
        }
    }
}
