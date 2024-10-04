//
//  FortuneAPIController.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import Foundation
import Alamofire

class FortuneAPIManager {

    private let baseURL = "https://ios-junior-engineer-codecheck.yumemi.jp"
    private let endPoint = "/my_fortune"

    func fetchFortune(name: String, birthday: YearMonthDay, bloodType: String, today: YearMonthDay) {
        
        let requestParameters = FortuneRequest(
            name: name,
            birthday: birthday,
            bloodType: bloodType,
            today: today
        )

        let url = baseURL + endPoint

        let headers: HTTPHeaders = [
            "API-Version": "v1",
        ]

        AF.request(url, method: .post, parameters: requestParameters, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: FortuneResponse.self) { response in
                switch response.result {
                case .success(let data):
                    // 成功時に結果を表示
                    self.handleSuccess(result: data)
                case .failure(let error):
                    // 失敗時のエラー処理
                    self.handleError(error: error)
                }
            }
    }

    private func handleSuccess(result: FortuneResponse) {
        print("占い結果:")
        print("都道府県: \(result.name)")
        print("県庁所在地: \(result.capital)")
        if let citizenDay = result.citizenDay {
            print("県民の日: \(citizenDay.month)月\(citizenDay.day)日")
        } else {
            print("県民の日: 設定されていません")
        }
        print("海岸線の有無: \(result.hasCoastLine ? "あり" : "なし")")
        print("概要: \(result.brief)")
    }

    private func handleError(error: Error) {
        print("API取得失敗: \(error.localizedDescription)")
    }
}
