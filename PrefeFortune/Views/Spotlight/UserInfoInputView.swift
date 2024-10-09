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
    @State private var spotlightEnabled: Bool = true
    @State private var spotlightingID: SpotlightBoundsKey.ID = 1 // スポットライトの最初のターゲット
    let bloodTypes = ["A", "B", "O", "AB"]

    var isFormComplete: Bool {
        return !name.isEmpty
        && !bloodType.isEmpty
    }

    var body: some View {
        NavigationStack {
                VStack(alignment: .leading, spacing: 20) {

                        NameInputField(name: $name)

                        BirthdayInputView(birthday: $birthday)


                        BloodTypePickerView(bloodType: $bloodType, bloodTypes: bloodTypes)
                            .padding(.bottom, -30)


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
                .padding()
                .navigationDestination(isPresented: $navigateToResult) {
                    // 結果ビューに遷移し、必要なデータを渡す
                    FortuneResultView(fortuneAPIManager: fortuneAPIManager)
                }

            .background(
                Color.customRadialGradient
                    .ignoresSafeArea()
            )
        }
    }
}
