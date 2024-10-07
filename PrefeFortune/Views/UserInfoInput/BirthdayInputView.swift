//
//  BirthdayInputView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct BirthdayInputView: View {
    @Binding var birthday: YearMonthDay


    @State private var selectedDate: Date = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1)) ?? Date()
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("あなたの誕生日を入れてね")
                .font(.headline)

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.systemGray6))
                    .shadow(radius: 2)
                DatePicker("選択してください", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                    .onChange(of: selectedDate) { newValue in
                        updateBirthday(from: newValue)
                    }
                    .padding()
            }
        }
        .onAppear {
            if birthday.year == 0 && birthday.month == 0 && birthday.day == 0 {
                selectedDate = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1)) ?? selectedDate
            } else {
                selectedDate = birthday.toDate() ?? selectedDate
            }
        }
        .padding(.horizontal, 30)
    }

    private func updateBirthday(from date: Date) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        birthday.year = components.year ?? 0
        birthday.month = components.month ?? 0
        birthday.day = components.day ?? 0
    }
}

// YearMonthDayからDateに変換する拡張機能
extension YearMonthDay {
    func toDate() -> Date? {
        var components = DateComponents()
        components.year = year != 0 ? year : nil
        components.month = month != 0 ? month : nil
        components.day = day != 0 ? day : nil
        return Calendar.current.date(from: components)
    }
}

// MARK: - Preview

//#Preview内でStateが使えないためラップビュー追加
struct BirthdayInputViewPreviewWrapper: View {
    @State var birthday = YearMonthDay(year: 1990, month: 1, day: 1)
    
    var body: some View {
        BirthdayInputView(birthday: $birthday)
    }
}

#Preview {
    BirthdayInputViewPreviewWrapper()
}
