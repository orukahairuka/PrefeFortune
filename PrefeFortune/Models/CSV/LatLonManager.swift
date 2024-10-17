//
//  searchCordinates.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import Foundation
import SwiftCSV

class LatLonManager: ObservableObject {
    private var csvData: CSV<Named>?

    init() {
        loadCSVData()
    }

    /// 指定された県名に対応する緯度・経度を取得
    func getLatLon(forPrefecture name: String) async -> (latitude: Double, longitude: Double)? {
        guard let csvData = csvData else {
            print("CSVデータが読み込まれていません")
            return nil
        }

        // 対応する県のデータを検索
        for row in csvData.rows {
            if let prefectureName = row["pref_name"], prefectureName == name,
               let latitudeString = row["lat"], let latitude = Double(latitudeString),
               let longitudeString = row["lon"], let longitude = Double(longitudeString) {
                return (latitude, longitude)
            }
        }

        // 県が見つからなかった場合
        print("指定された県名がCSV内に見つかりませんでした: \(name)")
        return nil
    }

    // MARK: - Private Methods

    /// CSVファイルをロードする
    private func loadCSVData() {
        guard let fileURL = Bundle.main.url(forResource: "pref_lat_lon", withExtension: "csv") else {
            print("CSVファイルが見つかりませんでした")
            return
        }

        do {
            csvData = try CSV<Named>(url: fileURL)
        } catch {
            print("CSVファイルの読み込み中にエラーが発生しました: \(error)")
        }
    }
}
