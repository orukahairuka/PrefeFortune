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
                .foregroundColor(.white)
                .padding(.bottom, 50)

                DatePicker("選択してください", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                    .onChange(of: selectedDate) { newValue in
                        updateBirthday(from: newValue)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    .foregroundColor(.white)
                    .whiteRoundedModifier()


        }
        .frame(maxWidth: .infinity)
        .padding()
        .onAppear {
            if birthday.year == 0 && birthday.month == 0 && birthday.day == 0 {
                selectedDate = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1)) ?? selectedDate
                updateBirthday(from: selectedDate)
            } else {
                selectedDate = birthday.toDate() ?? selectedDate
            }
        }
    }

    private func updateBirthday(from date: Date) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        birthday.year = components.year ?? 0
        birthday.month = components.month ?? 0
        birthday.day = components.day ?? 0
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
