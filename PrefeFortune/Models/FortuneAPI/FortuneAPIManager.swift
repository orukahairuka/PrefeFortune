//
//  FortuneAPIController.swift
//  PrefeFortune
//
//  Created by 櫻井絵理香 on 2024/10/04.
//

import Foundation
import Alamofire


class FortuneAPIManager: ObservableObject {
    private let baseURL = "https://ios-junior-engineer-codecheck.yumemi.jp"
    private let endPoint = "/my_fortune"

    @Published var fortuneResponse: FortuneResponse?
    @Published var errorMessage: String? 
    @Published var isLoading = false
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

        // UI更新のため
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        AF.request(url, method: .post, parameters: requestParameters, encoder: JSONParameterEncoder.default, headers: headers)
            .responseData { response in
                DispatchQueue.main.async {
                    // リクエスト完了後にローディングを終了
                    self.isLoading = false
                    switch response.result {
                    case .success(let data):
                        // レスポンスデータをデバッグ用に出力
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Response JSON: \(jsonString)")
                        }
                        // 成功かエラーレスポンスかを判別する
                        if let decodedError = try? JSONDecoder().decode(ErrorResponse.self, from: data), decodedError.error {
                            // エラーレスポンスの場合の処理
                            self.errorMessage = decodedError.reason
                            self.fortuneResponse = nil
                            return
                        }
                        
                        do {
                            // 正常レスポンスのデコード
                            let decodedResponse = try JSONDecoder().decode(FortuneResponse.self, from: data)
                            self.fortuneResponse = decodedResponse

                                if let logoURL = decodedResponse.logoURL {
                                    print("Logo URL: \(logoURL)")
                                } else {
                                    print("Logo URL is not valid.")
                                }

                        } catch {
                            // デコードエラー時の処理
                            print("Failed to decode response: \(error)")
                            self.errorMessage = "データの読み込みに失敗しました。再度お試しください。"
                            self.fortuneResponse = nil
                        }
                        
                    case .failure(let error):
                        // ネットワークエラー時の処理
                        print("Request failed with error: \(error)")
                        if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                            print("Error response: \(jsonString)")
                        }
                        self.errorMessage = "リクエストに失敗しました。ネットワークの状態を確認してください。"
                        self.fortuneResponse = nil
                    }
                }
            }
    }

}
