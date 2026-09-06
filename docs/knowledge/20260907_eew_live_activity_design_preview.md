# EEW Live Activityの現在地表示とPreview

## 表示規則

- Figma `1628:1745`がロック画面、`1628:1694`がExpandedの基準。
- Minimal/Compactの現在地震度は塗りつぶしあり。最大震度は塗りつぶしなし＋`MAX`。
- 未発表の最大震度は`MAX -`。取消は取消記号に切り替える。
- `EewDisplay.localIntensity`が現在地情報の可否を判断する。予報は震度4以上、警報は提供された現在地震度を表示する。
- 現在地が警報対象かは`location.isWarning`で受信する。電文全体の`isWarning`だけで現在地の警報帯を出さない。
- 警報対象でも予想震度・到達予想が欠けていれば値を補わない。
- 取消・現在地震度非表示・現在地PLUMではカウントダウンを出さない。
- カウントダウンの`Text(timerInterval:)`と幅確保用placeholderは同じフォントを使用する。
- ヘッダーのしましまは`StripePattern`を再利用。取消の灰色も維持する。
- 最大長周期地震動階級の配信不足は`docs/todo/500_eew_live_activity_max_lpgm.md`を参照。

本規則は`20260815_dynamic_island_eew_layout.md`の旧配置と、
`20260823_eew_missing_forecast_intensity.md`のiOS最大震度の背景色規則に優先する。
Flutterアプリの震度表示は変更していない。

## Swift Preview

Xcodeで`app/ios/Runner.xcodeproj`を開き、スキーム`EQMonitorPreview`とiPhone Simulatorを選ぶ。
`EQMonitorPreviewWidget/EQMonitorPreviewWidgetBundle.swift`を開いてCanvasを表示する。
`EEW デザイン確認`のLock Screen / Expanded / Compact / Minimalが同じ状態一覧を使う。

状態順は、警報対象、警報対象外（現在地3）、予報（現在地4）、現在地情報なし、
到達予想なし、警報対象だが震度なし、取消、深発、PLUM、予報（現在地3・非表示）。
カウントダウンはPreview生成時点から31秒。再開するときはPreviewを再生成する。

```sh
xcodebuild build -project app/ios/Runner.xcodeproj -scheme EQMonitorPreview \
  -destination 'generic/platform=iOS Simulator' \
  -disableAutomaticPackageResolution -skipPackageUpdates CODE_SIGNING_ALLOWED=NO

xcodebuild test -project app/ios/Runner.xcodeproj -scheme WidgetModelsTests \
  -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' \
  -disableAutomaticPackageResolution -skipPackageUpdates CODE_SIGNING_ALLOWED=NO
```

新しい`Widget/`ファイルをPreview拡張に含めるには、`project.pbxproj`の
Previewターゲット向け`membershipExceptions`への追加が必要。
見た目の最終確認はCanvasで行う。ビルド成功だけでカメラ脇の切り取りがないとは判断しない。

## 外観・余白の注意

- 黒背景のEEWは文字色を白で明示する。PreviewのLight Appearanceでは
  `activityBackgroundTint(.black)`だけに頼らず、ロック画面Viewにも黒背景を指定する。
- Expandedの本文全体に縦方向の`fixedSize`を付けると、割り当て高さを超えて
  下端が切れる場合がある。警報名など必要なTextだけに指定する。
- 単一leading領域＋`belowIfTooWide`も試したが、現在地情報の下端がCanvasで切れた。
  本実装はleading/trailing/bottomを分離し、OS標準の外周余白を維持する。
  カメラ高さの固定値や負のpaddingで補正しない。
- Google Sans Codeは行ボックスに上下余白を持つ。Figmaのcap height基準の行間を
  VStackのspacingにそのまま足すと二重になるため、M・深さの縦積みはspacing 0。
- Expandedの最大震度は38pt、震源要素の数値は21pt。表示サイズだけの調整では
  テストを追加せず、既存モデルテスト・静的解析・Canvasで確認する。
