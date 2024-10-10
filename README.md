<div id="top"></div>

# PrefeFortune

## リンク
[GitHubリポジトリ](https://github.com/orukahairuka/PrefeFortune)

## 環境
- **Xcode**: 15.4
- **Swift**: 5.10

## プラットフォーム
- **iOS**: 17.5

## 実行手順
1. リポジトリをクローンします:
   ```bash
   git clone https://github.com/orukahairuka/PrefeFortune.git
   ```
2. `PrefeFortune.xcodeproj`をXcodeで開きます。

3. 以下の手順でライブラリを追加します:
   - **File > Add Package Dependencies** を選択。
   - 以下のパッケージをそれぞれ追加してください:
     - [Alamofire](https://github.com/Alamofire/Alamofire.git)
     - [Lottie](https://github.com/airbnb/lottie-ios)
     - [SwiftCSV](https://github.com/swiftcsv/SwiftCSV)

4. **Target > Signing & Capabilities** に移動し、**Team**を自分のApple開発者アカウントに設定します。  
   これによりコード署名の問題を回避し、iOSデバイス上での実行が可能になります。

5. 実行するデバイスを選択します。

6. プロジェクトをビルド・実行します。
