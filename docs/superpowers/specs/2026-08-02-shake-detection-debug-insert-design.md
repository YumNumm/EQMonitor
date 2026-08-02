# 揺れ検知デバッグ挿入 設計

日付: 2026-08-02

## 目的

デバッグ画面からプリセットの揺れ検知イベントを挿入し、ホーム地図のグリッド表示と揺れ検知カードを本番と同じ経路で確認できるようにする。

## 要件

- ホーム地図＋カードに反映する
- 本番の WebSocket / REST 揺れ検知とマージする
- プリセットをワンタップで挿入する
- 手動クリアまで残す（自動期限切れなし）
- SnackBar による案内は出さない
- 単体テストは追加しない

## 非スコープ

- 揺れ検知履歴への追加
- カスタム座標・レベル入力
- 通知 / Live Activity
- EEW 相関のシミュレーション
- 自動期限切れ

## 方針

デバッグ専用の keepAlive Notifier にイベント一覧を持ち、表示用 provider で本番イベントと結合する。AcceptedSnapshot には書き込まない（revision 競合・REST/WS 上書きを避ける）。

## データ層

### `ShakeDetectionDebugOverlay`

- 場所: `app/lib/feature/shake_detection/data/notifier/shake_detection_debug_overlay.dart`
- `@Riverpod(keepAlive: true)`
- state: `List<ShakeDetectionEvent>`（初期は空）
- API:
  - `insertPreset({required ShakeDetectionDebugPresetId id})`
  - `clear()`

### プリセット

- 場所: `app/lib/feature/shake_detection/data/logic/shake_detection_debug_preset_factory.dart`
- 純ロジック。少なくとも 1 件:
  - ID: `tokyoMultiLevelGrid`
  - 表示名: `東京・多レベルグリッド`
  - 東京付近の複数 0.25° セルに、Weaker〜Stronger が混在する `points` を持つ単一イベント
- 生成イベントの制約:
  - `eventId`: `debug-shake-<preset>-<timestamp>` など衝突しにくい ID
  - `correlatedEewEventId` / `correlatedEew`: null（visible フィルタを通す）
  - `expiresAt`: 十分遠い未来（例: now + 100 年）。手動クリアまで残すため
  - `points` 必須（グリッド集約の入力）
  - `level` / bbox (`minLat` 等) は points から整合するよう設定

### `shakeDetectionVisibleProvider`

現状:

1. 本番 `shakeDetectionProvider` から取得
2. `correlatedEewEventId == null` かつ `expiresAt > now` でフィルタ

変更後:

1. 上記の本番フィルタ結果
2. `shakeDetectionDebugOverlayProvider` の全件を末尾（または先頭）に結合
3. デバッグイベントは期限フィルタを適用しない（クリアするまで残す）

ホーム地図 (`ShakeDetectionLayer`) とホームカードは既存どおり `shakeDetectionVisibleProvider` を参照するため、追加配線は不要。

## UI

### デバッグページ

- 設定 → デバッグに「揺れ検知を挿入」を追加
- 既存「揺れ検知 Card」デバッグは見た目確認用として残す
- 新ページ内容:
  - プリセット一覧（タップで insert）
  - 現在のデバッグイベント件数
  - 「すべてクリア」ボタン
- SnackBar / 自動ホーム遷移はしない

### ルーティング

- `DebugShakeDetectionInsertRoute` を追加（例: `/settings/debug/shake-detection-insert`）
- `debug_page.dart` から遷移

## 完了条件

- デバッグ画面でプリセット挿入すると、ホーム地図に色付きグリッドが出る
- ホームの揺れ検知カードにも同じイベントが出る
- 本番イベントがある場合は両方表示される
- クリアするとデバッグ分だけ消え、本番は残る
