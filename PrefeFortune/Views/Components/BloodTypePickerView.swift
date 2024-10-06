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
        VStack(alignment: .leading, spacing: 15) {
            VStack {
                Text("血液型を選択してください")
                    .font(.headline)
                    .foregroundColor(.primary)
                Menu {
                    ForEach(bloodTypes, id: \.self) { type in
                        Button(action: {
                            bloodType = type
                        }) {
                            Text(type)
                        }
                    }
                } label: {
                    HStack {
                        Text(bloodType.isEmpty ? "選択してください" : bloodType)
                            .font(.body)
                            .padding()
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 3)
                }
            }
            .padding()
        }
        .padding()
    }
}

// MARK: - Preview
struct BloodTypePickerViewPreviewWrapper: View {
    @State var bloodType: String = ""

    var body: some View {
        BloodTypePickerView(bloodType: $bloodType, bloodTypes: ["A", "B", "O", "AB"])
            .padding()
            .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    BloodTypePickerViewPreviewWrapper()
}
