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

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    )

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
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .padding(.horizontal, 30)
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
