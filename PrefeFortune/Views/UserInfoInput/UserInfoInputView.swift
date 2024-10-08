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
    @State private var navigateToResult: Bool = false
    @State private var spotlightEnabled: Bool = true
    //fortuneAPIが初期化されるからStateObjectを使用
    @StateObject var fortuneAPIManager: FortuneAPIManager = FortuneAPIManager()
    private let currentDay = today()

    let bloodTypes = ["A", "B", "O", "AB"]

    var isFormComplete: Bool {
        return !name.isEmpty
        && !bloodType.isEmpty
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    NameInputField(name: $name)

                    BirthdayInputView(birthday: $birthday)

                    BloodTypePickerView(bloodType: $bloodType, bloodTypes: bloodTypes)

                    Spacer()

                    FortuneButton(isFormComplete: isFormComplete) {
                        if isFormComplete {
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
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .scrollIndicators(.hidden)
            .navigationDestination(isPresented: $navigateToResult) {
                ResultCongratulationView(fortuneAPIManager: fortuneAPIManager)
            }
            .background(
                Color.customRadialGradient
                    .ignoresSafeArea()
            )
        }
    }
}
