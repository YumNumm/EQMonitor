# 統合 Live Activity の実表示確認

- `EQMonitorPreview` の通常ビルドは、2026-09-21 の環境では Swift Package の依存定義と `Package.resolved` の不一致でコンパイル前に停止した。アプリの依存解決を整えた後、再確認する。
- ActivityConfiguration を通す Canvas で、全状態の Lock Screen と Dynamic Island Expanded の見切れを確認する。特にカスタムフォント読み込み後の高さ、最小幅の端末、地震情報の EEW 副次帯を確認する。
- 揺れ検知からEEWへの遷移時に白い背景が見える現象は、背景を保持する親Viewとidentity transitionに変更済み。OS上の遷移アニメーションが改善したかはCanvasまたは実機で確認する。
- 実機でのAPNs Start→Broadcast Update→End、Runner/Dartの統合Live Activityデバッグ画面、アプリ全体のビルド確認は別途必要。
