# Widget実装進捗

## 実装済み

### データ層

- 地域コードJSON生成 (188地域)
- `Region.swift`: 地域データモデル
- `EarthquakeAPIClient.swift`: EqApiClient統合、v2 API対応
  - `/earthquake`: 全国
  - `/earthquake/region`: 地域別

### Widget設定

- `EarthquakeWidgetIntent`: WidgetConfigurationIntent実装
  - 表示範囲選択: 現在地/指定地域/全国
  - 地域選択: 動的オプション対応
- `Widget.entitlements`: App Groups設定
- `Info.plist`: xconfigからAPI URL読み込み

### UI

- `EarthquakeWidgetView.swift`: サイズ別対応
  - Large/Medium: ヘッダー付き（グラデーション）、全件表示
  - Small: ヘッダーなし、最大3件
- SF Mono: 数字・英語部分
- 震度強弱: 下付き小文字表示
- エラー・空表示UI

### Timeline

- 15分ごと更新
- エラー時5分後リトライ

## 設定

- API: v2.api.eqmonitor.app
- App Groups: `group.net.yumnumm.eqmonitor${APP_ID_SUFFIX}`
- 現在地モック: 東京都23区 (code: 350)

## 要対応

- EqApiClientパッケージ依存追加
- regions.jsonをXcodeプロジェクトに追加
- OpenAPIビルドエラー解消
