# 揺れ検知カード region / subregion 表示 設計

日付: 2026-08-02

## 目的

揺れ検知カードを、検知時刻・地点数ではなく「都道府県 + 短縮した EEW 予報区名」の階層表示に合わせる。

## 要件

- ヘッダーはレベル文言のみ（例: `揺れを検知`）。検知時刻は出さない
- 「○地点で検知」は出さない
- 都道府県名を大きめに表示する
- その下に短縮地域名をスペース区切りで表示する（例: `球磨 熊本 天草・芦北`）
- 複数都道府県は都道府県ごとに縦並び
- 地域名は都道府県接頭辞を落とす（例: `熊本県球磨` → `球磨`）
- 地域解決中は既存どおり細い Progress。結果が空なら地域ブロックは非表示

## 非スコープ

- `shakeDetectionRegionsProvider` の解決ロジック変更（bbox / kyoshin）
- 地図レイヤー
- 通知文言 / Live Activity
- 単体テスト追加
- デバッグ挿入機能の変更（共通カードのため見た目は自動追従）

## 方針

既存の正式名称解決は維持し、表示用の短縮だけを専用クラスに切り出す。

## UI

対象: `app/lib/feature/home/ui/component/shake_detection/shake_detection_card.dart`

- `_ShakeDetectionCardHeader`: 時刻 Textを削除
- `_ShakeDetectionCardBody`: 地点数 Textを削除
- 都道府県名 + 短縮地域名の階層のみ描画
- ホーム / Live Monitor / デバッグカード画面は同一 Widget を利用

## データ / ロジック

### `shakeDetectionRegionsProvider`

現状維持。戻り値は正式名称のまま。

- キー: 都道府県名（例: `熊本県`）
- 値: EEW 予報区名リスト（例: `熊本県球磨`）

### `ShakeDetectionRegionDisplayNameShortener`

- 場所: `app/lib/feature/shake_detection/data/logic/shake_detection_region_display_name_shortener.dart`
- Riverpod DI（既存の grid cell builder と同様）
- API:
  - `shorten({required String prefectureName, required String regionName})`
- ルール:
  - `regionName` が `prefectureName` で始まる場合、その接頭辞を除去する
  - 一致しない場合は `regionName` をそのまま返す
- カード側で provider 結果をこのクラス経由で短縮して描画する

## 完了条件

- ヘッダーに時刻が出ない
- 「○地点で検知」が出ない
- 都道府県 + 短縮地域名が画像どおりの階層で見える
- 複数県は縦に並ぶ
- デバッグ「揺れ検知 Card」画面で目視確認できる
