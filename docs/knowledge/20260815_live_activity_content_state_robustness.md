# Live Activity content-state を扱うときの注意点

Live Activity の表示データは APNs の `content-state` JSON が唯一の入力で、Widget Extension の
`Codable` へ直接マッピングされる。**デコードに 1 箇所でも失敗すると Live Activity 全体が
表示されない**ため、通常の API レスポンスより厳しく堅牢性を意識する必要がある。

## 1. ContentState のフィールドは原則 optional にする

UI で使わないフィールドを non-optional にすると、backend がそのキーを落とした瞬間に
content-state 全体のデコードが失敗し、緊急地震速報が一切出なくなる。

```swift
// ❌ 悪い例: UI 未使用なのに必須
let type: String

// ✅ 良い例
/// UI 未使用。必須にすると backend の欠落でデコードごと失敗する
let type: String?
```

`docs/live-activity-specification.md` の APNs ペイロード例に載っていないキーを必須にしていないか、
`ActivityAttributes` / `ContentState` を触るたびに確認する。

## 2. 日時は `ISO8601DateFormatter()` の既定設定でパースしない

既定の `formatOptions` は `.withInternetDateTime` のみで、**小数秒を受理しない**。
backend の日時表現は経路によって揺れる（JS の `Date.toISOString()` は必ず小数秒付き、
PostgreSQL `timestamptz` のテキストはスペース区切り + 2 桁オフセット）。

`app/ios/Shared/LiveActivityDate.swift` の `LiveActivityDate.parse(_:)` を必ず使う。

```swift
// ❌ 悪い例: "2024-01-01T07:10:00.123Z" が nil になる
ISO8601DateFormatter().date(from: time)

// ✅ 良い例
LiveActivityDate.parse(time)
```

同じ理由で API クライアント側には `LenientISO8601DateTranscoder` がある。
Live Activity は content-state を `String` で受けるため transcoder が効かず、別途対処が必要。

## 3. 表示時刻は JST 固定にする

JMA の発表時刻は JST が正。`DateFormatter` に `timeZone` を設定し忘れると端末の
タイムゾーンで表示され、同じ画面内で JST 固定の値と混在する。
`JSTDateFormat.monthDay / timeWithSeconds / timeShort` を使う。

`Text(date, style: .time)` も端末タイムゾーンになるので、固定時刻の表示には使わない。

## 4. `Text(timerInterval:)` の範囲は同一時刻から作る

```swift
// ❌ 悪い例: 判定と範囲生成で Date() を 2 回取るため、
//            到達した瞬間に lowerBound > upperBound で事前条件違反（クラッシュ）
if arrivalDate > Date() {
    Text(timerInterval: Date()...arrivalDate, countsDown: true)
}

// ✅ 良い例
if let remaining = ArrivalCountdown.remaining(until: arrivalDate) {
    Text(timerInterval: remaining, countsDown: true)
}
```

## 5. 取消報では値が残っていても表示しない

取消報（`isCanceled == true`）は震源・規模・予想震度・到達予想がすべて無効。
backend は `null` を送る仕様だが、値が残って届いた場合でもクライアント側で抑止する。
取消済みなのに「最大震度6強」「主要動到達まで 00:12」が出ると誤情報になる。

`EewContentState.isCanceledReport` / `displayIntensity` を経由すること。

## 6. ロック画面はライト / ダーク両方で描画される

ロック画面の Live Activity は `.white` 固定の前景色だと明るい背景で不可視になる。
ヘッダーのように背景色を自前で塗っている領域以外では `.primary` ベースの色を使う。

## 7. Dynamic Island の leading / trailing に独自の余白を足さない

展開時の `.leading` / `.trailing` は TrueDepth カメラ脇の細い L 字領域で、
`.center` はカメラの下、`.bottom` はさらにその下に置かれる。
leading / trailing に `padding` を足すとその分だけ内容が切り取られる。

```swift
// ❌ 悪い例: 領域側に余白を足して内容が切れる
DynamicIslandExpandedRegion(.leading) {
    VStack { ... }.padding(.leading, 4)
}

// ✅ 良い例: 余白は足さず、収まらない場合はカメラ下へ回り込ませる
DynamicIslandExpandedRegion(.leading) {
    VStack { ... }
        .dynamicIsland(verticalPlacement: .belowIfTooWide)
}
```

細い領域では Text を複数に割らないこと。`Text("最終 ") + Text("第") + Text("32") +
Text("報")` のように分けると折り返し・切り取りが起きる。1 つの Text にまとめて
`lineLimit(1)` + `minimumScaleFactor` で縮小させる。

## 8. 未知の enum 値で Dynamic Island が空にならないようにする

`ShakeDetectionLevel(rawValue:)` のように文字列から enum へ変換する箇所は、
backend が値を追加すると nil になる。`compactLeading` / `minimal` を
`if let` だけで組むと Dynamic Island が真っ白になるため、必ずフォールバック表示を置く。

## 9. App Extension の deployment target を本体アプリより上げない

App Extension は自身の `MinimumOSVersion` より古い OS では読み込まれない。
Widget Extension の `IPHONEOS_DEPLOYMENT_TARGET` を上げると、その OS 未満の端末では
**ホーム画面ウィジェットも Live Activity も丸ごと消える**（ギャラリーに出ず、
push-to-start も着弾しない）。新しい OS 専用 API を使いたい場合は、
ターゲットの設定を上げるのではなく型へ `@available` を付ける。

```swift
// ✅ ControlWidget は iOS 18、SnippetIntent は iOS 26。型側で明示する
@available(iOS 18.0, *)
struct OpenEarthquakeHistoryControl: ControlWidget { ... }
```

未使用のヘルパー 1 つ（`glassEffect` を使う `eqGlass`）が拡張全体を iOS 26 に
固定していた実例がある。デッドコードでも deployment target を引き上げる圧力になる。

なお PR CI（`pr-flutter-check.yaml`）は iOS をビルドしない。`xcodebuild archive` が
走るのは develop への push 時だけなので、`app/ios/` のビルド設定や availability を
触ったら手元で必ずビルドすること。

## 検証方法

Linux では SwiftUI / ActivityKit を含むファイルはビルドできないが、Foundation のみに
依存するロジック（`LiveActivityDate` / `WidgetErrorMessage` / `IntensityValue` など）は
SwiftPM の一時パッケージへコピーして `swift test` で検証できる。

```bash
# Swift ツールチェーン（Linux）
curl -fsSL -o /tmp/swift.tar.gz \
  https://download.swift.org/swift-6.0.3-release/ubuntu2204/swift-6.0.3-RELEASE/swift-6.0.3-RELEASE-ubuntu22.04.tar.gz
mkdir -p ~/swift && tar xzf /tmp/swift.tar.gz -C ~/swift --strip-components=1
sudo apt-get install -y libncurses6 libtinfo6 libcurl4 libxml2
~/swift/usr/bin/swift --version
```

macOS では通常どおり `WidgetModelsTests` を実行する。
`Shared/` は file-system synchronized group ではないため、ファイルを追加したら
`project.pbxproj` の PBXFileReference / PBXBuildFile / 各ターゲットの Sources phase へ
手で登録する（`Widget/` 配下は synchronized group なので登録不要）。
