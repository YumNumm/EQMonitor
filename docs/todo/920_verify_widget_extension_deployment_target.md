# Widget Extension の deployment target 引き下げを macOS でビルド検証する

## 背景

`WidgetExtension` の `IPHONEOS_DEPLOYMENT_TARGET` が **26.0** になっており、
Runner（17.6）より高い状態だった。App Extension は自身の `MinimumOSVersion` より
古い OS では読み込まれないため、**iOS 17.6〜25 の端末では次の機能が丸ごと利用でき
なかった**。

- ホーム画面ウィジェット（WidgetKit のギャラリーに出てこない）
- 緊急地震速報 / 揺れ検知の Live Activity（`EewLiveActivityAttributes` を持つ
  拡張が読み込まれないため push-to-start が着弾しても表示されない）

とくに後者は深刻で、`PushTokenPlatformCapabilities` は iOS 18 以降で
push-to-start トークンをサーバへ登録する。つまり iOS 18〜25 の端末は
「サーバは Live Activity を配信するのに端末側に受け皿が無い」状態だった。

## 原因

Widget Extension には iOS 26 専用 API を使うコードが混在していた。

1. `app/ios/Widget/DesignSystem.swift` の `eqGlass`（`glassEffect` / `Glass`）
   → **参照ゼロのデッドコードだったため削除済み**
2. `app/ios/Widget/Controls/` の `ControlWidget`（iOS 18）
3. `AppIntentExtension` グループが `WidgetExtension` にも取り込まれており、
   `SnippetIntent` / `ShowsSnippetIntent` / `ShowsSnippetView`（iOS 26）が含まれる
   （`LatestEarthquakeSnippetControl` が `EarthquakeSnippetIntent` を参照するため）

2 と 3 は `@available` を明示して対応済み。

## 実施済みの変更

- `eqGlass` と未使用の `import UIKit` を削除
- `@available(iOS 18.0, *)`: `OpenEarthquakeHistoryControl` / `OpenEarthquakeHistoryIntent`
- `@available(iOS 26.0, *)`: `LatestEarthquakeSnippetControl` /
  `GetLatestEarthquakesIntent` / `EarthquakeSnippetIntent` /
  `GetEarthquakesNearMeIntent` / `EarthquakeSnippetView` / `EarthquakeSnippetRow`
- `WidgetBundle` の `#available` 分岐を 18 と 26 に分割
- `WidgetExtension` の `IPHONEOS_DEPLOYMENT_TARGET` を `26.0` → `17.6`（Runner と同値）

`AppIntentExtension` ターゲット自体は Interactive Snippet 専用なので 26.0 のまま。

## 残作業（要 macOS）

PR CI（`pr-flutter-check.yaml`）は `dart analyze` と Dart テストのみで
**iOS をビルドしない**。`xcodebuild archive` が走るのは develop への push 時
（`deploy-app.yaml`）だけなので、マージ前に手元で必ずビルドを通すこと。

```bash
cd app/ios
xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Debug \
  -destination 'generic/platform=iOS Simulator' \
  build
```

確認すべき点。

- `WidgetExtension` が 17.6 でコンパイルできる（availability の付け忘れが無い）
- AppIntents のメタデータ処理（`appintentsmetadataprocessor`）が通る
- iOS 26 シミュレータでウィジェット・Live Activity・Control が従来どおり出る
- iOS 18 シミュレータでウィジェットと Live Activity が**新たに**出る
  （`LatestEarthquakeSnippetControl` は出ない想定）

コンパイルエラーが出た場合は、該当の型へ `@available(iOS 18.0, *)` または
`@available(iOS 26.0, *)` を追加すれば足りるはず。それでも収束しない場合は、
Control / Snippet を別の Widget Extension ターゲットへ分離して
Live Activity 用の拡張だけを 17.6 に保つ構成を検討する。

## 参考

- `SUPPORTED_PLATFORMS` に `watchos` が入っているがテンプレート由来で、
  watchOS ホストアプリが無いため実際にはビルドされない。
- `docs/todo/300_ios_extension_bundle_version_mismatch.md` と同じく、
  extension のビルド設定が Runner と揃っていない類の問題。
