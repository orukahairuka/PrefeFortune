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
    @Published var prefectureName: String?
    @Published var decodedLogoURL: URL?

    // APIのバージョンを一元管理
    private let headers: HTTPHeaders = [
        "API-Version": "v1",
    ]

    // エラーメッセージを共通化
    private let networkErrorMessage = "リクエストに失敗しました。ネットワークの状態を確認してください。"
    private let decodeErrorMessage = "データの読み込みに失敗しました。再度お試しください。"

    func fetchFortune(name: String, birthday: YearMonthDay, bloodType: String, today: YearMonthDay) {
        
        // リクエストのパラメータを生成
        let requestParameters = FortuneRequest(
            name: name,
            birthday: birthday,
            bloodType: bloodType,
            today: today
        )

        let url = baseURL + endPoint

        // UI更新: ローディング状態をtrueに
        updateLoadingState(isLoading: true)

        
        // APIリクエストを実行
        AF.request(url, method: .post, parameters: requestParameters, encoder: JSONParameterEncoder.default, headers: headers)
            .responseData { [weak self] response in
                guard let self = self else { return }
                // リクエスト完了後にローディングを終了
                self.updateLoadingState(isLoading: false)

                switch response.result {
                case .success(let data):
                    self.handleResponseData(data: data)
                case .failure(let error):
                    self.handleNetworkError(error: error, data: response.data)
                }
            }
    }

    // MARK: - Private Methods

    private func updateLoadingState(isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
            if isLoading {
                self.errorMessage = nil
            }
        }
    }

    private func handleResponseData(data: Data) {
        // レスポンスデータをデバッグ用に出力
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON: \(jsonString)")
        }
        // エラーレスポンスか正常レスポンスかを判別
        if let decodedError = try? JSONDecoder().decode(ErrorResponse.self, from: data), decodedError.error {
            handleError(decodedError)
        } else {
            handleSuccess(data: data)
        }
    }

    private func handleSuccess(data: Data) {
        do {
            let decodedResponse = try JSONDecoder().decode(FortuneResponse.self, from: data)
            DispatchQueue.main.async {
                self.fortuneResponse = decodedResponse
                self.prefectureName = decodedResponse.name
                self.decodedLogoURL = decodedResponse.logoURL
            }
        } catch {
            print("Failed to decode response: \(error)")
            DispatchQueue.main.async {
                self.errorMessage = self.decodeErrorMessage
                self.fortuneResponse = nil
            }
        }
    }

    private func handleError(_ decodedError: ErrorResponse) {
        DispatchQueue.main.async {
            self.errorMessage = decodedError.reason
            self.fortuneResponse = nil
        }
    }

    private func handleNetworkError(error: AFError, data: Data?) {
        print("Request failed with error: \(error)")
        if let data = data, let jsonString = String(data: data, encoding: .utf8) {
            print("Error response: \(jsonString)")
        }
        DispatchQueue.main.async {
            self.errorMessage = self.networkErrorMessage
            self.fortuneResponse = nil
        }
    }

}
