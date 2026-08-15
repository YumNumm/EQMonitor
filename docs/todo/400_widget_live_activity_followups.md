# ホーム画面ウィジェット / Live Activity の残課題

調査（Live Activity・ホーム画面ウィジェットのバグ / デザイン不備の洗い出し）で見つけたが、
今回は影響が小さいと判断して手を付けなかったもの。

## 1. Widget Extension が API ベース URL をプロセス内でキャッシュし続ける

`EarthquakeAPIService.shared` は `static let` なので、拡張プロセスが生きている間は
`ConfigReader.getAPIBaseURL()` の結果（= App Group の `apiServerUrl`）を再読み込みしない。

```swift
extension EarthquakeAPIService {
    static let shared = EarthquakeAPIService(baseURL: ConfigReader.getAPIBaseURL())
}
```

アプリ側でデバッグ用 API URL を切り替えても、`WidgetCenter.reloadAllTimelines()` は走るが
Client のベース URL は古いままになる。Widget Extension は OS に頻繁に kill されるため実害は
自然回復するが、デバッグ時に「切り替えたのに反映されない」と誤解しやすい。

対応するなら、ベース URL をキーにしたキャッシュへ変更する（Swift 6 の並行性チェックに
合わせて `NSLock` などで保護する必要がある）。

## 2. `WidgetRegionResolver` が `region` / `station` の searchType を解釈しない

`RegionSearchType`（Dart 側）は `prefecture` / `region` / `city` / `station` の 4 値だが、
Swift 側は `prefecture` / `city` のみを扱い、他は全国へフォールバックする。

現在の任意地域ピッカー（`home_widget_settings_page.dart`）は都道府県・市区町村しか
選ばせないため到達しないが、ピッカーを拡張したときに「設定したのに全国が出る」形で
静かに壊れる。ピッカーを拡張する場合は Swift 側の `plan(forSearchType:)` も同時に更新する。

## 3. Widget Extension の UI に対する回帰テストがない

`WidgetModelsTests` はモデル・表記・レイアウト件数のみを検証しており、SwiftUI View の
スナップショットテストは無い。取消報での抑止や未入電バッジの収まりは Xcode Preview で
目視確認する運用になっている（`docs/knowledge/20260717_home_widget_worktree_validation.md`）。

## 4. Android のホーム画面ウィジェットは未実装

`app/android/app/src/main/res/values/` にテンプレート由来の AppWidget スタイル定義だけが
残っており、`AppWidgetProvider` / Glance の実装は無い。実装しないなら未使用の
`Widget.Android.AppWidget.*` / `Theme.Android.AppWidgetContainer` / `AppWidgetAttrs` /
`widget_margin` を削除して誤解を防ぐ。
