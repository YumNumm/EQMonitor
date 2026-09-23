# 統合 Live Activity の Preview ホスト

## Widget Extension の制約

Widget Extension は通常の SwiftUI View Preview をホストできない。
`UnsupportedPreviewContentInExtensionError` と
`The widget extension can only host widget previews.` が出た場合は、
Widget 用の Preview を開く。

`Widget/LiveActivity/Unified/UnifiedLiveActivityPreviews.swift` は
`UnifiedLockScreenView` を直接描画する通常の View Preview なので、
Widget Extension をホストにして実行しない。

## 統合 Live Activity の確認手順

1. `app/ios/Runner.xcworkspace` を開く。
2. Scheme は `EQMonitorPreview`、実行先は iPhone シミュレータを選ぶ。
3. `app/ios/EQMonitorPreviewWidget/EQMonitorPreviewWidgetBundle.swift` を開く。
4. Canvas で `統合 デザイン確認 - Lock Screen` を選んで Resume する。
5. Dynamic Island は同じファイルの `統合 デザイン確認` の
   Expanded / Compact / Minimal を選ぶ。

これらは `EarthquakeLiveActivityWidget` を使用し、
ActivityConfiguration 経由で統合 Live Activity の実装を描画する。
EEW 専用の `EEW デザイン確認` と取り違えないこと。

Preview 用 Bundle の登録対象は EEW と統合 Live Activity に限定する。
ホーム画面用 `EarthquakeWidget` の登録は Live Activity の確認には不要。
通常ビルドの成功と Canvas の実行成功は別々に確認すること。

```sh
xcrun xed app/ios/EQMonitorPreviewWidget/EQMonitorPreviewWidgetBundle.swift
```
