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
続くState 11は警報対象外・震度1、State 12は警報対象外・震度2。
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
- Expandedの本文を単に`fixedSize`にすると、割り当て高さを超えて下端が切れる。
  `ViewThatFits(in: .vertical)`内の候補の測定にだけ使い、高さ不足時には
  震度バッジ44pt・見出し1行のコンパクト配置を選ぶ。通常候補は56pt・2行。
  下部の左右・下には8ptを追加し、塗りつぶしをIslandの丸い外周から離す。
- Google Sans Flexを使った「緊急地震速報(警報)」は、幅の`fixedSize`だけでは
  末尾の省略が直らなかった。同サイズのシステムフォントに替えると全体を表示できた。
  この混在文のフォントはシステムを使う。数値のGoogle Sans Codeは維持する。
- 単一leading領域＋`belowIfTooWide`も試したが、現在地情報の下端がCanvasで切れた。
  本実装はleading/trailing/bottomを分離し、OS標準の外周余白を維持する。
  カメラ高さの固定値や負のpaddingで補正しない。
- Google Sans Codeは行ボックスに上下余白を持つ。Figmaのcap height基準の行間を
  VStackのspacingにそのまま足すと二重になるため、M・深さの縦積みはspacing 0。
- Expandedの最大震度は38pt、震源要素の数値は21pt。表示サイズだけの調整では
  テストを追加せず、既存モデルテスト・静的解析・Canvasで確認する。

## 現在地の注意帯

- 現在地が警報対象なら「現在地で強い揺れ」を優先する。
- 警報対象外で表示可能な予想震度が2未満なら「現在地で弱い揺れ」、
  背景は薄い蒼`#CDEEFF`・文字は黒。震度2以上なら「現在地で揺れ」。
- 震度なしを弱い揺れに補完しない。取消時は注意帯を抑止する。
- 予報時の現在地震度4以上という表示条件は変更していない。
- Canvasの確認は`Editor > Canvas > Refresh Canvas`で再生成してから行う。
  200%で警報名の末尾、注意帯・震度バッジの四隅、到達予想の下端を確認する。

## 取消・低精度ラベル・角丸

- 取消も通常と同じ左揃えの種別ラベル・見出しを使う。「予想は無効です」の
  説明は出さない。震度・到達予想の抑止は変更しない。
- 取消時の種別は「緊急地震速報」とし、`(取消)`は付けない。Expanded左上の
  取消記号は出さず、不可視かつアクセシビリティ対象外の最大震度枠で配置を維持する。
- ExpandedのMAX表示には左右4ptを確保する。単数字でもMAXを数字の右上に置き、
  6強などと行高を揃える。MAXを数字の上に縦積みするとState 3だけ上段が高くなり、
  下段のコンパクト候補でも高さを超える。Compact/Minimalの配置は変更しない。
- 取消時の報数とPLUM法などの混在文はシステムフォント＋`fixedSize()`を使う。
  カメラ脇の外周で切られないよう、枠の外側にも4ptの余白を確保する。
- Expandedの注意帯・現在地震度背景・低精度ラベルの枠は
  `ContainerRelativeShape()`でシステムのコンテナ形状に追従させる。
  独自の`containerShape`でDynamic Island側の形状を上書きしない。
- 参考: https://developer.apple.com/documentation/swiftui/containerrelativeshape

## 現在地震度がない場合の時刻

- Expandedで現在地の予想震度を表示しない場合、見出しの下に発生／検知時刻を表示する。
- `EewDisplay.showsEventTime`で取消を除外し、`state.timeDate`が解析できる場合だけ出す。
  区分は既存の`state.timeLabel`、日時は`JSTDateFormat`を使い、受信時刻などで補完しない。
