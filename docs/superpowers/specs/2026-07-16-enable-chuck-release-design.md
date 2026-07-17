# Release Mode Chuck 有効化設計

## 目的

Release Mode でも Chuck が HTTP 通信を記録し、デバッグ設定画面から Inspector を開けるようにする。

## 方針

- ビルドモードごとの Chuck 機能を表す小さなポリシーを追加する。
- ポリシーに従い、Dio へ Chuck の interceptor をビルドモードに関係なく登録する。
- ポリシーに従い、デバッグ設定画面へ Chuck の Inspector 導線をビルドモードに関係なく表示する。
- Chuck の通知は `kDebugMode` のときだけ表示し、Release Mode の一般利用者には露出させない。
- Chuck の依存関係、保存形式、Inspector の実装には変更を加えない。

## 検討した選択肢

1. `kDebugMode` の有効化ゲートをポリシーへ置き換える。変更範囲を小さく保ちつつ Release 相当の挙動を単体テストできるため採用する。
2. runtime の設定値で Chuck 全体を切り替える。運用要件にない状態管理が増えるため採用しない。
3. flavor や `dart-define` で切り替える。すべての Release Mode で有効にする要求と一致せず、ビルド設定も複雑になるため採用しない。

## データフロー

ビルドモードから作成した Chuck ポリシーを provider と UI が参照する。`dioProvider` が作成する Dio に Chuck interceptor を常に追加し、取得した通信を Chuck 内部へ記録する。利用者がデバッグ設定画面の Chuck 項目を選択すると、既存の `chuckProvider` が Inspector を表示する。

## エラー処理と安全性

Chuck の既存エラー処理をそのまま利用する。通知は Release Mode で無効のままとし、通常利用時の不要な通知を防ぐ。地震情報や API 応答にフォールバック値を追加する変更は行わない。

## テスト

- Release 相当の `isDebugMode: false` で、通信記録と Inspector 導線が有効、通知だけが無効となるポリシーを単体テストする。
- Debug 相当の `isDebugMode: true` で、3機能がすべて有効となることを単体テストする。
- 関連テストと静的解析を実行する。
