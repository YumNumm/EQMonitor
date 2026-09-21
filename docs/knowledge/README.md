# 知見ガイド

作業に関係する分野だけを参照するための入口です。知見・TODO の全件読み込みは不要です。
共通の開発手順は [エージェントガイド](../../.agents/index.md)、未完了の作業は [TODO 一覧](../todo/README.md) に集約しています。

## 開発環境・データ・配布

| 作業 | 要点と参照先 |
| --- | --- |
| セットアップ・worktree・解析 | [開発環境](development_environment.md)。SDK は mise、依存は lockfile、Scene は submodule commit が正本。package 単位で検証する。 |
| テスト方針 | [変更リスクとテスト](test_strategy.md)。**TDD は必須ではない**。緊急情報・状態遷移・障害修正などに必要な回帰テストは維持する。 |
| テスト環境の問題 | [テスト実行](testing.md)。実行 cwd、Native Assets、family override、フォントを確認し、古い失敗記録を免除に使わない。 |
| Freezed・OpenAPI・Pigeon | [コード生成](code_generation.md)。生成元と現行依存を直し、生成物を手編集しない。 |
| HTTP・JSON・端末移行 | [API とデータ](api_and_data.md)。cache は opt-in、JSON の構造と値検証は分離、移行は durable workflow で再開可能にする。 |
| iOS / Android build | [ネイティブビルド](native_build_release.md)。SDK・署名・R8 と実機確認を分け、build 成功だけで表示や配布の完了としない。 |
| CI・beta・Release Please | [配布と CI](delivery_ci.md)。設定・script を正本とし、タグ生成からストア処理まで段階ごとに確認する。 |
| Asset Pack | [同梱・更新・内容検証](asset_pack.md) / [R2 配布手順](../asset-pack-cd.md)。署名済み R2 配信と Flutter assets を使う。Apple 配信の Asset Pack 運用は廃止済み。 |
| APNs・認証 | [Push と認証](push_and_auth.md)。APNs 環境・token の種類・OS 権限・アプリ session を混同しない。 |

## 地震情報・描画

| 作業 | 要点と参照先 |
| --- | --- |
| EEW の値と状態 | [EEW・リアルタイム](eew_realtime.md)。公表震度と深さを独立に扱い、欠測値を作らず、再取得中も有効な表示を維持する。 |
| Live Activity | [表示と検証](live_activity.md)。全国値と現在地値、取消報、到達カウントダウン、現在の Preview 方針を確認する。 |
| 通知・バックグラウンド位置 | [通知と位置情報](notification_location.md)。OS 権限・slot 設定・処理の acknowledgment を分離し、再起動や retry を考慮する。 |
| Android 通知 | [channel 運用](android_notification_channels.md)。利用者設定を保ち、現役 channel を起動時に削除しない。 |
| 強震モニタ・時刻 | [強震モニタと時計](kyoshin_time.md)。NTP・画像遅延・表示時刻を分け、計測せずに GPU 化を前提としない。 |
| Siri・Control Center | [App Intents](app_intents.md)。同じ snapshot から音声と表示を作り、欠測や保存地域の鮮度を正しく扱う。 |
| SwiftUI Preview | [軽量 Preview](apple_previews.md)。host と Widget extension の所属・resource を揃え、配信検証とは区別する。 |
| 履歴画面・画面遷移 | [画面構成](adaptive_ui.md)。幅と選択状態に応じたペイン、戻る操作、wakelock の所有境界を確認する。 |
| 既存の地図 | [MapLibre](maplibre.md)。style 単位の初期化と可変データ更新を分離し、async 完了・dispose・描画順を制御する。 |
| 新しい地図 | [eqmonitor_map](map_renderer.md) / [固定参照実装](map_renderer_references.md)。source/revision・snapshot・座標空間・GPU lifetime を明示する。全画面の移行は未完了。 |
| タイル・震源データ | [PMTiles](pmtiles.md)。descriptor、実 bytes、公開件数、decode 上限を検証する。ETag の一貫性と暗号学的保証は別物。 |

## 改善の着手先

2026-09-21 の文書整理で、現行コード・設定と過去の記録を照合しました。実機・本番配信・private backend の動作確認は行っていません。

- **CI と開発コマンド:** Melos の生成タスク・Dart-only filter、起動設定の相対パスを直す。完了条件は [ビルド・配布](../todo/950_build_and_release.md) と [開発ツール](../todo/770_tooling_and_test_followups.md)。
- **データ契約と性能:** seismicity descriptor の公開、remote range の内容検証、CPU/GPU 合計保持量、cover 外 decode の受入を改善する。[地図データ](../todo/950_map_data_pipeline.md) に集約。
- **表示とライフサイクル:** GPU の復帰・remount、App Intents、EEW 再取得、通知 preset の build 中更新を確認する。[TODO 一覧](../todo/README.md) から対象分野を選ぶ。
- **文書の劣化防止:** 相対リンク・参照パスの CI 検査を追加する。完了済みの障害や削除済み package の作業を残さない。[開発ツール](../todo/770_tooling_and_test_followups.md) で追跡。

## 更新・削除の基準

- 説明・見出しは日本語。ファイル名、識別子、コマンド、ログ、固有名詞は原文のまま使う。
- 日付別の作業記録を増やさず、既存の分野別文書へ現行の制約・対処・参照先を追記する。独立した話題だけ文書を追加し、この入口にリンクする。
- 実装済み・設計上の要求・未検証を区別する。版やコマンドは設定を正本にし、確認日と根拠になる path を残す。
- 重複・置き換え済みの知見は必要な内容を統合して削除する。廃止運用や対象の消滅した TODO は削除する。未検証というだけで、完了済み作業を再び TODO にしない。
- 実機確認などが残る場合は、未完了の条件だけ TODO に残す。過去のログ・失敗件数・詳細な経緯は Git 履歴や PR から参照する。
- 削除・改名時は参照を更新する。古い本文が必要なら `git log -- <旧パス>` と `git show <削除前のcommit>:<旧パス>` を使う。
