//
//  SearchPrefectureView.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/05.
//

import SwiftUI

struct SearchPrefectureView: View {
    @State private var birthday = YearMonthDay(year: 0, month: 0, day: 0)
    @State private var name: String = ""
    @State private var bloodType: String = "A型"
    @State private var latitude: Double? = nil
    @State private var longitude: Double? = nil
    @StateObject var fortuneAPIManager: FortuneAPIManager
    @StateObject var latLonManager: LatLonManager
    private let currentDay = today()
    @StateObject var placesAPIManager: PlacesAPIManager
    @State private var decodedLogoURL: URL?

    var isFormComplete: Bool {
        return !name.isEmpty
        && birthday.year != 0
        && birthday.month != 0
        && birthday.day != 0
        && bloodTypes.contains(bloodType)
    }

    let bloodTypes = ["A", "B", "O", "AB"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                PrefectureImageView(imageUrl: fortuneAPIManager.decodedLogoURL)
                Spacer()
                TouristCardView(placesManager: placesAPIManager, latitude: $latitude, longitude: $longitude)

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
                        get: { birthday.year != 0 ? String(birthday.year) : "" },
                        set: { birthday.year = Int($0) ?? 0 }
                    ))
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 80)

                    TextField("月", text: Binding(
                        get: { birthday.month != 0 ? String(birthday.month) : "" },
                        set: { birthday.month = Int($0) ?? 0 }
                    ))
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 50)

                    TextField("日", text: Binding(
                        get: { birthday.day != 0 ? String(birthday.day) : "" },
                        set: { birthday.day = Int($0) ?? 0 }
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
                Button {
                    if isFormComplete {
                        let birthdayData = birthday
                        let todayData = currentDay
                        fortuneAPIManager.fetchFortune(name: name, birthday: birthdayData, bloodType: bloodType.lowercased(), today: todayData)
                    }
                } label: {
                    Text("占う")
                        .frame(width: 100, height: 100)
                        .background(.pink)
                        .cornerRadius(15)
                }
                .padding()
                .disabled(!isFormComplete)
            }
            .padding()
            .onChange(of: fortuneAPIManager.prefectureName) { newName in
                guard let prefectureName = newName else {
                    latitude = nil
                    longitude = nil
                    print("無理でした")
                    return
                }
                
                if let location = latLonManager.getLatLon(forPrefecture: prefectureName) {
                    latitude = location.latitude
                    longitude = location.longitude
                    print("\(prefectureName)のlatitude: \(latitude!), longitude: \(longitude!)")
                } else {
                    latitude = nil
                    longitude = nil
                    print("無理でした")
                }
            }
        }
    }
}


