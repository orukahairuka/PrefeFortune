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
    @StateObject var fortuneAPIManager: FortuneAPIManager = FortuneAPIManager()
    @StateObject var latLonManager: LatLonManager = LatLonManager()
    private let currentDay = today()
    @StateObject var placesAPIManager: PlacesAPIManager = PlacesAPIManager()

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

                PrefectureImageViewContainer(fortuneAPIManager: fortuneAPIManager)
                TouristCardViewContainer(placesAPIManager: placesAPIManager, latitude: $latitude, longitude: $longitude)

                NameInputField(name: $name)
                BirthdayInputView(birthday: $birthday)
                BloodTypePickerView(bloodType: $bloodType, bloodTypes: bloodTypes)

                Spacer()

                FortuneButton(isFormComplete: isFormComplete) {
                    let birthdayData = birthday
                    let todayData = currentDay
                    fortuneAPIManager.fetchFortune(name: name, birthday: birthdayData, bloodType: bloodType.lowercased(), today: todayData)
                }
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

