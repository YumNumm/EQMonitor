# 統合 Live Activity の表示ルール

- EEW 主表示は `UnifiedEew.eewContentState` を経由して既存 EEW View を使用する。Lock Screen、Compact、Minimal、Expanded を個別に再実装しない。
- 揺れ検知は headline、検知時刻、現在地を表示する。更新時刻、headline と重複する揺れの強さ、検知終了の説明文は不要。
- 地震情報の取消は表示シナリオに含めない。
- Lock Screen は最大160ptを前提に設計する。文字をクリップして隠すのではなく、情報の重複と余白を減らす。
- Dynamic Island Expanded に Lock Screen の情報をすべて詰め込まない。地震情報の本文は種別・見出し・現在地1行とし、発生時刻と EEW 副次帯を省く。
- 通常の検証コマンドは既存の `20260907_eew_live_activity_design_preview.md` を参照する。

```sh
xcodebuild build -project app/ios/Runner.xcodeproj -scheme EQMonitorPreview \
  -destination 'generic/platform=iOS Simulator' \
  -disableAutomaticPackageResolution -skipPackageUpdates CODE_SIGNING_ALLOWED=NO
```

ビルドだけではOSによる切り取りを確認できない。ActivityConfiguration を通す Preview で Lock Screen と Expanded の両方を確認する。

## 高さの補助検証

- `UIHostingController.sizeThatFits(in:)` に幅320／360／402pt、高さ1000ptを渡し、揺れ検知・地震情報の自然な高さが160pt以下になることを確認する。
- EEW は既存 `EewLockScreenView` と同じデータを渡し、寸法が一致することを確認する。既存側のデザイン変更と統合側の変更を混同しない。
- テスト用ホストにも Google Sans Flex / Code を登録する。フォント未登録の代替フォントでは高さが変わり、実際のレイアウトの検証にならない。
- 本体の依存解決が停止する場合、対象 Swift ソースとローカル `EQMonitorAPI` のみを含む一時テストターゲットでコンパイルと補助検証を行える。ただし本体のビルドと Canvas 確認を代替するものではない。
