# Home Widget Behavior and Swift OpenAPI Design

## Goal

iOS ホーム画面の地震履歴 Widget について、表示 overflow、現在地選択時の全国フォールバック、行タップ時の遷移を修正し、backend の最新 `openapi.json` から Swift API クライアントを再生成する。

## Root causes

- small / medium でも3件を固定表示し、再デザイン後の行背景・余白を含めた必要高さが Widget の実高さを超えている。
- 現在地の App Group 同期は `getLastKnownPosition()` だけに依存し、値が無いと保存済み地域も削除する。バックグラウンド位置監視は通知設定が現在地のときだけ開始されるため、Widget 単独の現在地利用では地域が未解決になり全国へフォールバックする。
- Flutter の deep-link 受け側と AppIntent の URL 実装はあるが、ホーム画面 Widget の地震行は `Link` で包まれていない。
- Swift package の OpenAPI は backend submodule の正準 JSON とハッシュが異なり、生成物が更新されていない。

## Design

### Layout

Widget family と利用可能高さから表示件数を返す純粋な `WidgetLayoutPolicy` を Shared 層に置く。既存のバッジサイズ、行余白、行間、ヘッダー高さを安全側に見積もり、small / medium は通常2件、large は5件を表示する。フォント縮小だけで収めず、可読性を維持する。

### Current location

権限を新規要求せず、許可済みの場合だけ last-known position を優先し、無ければ低精度の current position を取得するローダーを Riverpod で DI する。一時的に位置を取得できない場合は App Group の有効な地域を保持し、明示的なクリア時だけ削除する。

### Deep link

event ID から `eqmonitor:///earthquake-history-details/{eventId}` を生成する共有型を追加する。small / medium / large の各行を SwiftUI `Link` で包み、既存の `NotificationDeepLink` と `EarthquakeHistoryDetailsRoute` をそのまま利用する。

### Swift OpenAPI

`backend/api/api/openapi.json` を Swift package へコピーし、`patch-openapi-for-swift.py` を適用してから `swift-openapi-generator` で `Client.swift` と `Types.swift` を再生成する。手書き修正は行わず、契約 fixture の drift が出た場合のみ backend 契約に合わせる。

## Testing

- WidgetModelsTests: family / 高さ別の表示件数、deep-link URL、App Group 値から現在地 plan が解決されること。
- Flutter test: 位置未取得時に保存済み App Group 地域を保持すること、位置ローダーの last-known / current fallback。
- Swift package: `mise exec -- swift test`。
- iOS: WidgetModelsTests と Widget extension build。
- Dart: 対象テストと `mise exec -- dart analyze`。

## Publication

変更を要件ごとに小さくコミットし、`fix/home-widget-behavior-openapi` を push して `develop` 向け Draft PR を作成する。
