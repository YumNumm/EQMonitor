---
alwaysApply: false
globs: app/lib/feature/settings/children/config/debug/live_activity/**,app/ios/Runner/LiveActivityDebugMethodChannel.swift
---

# Live Activity ローカル開始（デバッグ）

デバッグ画面（`設定 > デバッグ > Live Activity テスト`, iOS のみ）から、アプリ内で
ActivityKit を用いて EEW / 揺れ検知の Live Activity を **ローカル開始・更新・終了**
できる。Push-to-Start（サーバー経由）とは別経路で、開発時の表示検証に用いる。

## 構成

- Dart 側は MethodChannel `net.yumnumm.eqmonitor/live_activity_debug` を叩くだけ。
  - `LiveActivityLocalController`（iOS のみ MethodChannel 実装、他は no-op）
  - `DebugLiveActivityContentBuilder`（プリセット + 実データ変換 → `Map`）
  - `DebugLiveActivityJsonCodec`（JSON 整形・検証）
  - `DebugLiveActivityAction`（検証 → ネイティブ → SnackBar）
- ネイティブは `app/ios/Runner/LiveActivityDebugMethodChannel.swift`。
  `Activity.request` / `update` / `end` を呼ぶ。

## ContentState JSON はネイティブ Codable とキーを一致させる

Widget Extension の `EewContentState` / `ShakeDetectionContentState` /
`LocationInfo`（Swift）は既定 CodingKeys = プロパティ名（camelCase）。
`DebugLiveActivityContentBuilder` が生成する `Map` のキーはこれに一致させること。

- EEW: `eventId,type,hypocenterName,magnitude,depth,time,isOriginTime,maxIntensity,serialNo,isFinal,isWarning,isCanceled,headline,isPlum,isLevel,isOnePoint,location`
- 揺れ検知: `eventId,type,level,detectedAt,location`
- `location`: `regionName,forecastIntensity,forecastLpgmIntensity,arrivalTime,intensity`
- `maxIntensity` / `forecastIntensity` は Widget の `IntensityValue` rawValue
  （`0..7`, `5-`, `5+`, `6-`, `6+`, `!5-`, `!6-`）に一致させる。
- 時刻は Swift 既定 `ISO8601DateFormatter`（**小数秒なし**）でパースできる
  JST オフセット付き文字列 `yyyy-MM-ddTHH:mm:ss+09:00` を送る。

## ActivityKit 型の紐付け（重要・macOS 検証必須）

ローカル `Activity<EewLiveActivityAttributes>.request` した Activity を既存 Widget
（`app/ios/Widget/LiveActivity/...` の `ActivityConfiguration`）で描画させるには、
`ActivityAttributes` の **型名** が一致している必要がある。

現状は `LiveActivityDebugMethodChannel.swift` 内に、Widget と型名・Codable
フィールドを一致させた `EewLiveActivityAttributes` /
`ShakeDetectionLiveActivityAttributes` を **重複定義** している（Runner モジュール）。

- ActivityKit の Widget 紐付けは Attributes 型名ベースのため、通常はこれで
  既存 Widget レイアウトに描画される。
- **もし macOS 実機検証でローカル開始した Activity が Widget に描画されない場合**、
  クロスモジュールの型同一性が原因。その際は Widget の Attributes ソース
  （`EewLiveActivityAttributes.swift` 等）を Runner ターゲットにも所属させる
  （共有ソース化）にフォールバックする。

## この環境（Linux Cloud Agent）で検証できたこと / できないこと

- 検証済み: Dart 静的解析（`dart analyze`）、ユニットテスト（`flutter test`）
  17 件パス。MethodChannel の引数・JSON 契約、プリセット/実データ変換、JSON 検証。
- 未検証（macOS 必須）: iOS ビルド、Swift コンパイル、`Runner.xcodeproj`
  への 1 ファイル追加（`LiveActivityDebugMethodChannel.swift`）、実機での
  Live Activity 表示。**macOS でのビルド・実機確認が必要。**

## ツール実行メモ（この環境）

- `mise install` は `swift` のインストールに失敗する（`libncurses.so.6` 欠如）。
  Dart/Flutter 作業では Flutter を直接 PATH に通して回避した。
  `export PATH="$HOME/.local/share/mise/installs/flutter/<rev>/bin:...:$PATH"`
- `flutter_scene` submodule 初期化（`git submodule update --init third_party/flutter_scene`）
  が pub get の前提。
