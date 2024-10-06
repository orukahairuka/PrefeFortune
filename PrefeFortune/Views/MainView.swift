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
    @State private var bloodType: String = "A"
    @State private var latitude: Double? = nil
    @State private var longitude: Double? = nil
    @StateObject var fortuneAPIManager: FortuneAPIManager = FortuneAPIManager()
    @StateObject var latLonManager: LatLonManager = LatLonManager()
    private let currentDay = today()
    @StateObject var placesAPIManager: PlacesAPIManager = PlacesAPIManager()

    var isFormComplete: Bool {
        return !name.isEmpty
        && (birthday.year > 0 && birthday.month > 0 && birthday.day > 0)
        && !bloodType.isEmpty
    }

    let bloodTypes = ["A", "B", "O", "AB"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Spacer()

                PrefectureImageView(imageUrl: $fortuneAPIManager.decodedLogoURL)
                if latitude != nil && longitude != nil {
                    TouristCardView(placesManager: placesAPIManager, latitude: $latitude, longitude: $longitude)
                }

                NameInputField(name: $name)
                BirthdayInputView(birthday: $birthday)
                BloodTypePickerView(bloodType: $bloodType, bloodTypes: bloodTypes)

                Spacer()

                FortuneButton(isFormComplete: isFormComplete) {
                    fortuneAPIManager.fetchFortune(name: name, birthday: birthday, bloodType: bloodType.lowercased(), today: currentDay)
                }
            }
            .padding()
            .onChange(of: fortuneAPIManager.prefectureName) { newName in
                guard let prefectureName = newName, !prefectureName.isEmpty else {
                    latitude = nil
                    longitude = nil
                    print("🐶緯度と経度が取得できなかった")
                    return
                }

                Task {
                    if let location = await latLonManager.getLatLon(forPrefecture: prefectureName) {
                        DispatchQueue.main.async {
                            latitude = location.latitude
                            longitude = location.longitude
                            print("\(prefectureName)のlatitude: \(latitude!), longitude: \(longitude!)")
                            // 場所情報を取得する
                            placesAPIManager.fetchNearbyPlaces(latitude: location.latitude, longitude: location.longitude)
                        }
                    } else {
                        DispatchQueue.main.async {
                            latitude = nil
                            longitude = nil
                            print("🐈緯度と経度がない")
                        }
                    }
                }
            }
        }
    }
}

