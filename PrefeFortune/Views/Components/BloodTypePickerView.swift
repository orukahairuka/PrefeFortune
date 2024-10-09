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
            Text("血液型を選択してね")
                .font(.headline)
                .foregroundColor(.white)
            HStack {
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
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding(.horizontal)
                }
            }
            .whiteRoundedModifier()
            .padding()
        }
        .frame(maxWidth: .infinity)
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
