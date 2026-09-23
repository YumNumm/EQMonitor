# 統合 Live Activity の実表示確認

- `EQMonitorPreview` の通常ビルドと `WidgetModelsTests` は、2026-09-21 の環境では Swift Package の依存定義と `Package.resolved` の不一致でコンパイル前に停止した。
- アプリの依存解決を整えた後、両 scheme を再検証する。依存更新は今回のデザイン変更に混ぜない。
- ActivityConfiguration を通す Canvas で、全状態の Lock Screen と Dynamic Island Expanded の見切れを確認する。特にカスタムフォント読み込み後の高さ、最小幅の端末、地震情報の EEW 副次帯を確認する。
- 元のデザインブランチの2026-09-21検証記録では、追加修正後の一時テストターゲット43件が成功。カスタムフォント込みの幅320／360／402ptで全プレビュー状態の自然高が160pt以下になることを確認済み。M不明・M8+・EEW副次帯の値も描画画像で確認した。
- 揺れ検知からEEWへの遷移時に白い背景が見える現象は、背景を保持する親Viewとidentity transitionに変更済み。OS上の遷移アニメーションが改善したかはCanvasまたは実機で確認する。
- 元のブランチのデザイン確認用配列は12件だったため、画像で指定された State 13 と番号は一致しない。不要なブロック欠損サンプルと地震情報取消サンプルを削除済み。別の State 13 が残る場合は内容を照合する。

## develop 統合時の検証範囲（2026-09-24）

- `tool/live_activity_tests/run.sh` と専用CIで、実際のSwiftソースをiOSシミュレータ向けにコンパイルし、契約・表示ロジック・320pt幅の画像生成を検証した。FlutterやFirebaseの依存解決とは独立している。
- この描画スモークテストは、過去のカスタムフォント込みの高さ160pt検証を再実行するものではない。Canvas、Dynamic Island、実機でのAPNs Start→Broadcast Update→Endは引き続き未確認。
- Runner/Dartの統合Live Activityデバッグ画面とアプリ全体のビルド確認は別途必要。
- [iOS CI](https://github.com/YumNumm/EQMonitor/actions/runs/35894825846)で、コードcommit `45daa445b` の61テスト（5 suites）が成功。
- 既存Flutter CIは解析・テスト前のmise環境準備で失敗している。同じエラーは[変更前のリリースPR](https://github.com/YumNumm/EQMonitor/actions/runs/35865454313)でも確認済み。
