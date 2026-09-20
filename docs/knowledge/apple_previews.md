# Widget / Live Activity の軽量 Preview

`app/ios/Runner.xcodeproj` の `EQMonitorPreview` scheme を使う。小さな host app と `EQMonitorPreviewWidget` extension だけを build し、通常の WidgetExtension scheme が Runner/Flutter を巻き込む待ち時間を減らす。

## Preview の実行先

- WidgetKit の `previewContext` や Widget 用 `#Preview(as:)` は widget extension の context が必要。Widget source を host app に追加して代用しない。
- 素の SwiftUI View は別の適切な target で確認する。widget extension で「missing previewContext」になる場合は用途を分ける。
- 報の進行は `#Preview(as:using:widget:contentStates:)` へ状態列を渡す。一状態の `previewContext` だけで更新時の崩れを確認したことにしない。
- 到達時刻は Preview 生成時の `Date()` を基準にする。固定の過去日時で常に到達済みにしない。
- 表示ケースとデザイン基準は [Live Activity](live_activity.md) を参照する。

## ファイル所属と resource

- `Widget/` は同期グループ。所有 target の `membershipExceptions` は除外、グループを所有しない Preview target 側は追加という逆の意味になる。
- Widget ファイル追加時は Preview 側 exception set にも追加する。`Shared/` は通常グループなので Sources の `PBXBuildFile` へ明示的に追加する。
- Preview extension はローカル `EQMonitorAPI` package を link する。フォント、slim `jma_code_table.json`、Widget の Assets catalog も resources に必要。
- 本番 `WidgetBundle.swift` の `@main` と Preview bundle を同時に入れない。Preview 非対応の Controls とその AppIntent 依存も除外する。
- appex bundle ID は host app の ID を prefix にする。最低 OS と actor isolation は本番 Widget target と揃える。
- 静的 Preview の host は App Group entitlement を持たない。App Group 読出しや配信の実機確認を代替しない。

## 確認

`app/ios/` から:

```sh
xcodebuild -project Runner.xcodeproj -scheme EQMonitorPreview \
  -destination 'generic/platform=iOS Simulator' -configuration Debug build
```

生成した app の `PlugIns/EQMonitorPreviewWidget.appex` と Simulator への install を確認する。直接の xcodebuild が SwiftPM 解決や `Package.resolved` を変更する場合があるため、終了後に差分を確認する。
