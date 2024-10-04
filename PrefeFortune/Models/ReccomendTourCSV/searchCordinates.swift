//
//  searchCordinates.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import Foundation
import SwiftCSV

func getLatLon(from csvFilePath: String, forPrefecture name: String) -> (latitude: Double, longitude: Double)? {
    do {
        let csv = try CSV<Named>(url: URL(fileURLWithPath: csvFilePath))

        for row in csv.rows {
            if let prefectureName = row["pref_name"], prefectureName == name,
               let latitudeString = row["lat"], let latitude = Double(latitudeString),
               let longitudeString = row["lon"], let longitude = Double(longitudeString) {
                return (latitude: latitude, longitude: longitude)
            }
        }
    } catch {
        print("CSVファイルの読み込み中にエラーが発生しました: \(error)")
    }
    return nil // 県が見つからなかった場合
}

// ここで必要な処理を実行するための関数
func LatLonSearch() {
    let csvFilePath = "/Users/sakuraierika/repo/swift/PrefeFortune/PrefeFortune/Models/ReccomendTourCSV/prefectureCordinates.csv" // CSVファイルのパスを指定
    if let location = getLatLon(from: csvFilePath, forPrefecture: "北海道") {
        print("緯度: \(location.latitude), 経度: \(location.longitude)")
    } else {
        print("該当する県が見つかりませんでした。")
    }
}


