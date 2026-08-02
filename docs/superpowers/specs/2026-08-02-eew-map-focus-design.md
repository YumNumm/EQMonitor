# EEW地図フォーカス 設計

日付: 2026-08-02

## 目的

緊急地震速報（EEW）発表中のホーム地図フォーカスを、最新EEW単体＋関連揺れ検知範囲に限定し、不要なカメラ更新とユーザー操作との競合を減らす。

## 要件

- 自動フォーカスの最大 Zoom Level は **8**（既存 `mapAutomaticFocusMaxZoom` を利用）
- フォーカス対象は **最新の生存EEW 1件**（各イベント最新報の `reportTime` が最も新しいもの）
- フォーカス更新条件:
  - `(震源位置変化 || 揺れ検知の0.5°単位累積矩形変化) && フォーカス中`
  - 満たす場合のみ、震源 + 累積揺れ検知範囲を内包する bounds へ fit（maxZoom 8）
- 揺れ検知の取り込み:
  - `correlatedEewEventId` がフォーカス対象 EEW と一致するものだけ
  - 範囲は EEW ごとに 0.5° グリッドへ外向きスナップした矩形として保持
  - イベントごと累積し、**縮小しない**（union のみ）
- ユーザーが地図を操作したら、その EEW に対するフォーカスを外す（`isFocused=false`）
- ホームボタン:
  - フォーカス中は **無効**
  - 解除後は **有効** で、最新 EEW へ再フォーカスする
- 新規 EEW が最新になった場合、手動解除後でもその EEW へ自動フォーカスする
- フォーカス中 EEW が消滅した場合、残存の最新 EEW へ切替。全滅なら通常ホームへ戻す

## 非スコープ

- LiveMonitor 画面のフォーカス挙動
- EEW がなく未紐付け揺れ検知のみの場合の既存リアルタイムフォーカス（現状維持）
- 表示用揺れ検知グリッド（0.25°）の変更
- 予想震度領域をフォーカス対象に含めること
- 再フォーカス専用ボタンの新設（既存ホームボタンを流用）

## 方針

専用の EEW フォーカス状態（Notifier）を導入し、既存の「全生存 EEW + 未紐付け揺れ検知をまとめて fit」から、**EEW 発表中は最新 EEW 単体フォーカス**へ切り替える。

カメラ実行自体は既存の `HomeMapCameraCoordinator` / `MapAutomaticFocusController` を再利用する。

## 状態モデル

```text
EewMapFocusState
├─ focusedEventId: String?     // フォーカス対象 EEW
├─ isFocused: bool             // true=自動追従中 / false=ユーザー解除後
├─ focusedHypocenter: (lat, lng)?  // 直前に fit した震源（変化検知用）
└─ shakeBoundsByEventId: Map<eventId, GridRect>
      // EEWごと・累積・縮小しない 0.5° 矩形
```

`GridRect` は 0.5° 単位の `{minLat, maxLat, minLng, maxLng}`。

## 責務分割

| クラス | 役割 |
|--------|------|
| `EewMapFocusBoundsBuilder` | 0.5° 外向きスナップ、非縮小 union、震源+矩形から bounds 計算 |
| `EewMapFocus` (Notifier) | 最新 EEW 選択、累積矩形保持、フォーカス中/解除、更新要否判定 |
| `HomeMapCameraCoordinator` | Notifier が「更新せよ」と判断したときだけ `fit`。ジェスチャで解除を通知 |
| `HomeMapControllerCard` | `isFocused` に応じてホームボタンの enabled を制御 |

## データフロー

```text
eewAliveTelegramProvider ──┐
                           ├─→ EewMapFocus (状態更新・更新要否判定)
shakeDetectionProvider ────┘         │
                                     │ shouldFit / targetBounds
                                     ▼
                          HomeMapCameraCoordinator
                                     │
                                     ▼
                          MapAutomaticFocusController.fit (maxZoom 8)

MapLibre gesture (apiGesture)
  → MapLibreEventController
  → Coordinator / EewMapFocus.clearFocus()
```

## 更新ロジック詳細

### 最新 EEW の選択

生存 EEW 一覧から、各 `eventId` の最新報について `reportTime` が最大のものを選ぶ。

### 揺れ検知累積矩形

1. 生存 EEW それぞれについて、`correlatedEewEventId` が一致する揺れ検知を抽出（フォーカス外の EEW も累積は更新する）
2. 各揺れ検知の `min/max Lat/Lng` を 0.5° グリッドに **外向きスナップ**（範囲を内包）
3. `shakeBoundsByEventId[eewEventId]` と union（各辺は拡大方向のみ）
4. EEW が生存リストから消えたら、対応 entry を破棄
5. カメラ fit に使うのは **フォーカス対象 EEW** の累積矩形のみ

表示用グリッド（0.25°）とは独立したカメラ用計算である。

### カメラ更新判定

フォーカス中かつ次のいずれか:

- フォーカス対象 EEW の震源座標が変化した
- その EEW の累積 0.5° 矩形が変化した
- フォーカス対象 EEW 自体が切り替わった（新規最新 / 消滅後の切替 / ホームボタン再フォーカス）

上記以外ではカメラを動かさない。

### フォーカス遷移

| トリガー | 動作 |
|----------|------|
| 生存 EEW が 0→1 以上 | 最新 EEW へ自動フォーカス（`isFocused=true`） |
| フォーカス中 EEW 消滅 | 残存の最新へ切替。全滅なら通常ホームへ |
| 新規 EEW が最新になった | その EEW へ自動フォーカス（手動解除後でも再開） |
| ユーザー地図操作 | `isFocused=false` |
| ホームボタン | 最新 EEW へ再フォーカス（`isFocused=true`） |

## UI

| 状態 | ホームボタン |
|------|--------------|
| EEW フォーカス中 (`isFocused=true`) | 無効 |
| ユーザー解除後（生存 EEW あり） | 有効 → 最新 EEW 再フォーカス |
| 生存 EEW なし | 既存どおり通常ホーム復帰 |

## 既存挙動との関係

- EEW が 1 件以上ある間: 本設計の単体フォーカスに置き換える
- EEW がなく未紐付け揺れ検知のみ: 既存 `SeismicMapFocusBuilder` 経路を維持
- `autoZoom: false`: 自動 fit は行わない。ホームボタンによる明示再フォーカスは有効
- maxZoom 8: 既存 `MapAutomaticFocusController` をそのまま利用

## 境界条件

- 震源座標なし（PLUM 等）: 累積揺れ検知矩形のみで fit。どちらも無ければカメラ更新しない
- 揺れ検知なし: 震源のみ（maxZoom 8）
- 同一 0.5° グリッド内の揺れ拡大: 累積矩形不変 → カメラ不動
- ジェスチャ検知: `CameraChangeReason.apiGesture` のみをフォーカス解除対象とする（プログラムによるカメラ移動は解除しない）

## テスト

1. 最新 EEW 選択（`reportTime`）
2. 0.5° 外向きスナップと非縮小 merge
3. 更新条件: 震源変化 / 矩形変化 / フォーカス外では更新しない
4. ジェスチャ解除 → ホームボタン有効 → 再フォーカス
5. EEW 消滅時の最新切替 / 全滅時ホーム
6. 相関揺れ検知のみ内包し、未紐付け・他 EEW 相関は含めない

## 実装配置（予定）

- `app/lib/feature/home/data/model/eew_map_focus_state.dart`
- `app/lib/feature/home/data/logic/eew_map_focus_bounds_builder.dart`
- `app/lib/feature/home/data/notifier/eew_map_focus.dart`
- Coordinator / ControllerCard / MapLibreEventController の接続更新
- 対応テストを `app/test/feature/home/...` に追加
