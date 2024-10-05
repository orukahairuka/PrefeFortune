//
//  SearchPrefectureView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct SearchPrefectureView: View {
    @State private var year: Int? = nil
    @State private var month: Int? = nil
    @State private var day: Int? = nil
    @State private var name: String = ""
    @State private var bloodType: String = "A型"

    let bloodTypes = ["A型", "B型", "O型", "AB型"]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // 名前入力フィールド
            Text("名前")
                .font(.headline)
            TextField("名前を入力してください", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)

            // 生年月日入力フィールド
            Text("生年月日")
                .font(.headline)
            HStack {
                TextField("年", text: Binding(
                    get: { year != nil ? String(year!) : "" },
                    set: { year = Int($0) }
                ))
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 80)

                TextField("月", text: Binding(
                    get: { month != nil ? String(month!) : "" },
                    set: { month = Int($0) }
                ))
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 50)

                TextField("日", text: Binding(
                    get: { day != nil ? String(day!) : "" },
                    set: { day = Int($0) }
                ))
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 50)
            }

            // 血液型入力フィールド
            Text("血液型")
                .font(.headline)
            Picker("血液型を選択してください", selection: $bloodType) {
                ForEach(bloodTypes, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Spacer()
        }
        .padding()
    }
}


#Preview {
    SearchPrefectureView()
}
