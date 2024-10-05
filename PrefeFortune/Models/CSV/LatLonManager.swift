//
//  searchCordinates.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import Foundation
import SwiftCSV

class LatLonManager: ObservableObject {
    private var csvFilePath: String?

    init() {
        // アプリケーションバンドル内のCSVファイルへのURLを取得
        if let fileURL = Bundle.main.url(forResource: "pref_lat_lon", withExtension: "csv") {
            self.csvFilePath = fileURL.path
            print("CSVファイルのパス: \(csvFilePath!)") // デバッグ用出力
        } else {
            print("CSVファイルが見つかりませんでした")
            self.csvFilePath = nil
        }
        
    }
    func getLatLon(forPrefecture name: String) -> (latitude: Double, longitude: Double)? {
        //csvがなかった時早めに引き返す
        guard let path = csvFilePath, !path.isEmpty else {
            print("CSVファイルのパスが無効です")
            return nil
        }
        
        do {
            let csv = try CSV<Named>(url: URL(fileURLWithPath: path))

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

}


