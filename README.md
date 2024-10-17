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
     - [Alamofire](https://github.com/Alamofire/Alamofire.git), バージョン `5.9.1`
     - [Lottie](https://github.com/airbnb/lottie-ios), バージョン `4.5.0`
     - [SwiftCSV](https://github.com/naoty/SwiftCSV.git), バージョン `0.10.0`

4. **Target > Signing & Capabilities** に移動し、**Team**を自分のApple開発者アカウントに設定します。  
   これによりコード署名の問題を回避し、iOSデバイス上での実行が可能になります。

5. 実行するデバイスを選択します。

6. プロジェクトをビルド・実行します。

## パッケージ依存解決エラーに関する対処方法

もし以下のようなエラーメッセージが表示された場合:
```
Package.resolved file is corrupted or malformed; fix or delete the file to continue: unknown 'PinsStorage' version '3' at '/Users/sakuraierika/repo/swift/PrefeFortune/PrefeFortune.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved'.
```
このエラーは `Package.resolved` ファイルが破損しているか、フォーマットが正しくない場合に発生します。以下の手順でエラーを解消できます。

### 対処手順
1. 以下のPackage.resolvedのファイルを削除してください
PrefeFortune.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved

2. Xcodeでプロジェクトを再度開きます。

3. **File > Packages > Reset Package Caches** を選択し、依存パッケージのキャッシュをリセットします。

4. **File > Packages > Resolve Package Versions** を選択し、依存パッケージを再度解決します。

これでプロジェクトを正常にビルド・実行できます


