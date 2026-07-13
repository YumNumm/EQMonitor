# 地震履歴詳細画面: 電文コメント表示 — 設計

日付: 2026-07-13
ステータス: 承認済み

## 目的

地震履歴詳細画面の地図右下にある「データソース: …」ラベル内に、電文のコメント（固定付加文・自由付加文）を表示する。例:「この地震による津波の心配はありません」。

## 背景

- 詳細API（`getV2EarthquakeEventId`）のレスポンス `api.Earthquake.telegrams` には各電文の `comments`（`TelegramComments`: `text` / `free` / `warning` / `forecast` / `additional`）が既に含まれている。
- しかし `toEarthquake` 変換（`app/lib/feature/earthquake_history/data/model/earthquake.dart`）では電文タイプのみ抽出し、コメントは破棄している。
- したがって追加のAPI呼び出しは不要で、モデル変換の拡張のみで実現できる。

## 要件（確定事項）

- 表示するコメント種別: **固定付加文（`additional`）+ 自由付加文（`free`）**。`text` / `warning` / `forecast` は対象外。
- 対象電文の選択: **VXSE53 があれば53を採用。なければ VXSE51 + VXSE52。VXSE6x（61/62）のコメントは追加で表示**。
- 表示位置: 地図右下の既存データソースラベル（ぼかし背景カード）内、「データソース: …」行の上。

## データフロー

```
getV2EarthquakeEventId → api.Earthquake.telegrams[].comments
  → toEarthquake でコメント抽出（新規）
  → ドメイン Earthquake.telegramComments（新フィールド）
  → 表示コメント選択ロジック（純粋関数）
  → 地図右下データソースラベル内に表示
```

## コンポーネント

### 1. 新モデル `EarthquakeTelegramComment`

freezed モデル。配置: `app/lib/feature/earthquake_history/data/model/earthquake_telegram_comment.dart`

| フィールド | 型 | 説明 |
|---|---|---|
| `type` | `EarthquakeTelegramType` | 電文タイプ（vxse51/52/53/61/62） |
| `reportedAt` | `DateTime` | 「最新の電文」判定用 |
| `additional` | `String?` | 固定付加文 |
| `free` | `String?` | 自由付加文 |

JSONシリアライズ対応（ドメイン `Earthquake` がキャッシュされるため）。

### 2. ドメイン `Earthquake` の拡張

`@Default([]) List<EarthquakeTelegramComment> telegramComments` を追加。`@Default([])` により、キーを持たないキャッシュ済みJSONもそのままデシリアライズできる（後方互換）。

### 3. `toEarthquake` の拡張

`api.Earthquake.telegrams` から以下の条件を満たす電文を `EarthquakeTelegramComment` に変換して詰める:

- 電文タイプが VXSE51/52/53/61/62（`toEarthquakeTelegramTypeOrNull` が非null）
- `comments` が非null かつ `additional` または `free` の少なくとも一方が非null

### 4. 表示コメント選択ロジック

純粋関数（単体テスト対象）。入力 `List<EarthquakeTelegramComment>` → 出力 `List<String>`（1要素=1行）。

1. **ベース電文の決定**: VXSE53 があれば最新（`reportedAt` 基準）の53。なければ最新の51と最新の52（存在するもののみ、両方あれば結合）。
2. **6x系の追加**: VXSE61 / VXSE62 のコメントを追加（タイプごとに最新のもの）。
3. **文言の収集**: 各電文から `additional` → `free` の順で非null・非空のものを収集し、`toHalfWidth` を適用。
4. **重複除去**: 同一文言は出現順を保って1つに（例: 51と52が同一の津波コメントを持つ場合）。

### 5. UI変更

`app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart` のデータソースラベル（現227-260行付近）:

- カード内の `Text` を `Column` 化し、選択されたコメント行を「データソース: …」行の上に追加。
- スタイルは既存と同じ `bodySmall`。
- コメントが空の場合は現状と完全に同一の表示（カードの見た目・レイアウトに変化なし）。

## エッジケース

| ケース | 挙動 |
|---|---|
| 震度DBのみのイベント（電文なし） | `telegramComments` 空 → 従来表示 |
| 全電文の `additional`・`free` が null | 同上 |
| 旧キャッシュJSON（新フィールドなし） | `@Default([])` により空 → 従来表示 |
| 51と52が同一コメント | 重複除去で1行 |

## テスト・検証

- 選択ロジックの単体テスト: 53優先 / 51+52フォールバック / 6x追加 / 重複除去 / 空入力。
- `melos run generate` でコード生成（生成ファイルはコミット対象）。
- `dart analyze` 警告ゼロ、`melos run test` パス。

## 対象外（YAGNI）

- 電文一覧画面の変更（既に `EarthquakeTelegramTile` でコメント表示済み）。
- 震度データベース側のイベントノート（`ShindoDbEventNotes`）への変更。
- `text` / `warning` / `forecast` コメントの表示。
