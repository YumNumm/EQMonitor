# 改善課題の入口

関連する分野の文書だけを読みます。ファイル名はその分野の最大優先度、見出しは各項目の優先度です。数値が大きいほど先に検討します。
過去のログや完了済み作業は Git 履歴へ残し、本文には未完了の条件を記載します。

| 分野 | 主な未完了事項 |
| --- | --- |
| [950: ビルド・配布](950_build_and_release.md) | CI のローカル参照、AGP、署名済み成果物、versionCode、extension の版番号 |
| [950: 地図データ](950_map_data_pipeline.md) | manifest 契約、展開・保持メモリ予算、remote range 検証、非同期 decode |
| [930: Apple 拡張](930_apple_extensions.md) | App Intents・Widget・Live Activity の契約と実機確認 |
| [900: 認証・課金・広告](900_auth_subscription_and_ads.md) | native 認証の配布設定、App Check、subscription と Pro 再有効化 |
| [850: Asset Pack](850_asset_pack.md) | R2 更新・Flutter assets の release 検証、旧 native 残骸削除、容量と地物被覆 |
| [820: 地図レンダラ](820_map_renderer_and_migration.md) | GPU lifecycle、MapLibre からの画面移行、Web・3D の範囲 |
| [800: EEW・推定震度](800_eew_and_estimated_intensity.md) | 震度不明の配信方針、再取得中の表示、不完全な震源のテスト |
| [800: UI・遷移](800_ui_and_navigation.md) | onboarding preset、戻る操作、tablet 表示、UI 移行の残件 |
| [770: 開発ツール](770_tooling_and_test_followups.md) | Melos・起動設定、CI 時間、文書リンク、解析の適用範囲 |
| [160: リアルタイム監視](160_realtime_monitor_followups.md) | 強震モニタの時計・状態所有、揺れ検知の再有効化条件 |

## 保守

- 新規課題は既存の分野へ追記し、対象 path・現在の事実・完了条件を記載する。
- 同じ問題の調査ログや別案を独立した TODO にしない。優先度の異なる項目を統合しても、見出しの数値を保持する。
- 完了を確認した項目や、廃止機能にしか関係しない項目は削除する。未使用コードを除去する作業は、実際に残存している場合だけ維持する。
- 端末・ストア・backend の確認待ちは未検証と明記する。過去の結果を現在の成功・失敗の証拠にしない。
- 再利用する制約や対処は [知見ガイド](../knowledge/README.md) の関連文書へ残す。
