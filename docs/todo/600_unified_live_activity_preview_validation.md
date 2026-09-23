# 統合 Live Activity の実表示確認

- `EQMonitorPreview` の通常ビルドと `WidgetModelsTests` は、2026-09-21 の環境では Swift Package の依存定義と `Package.resolved` の不一致でコンパイル前に停止した。
- アプリの依存解決を整えた後、両 scheme を再検証する。依存更新は今回のデザイン変更に混ぜない。
- ActivityConfiguration を通す Canvas で、全状態の Lock Screen と Dynamic Island Expanded の見切れを確認する。特にカスタムフォント読み込み後の高さ、最小幅の端末、地震情報の EEW 副次帯を確認する。
- 追加修正後、一時テストターゲットの43件は成功。カスタムフォント込みの幅320／360／402ptで全プレビュー状態の自然高が160pt以下になることを確認済み。M不明・M8+・EEW副次帯の値も描画画像で確認した。
- 揺れ検知からEEWへの遷移時に白い背景が見える現象は、背景を保持する親Viewとidentity transitionに変更済み。OS上の遷移アニメーションが改善したかはCanvasまたは実機で確認する。
- 元のブランチのデザイン確認用配列は12件だったため、画像で指定された State 13 と番号は一致しない。不要なブロック欠損サンプルと地震情報取消サンプルを削除済み。別の State 13 が残る場合は内容を照合する。
