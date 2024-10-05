//
//  BloodTypePickerView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct BloodTypePickerView: View {
    @Binding var bloodType: String
    let bloodTypes: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("血液型")
                .font(.headline)
            Picker("血液型を選択してください", selection: $bloodType) {
                ForEach(bloodTypes, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}
// MARK: - Preview

//#Preview内でStateが使えないためラップビュー追加
struct BloodTypePickerViewPreviewWrapper: View {
    @State var bloodType: String = "A"

    var body: some View {
        BloodTypePickerView(bloodType: $bloodType, bloodTypes: ["A", "B", "O", "AB"])
    }
}

#Preview {
    BloodTypePickerViewPreviewWrapper()
}
