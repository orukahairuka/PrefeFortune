//
//  SearchPrefectureView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct UserInfoInputView: View {
    @State private var birthday = YearMonthDay(year: 0, month: 0, day: 0)
    @State private var name: String = ""
    @State private var bloodType: String = "A"
    @StateObject var fortuneAPIManager: FortuneAPIManager = FortuneAPIManager()
    private let currentDay = today()

    @State private var navigateToResult: Bool = false
    let bloodTypes = ["A", "B", "O", "AB"]

    var isFormComplete: Bool {
        return !name.isEmpty
        && (birthday.year > 0 && birthday.month > 0 && birthday.day > 0)
        && !bloodType.isEmpty
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    CatTypeAnimationView(lottieFile: "CatTypeAnimation")
                        .frame(width: 270, height: 270)
                        .padding(.horizontal, 10)
                    NameInputField(name: $name)
                    BirthdayInputView(birthday: $birthday)
                    BloodTypePickerView(bloodType: $bloodType, bloodTypes: bloodTypes)
                    Spacer()
                    FortuneButton(isFormComplete: isFormComplete) {
                        Task {
                            await fortuneAPIManager.fetchFortune(
                                name: name,
                                birthday: birthday,
                                bloodType: bloodType.lowercased(),
                                today: currentDay
                            )

                            // 運勢情報の取得が完了したら発火
                            DispatchQueue.main.async {
                                navigateToResult = true
                            }
                        }
                    }
                }
                .padding()
                .navigationDestination(isPresented: $navigateToResult) {
                    // 結果ビューに遷移し、必要なデータを渡す
                    FortuneResultView(fortuneAPIManager: fortuneAPIManager)
                }
            }
        }
    }
}

