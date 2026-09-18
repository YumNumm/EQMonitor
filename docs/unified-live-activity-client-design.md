# 統合 Live Activity クライアント設計（デザイン案）

対象 Issue: [#1800](https://github.com/YumNumm/EQMonitor/issues/1800)

バックエンド正典:

- Valibot schema: `backend/packages/notification-common/src/types/unified-live-activity-content-state.ts`
- JSON サンプル: `backend/docs/examples/unified-live-activity-content-state.json`
- 設計: `backend/docs/unified-live-activity-design.md`

## 前提（バックエンド確定事項）

- `attributes-type` は `EarthquakeLiveActivityAttributes`、静的 Attributes は `{ "id": String }` のみ。`id` は SHA-256 文字列などの不透明値で、UUID ではない。
- Start / Update は差分ではなく ContentState 全体のスナップショット。
- `primary` は `earthquake > eew > shake_detection` の固定優先順位でバックエンドが決める。クライアントは到達予想時刻などで主表示を切り替えない。
- `eew.isFinal` / `eew.isCanceled` を Activity 終了と解釈しない。終了はバックエンドの End に従う。
- 揺れ検知のピークレベルは `ended` でも下げない。

## 現実的に到達する組み合わせ

`earthquake` は「同じ eventId の EEW を持つ既存 Event」にしか結合しないため、`earthquake != nil && eew == nil` は発生しない。ただしデコードと表示は破綻させない。

| # | shakeDetection | eew | earthquake | primary | 主なシナリオ |
|---|---|---|---|---|---|
| 1 | ○ | – | – | `shake_detection` | 揺れ検知のみ。120 秒で End |
| 2 | ○ | ○ | – | `eew` | 揺れ検知 → EEW 結合 |
| 3 | – | ○ | – | `eew` | EEW 単独 Start（揺れ検知なし） |
| 4 | ○ | ○ | ○ | `earthquake` | 揺れ検知 → EEW → 地震情報 |
| 5 | – | ○ | ○ | `earthquake` | EEW → 地震情報 |
| 6 | – | – | ○ | `earthquake` | 仕様上は発生しない。防御的に対応 |

主表示は 3 種類（揺れ検知 / EEW / 地震情報）に集約される。

## 全体方針

1. **主役は 1 つ。** `primary` が指すブロックだけがヘッダー・本文・現在地バッジを占有する。既存の EEW レイアウトは維持し、地震情報・揺れ検知の主表示を同じ骨格で新設する。
2. **副次ブロックとして出すのは EEW だけ。** `primary == earthquake` のとき、直前まで出ていた EEW の続きであることを 1 行で示す。**揺れ検知は副次表示しない**（主表示のときだけ出す）。
3. **震度は必ず「予想」か「観測」かを明示する。** 震度バッジの左上に Chip を重ね、緊急地震速報の予想値と地震情報の観測値を取り違えないようにする。
4. **色は主表示のブロックが決める。** ストライプ・ヘッダー背景・`keylineTint` を 1 か所（`UnifiedLiveActivityDisplay`）で決定し、Lock Screen と Dynamic Island で判断が食い違わないようにする。
5. **欠損値を推測しない。** 震源・規模・時刻・震度が null なら行ごと出さない。`location` が null なら現在地ブロックを出さない。

## 震度バッジの出所 Chip（共通）

震度バッジは EEW（予想）と地震情報（観測）で同じ配色（`IntensityValue` の JMA 震度階級配色）を使う。
色の意味を一貫させたうえで、**バッジの左上に出所 Chip を重ねて**区別する。

```
 ┌──────┐          ┌──────┐
 │予想│  ← Chip    │観測│
 ├──────┴──┐       ├──────┴──┐
 │         │       │         │
 │   5-    │       │   5-    │
 │         │       │         │
 └─────────┘       └─────────┘
  緊急地震速報       地震情報
```

| 主表示 | 現在地バッジの Chip | 最大震度バッジの Chip |
|---|---|---|
| `eew` | `予想` | `最大予想` |
| `earthquake` | `観測` | `最大観測` |
| `shake_detection` | Chip なし（震度ではなく揺れレベル） | Chip なし |

Chip は震度色に依存しない固定配色（濃色地に白抜き）にして、どの震度でも視認できるようにする。
ヘッダーの種別ラベル（`緊急地震速報(警報) 最終 第12報` / `震源・震度に関する情報`）と合わせ、2 か所で情報源が分かる状態にする。

## Lock Screen 共通骨格

```
┌────────────────────────────────────────────┐
│ ▨▨▨▨▨▨▨▨ ストライプ（主表示の色）           │
│ 種別ラベル 第N報           [最大観測] [ 6- ]│  ヘッダー（主表示色の背景）
│ headline                                    │
├────────────────────────────────────────────┤
│ 本文（主表示ごと）              │ 現在地     │
│                                │ 地域名     │
│                                │ [観測][5-] │
├────────────────────────────────────────────┤
│ EEW 帯（primary == earthquake のときのみ）   │
└────────────────────────────────────────────┘
```

副次表示は EEW だけに絞る。

| 主表示 | 副次帯 |
|---|---|
| `earthquake` | `緊急地震速報(警報) 最終 第12報 予想最大 6-`（`eew != nil` のときのみ） |
| `eew` | なし |
| `shake_detection` | なし（他ブロックがあれば primary が上位になる） |

揺れ検知は副次表示しない。`primary == shake_detection` のときだけ主表示として出す。

### primary = eew

既存 `EewLockScreenView` をそのまま使う。変更点は現在地・最大震度バッジに `予想` / `最大予想` Chip を足すことだけ。
`EewDisplay` の判定（取消時に予想震度・到達カウントダウンを出さない、深発の注釈、予報は震度 4 以上のみ現在地表示）は現行のまま流用する。

### primary = earthquake（新設）

```
▨▨▨▨▨▨▨▨  （最大震度の色。取消は灰）
震源・震度に関する情報              [最大観測] [ 6- ]
茨城県沖で地震 最大震度６弱
────────────────────────────────────────
発生 09/11 12:34:56                 │ 現在地
M6.8   深さ 30km                    │ 東京都２３区
                                    │ [観測] [ 5- ]
────────────────────────────────────────
緊急地震速報(警報) 最終 第12報   予想最大 6-
```

- **種別ラベル**: `informationType` 配列から最も情報量の多いものを選ぶ。優先度 `VXSE53 > IXAC41 > VXSE52 > VXSE51`。
  `VXSE51` = 震度速報 / `VXSE52` = 震源に関する情報 / `VXSE53` = 震源・震度に関する情報 / `IXAC41` = 推計震度分布。
- **magnitude**: `NORMAL` → `M6.8`、`UNKNOWN` → `M不明`、`OVER_M8` → `M8以上`、`null` → 行ごと非表示。
  `OVER_M8` は巨大地震なので、M 表示自体を強調色にする。
- **現在地**: `earthquake.location.maxIntensity` は**観測**震度。バッジ左上に `観測` Chip を重ね、EEW の予想震度と取り違えないようにする。配色は `IntensityValue` の共通配色を使う。
  `location.maxIntensity` が null（震度速報で当該地域が未発表）なら地域名だけ出し、バッジは出さない。
- **取消** (`isCanceled`): ヘッダーを灰にし、見出しを「先ほどの地震情報は取り消されました」に差し替える。震源・規模・震度は出さない。
- **`hypocenterName` が null**（震度速報のみ受信）: 震源行を出さず、`maxIntensity` と現在地だけを見せる。

### primary = shake_detection（新設）

```
▨▨▨▨▨▨▨▨  （level の色）
揺れ検知                                        [ 激 ]
関東地方で強い揺れを検知しました
────────────────────────────────────────
検知 12:35:05                       │ 東京都２３区
更新 12:36:30                       │ [ 激 ]
────────────────────────────────────────
（status == ended のとき）これまでの最大の揺れを表示しています
```

- ヘッダー右のバッジは**イベント全体**の `level`、現在地バッジは `location.level`（その地域のピーク）。両者は一致しないことがある。
- `status == ended` でもレベルを下げない。「検知終了」ではなく「これまでの最大」であることを注記で明示する。
- `location == nil` のときは現在地ブロックを出さず、地域を推測しない。
- 旧実装で使っていた「計測震度（数値）」は新形式に存在しないため廃止する。

## Dynamic Island

| 領域 | `shake_detection` | `eew` | `earthquake` |
|---|---|---|---|
| compactLeading | 揺れレベルバッジ（`location.level ?? level`） | 現行のまま（現在地予想震度 → なければ MAX、取消はシンボル） | 現在地の観測震度 → なければ MAX バッジ |
| compactTrailing | 検知時刻 | 現行のまま（到達カウントダウン → なければ 警報/予報/取消ピル） | 種別の短縮ラベル（`震度速報` / `震源・震度` など） |
| minimal | compactLeading と同じ | 現行のまま | compactLeading と同じ |
| expanded leading | 揺れレベルバッジ | 現行のまま（MAX 震度） | 最大震度バッジ |
| expanded trailing | 検知時刻 | 現行のまま（M・深さ / 取消時は報番号） | M・深さ |
| expanded bottom | 種別ラベル + headline + 現在地行 | 現行のまま | 種別ラベル + headline + 発生時刻 + 現在地行 + EEW 帯 |

compact / minimal は面積が足りないため Chip を重ねない。代わりに `compactTrailing` と `expanded` の種別ラベルで情報源を示す。
`expanded` の震度バッジには Lock Screen と同じ `予想` / `観測` Chip を付ける。

`keylineTint`:

- `shake_detection` → `level.backgroundColor`
- `eew` → 現行（警報=赤 / 予報=橙 / 取消=灰）
- `earthquake` → `maxIntensity` の配色。取消は灰

expanded の leading / trailing は TrueDepth カメラ脇の細い L 字領域なので、既存方針どおり本文は bottom に置き、領域側に padding を足さない（`DynamicIslandMetrics` を継続利用）。

## 型の構成案

```
Widget/LiveActivity/Unified/
  EarthquakeLiveActivityAttributes.swift   // Attributes { id: String } + ContentState
  UnifiedLiveActivityDisplay.swift         // 主表示の決定・色・文言（Shared へ置きテスト対象にする）
  UnifiedLockScreenView.swift
  UnifiedDynamicIslandViews.swift
  Blocks/EarthquakeBlockView.swift
  Blocks/ShakeDetectionBlockView.swift
  Blocks/EewSummaryStrip.swift        // primary == earthquake のときの EEW 帯
  Blocks/IntensitySourceChip.swift    // 予想 / 観測 の出所 Chip
```

- `EewDisplay` と同じく、**何を出すかの判断は View から切り離して `UnifiedLiveActivityDisplay` に集約**し、`WidgetModelsTests` で固定する。
- `LiveActivityInformationType` / `LiveActivityMagnitude` は `unknown` ケースを持つ独自デコードにし、バックエンドが将来値を増やしても ContentState 全体のデコードが失敗しないようにする。
- `primary` も同様に、未知の値が来たら「存在するブロックのうち `earthquake > eew > shake_detection`」へフォールバックする。

## 移行方針

- 旧 `EewLiveActivityAttributes` と `EewLiveActivityWidget` は**移行期間中残す**。移行前に開始した Activity の Update / End を受け取るため。
- 旧 `ShakeDetectionLiveActivityAttributes` / `ShakeDetectionLiveActivityWidget` は**削除済み**（統合形式へ一本化）。揺れ検知の Live Activity は最長 120 秒で End されるため、移行期間中に取り残されるリスクが小さい。
  - 配色・文言は `Widget/LiveActivity/Common/ShakeDetectionLevel.swift` に退避し、統合 LA で再利用する。
- `UNIFIED_LIVE_ACTIVITY_ENABLED` の有効化は、新 Widget 型を含むビルドが行き渡ってから。端末別の旧形式フォールバックは設けない。

## 受け入れ条件との対応

| 受け入れ条件 | 対応 |
|---|---|
| 正典サンプル・64 文字 SHA-256 ID の decode | `id` を `String` として定義。`WidgetModelsTests` で正典 JSON を decode |
| 3 ブロックの組み合わせ・null・optional | `UnifiedLiveActivityDisplay` のテストで全組み合わせを固定 |
| Magnitude 4 形態・informationType 複数要素 | 独自デコード + 表示テスト |
| 揺れ検知 → 上昇 → EEW → 地震情報の遷移 | Preview の sequence（`EewContentState.warningSequence` と同じ作り）で確認 |
| 最終報・取消で終了しない | クライアントに終了タイマーを持たせない |
| 旧形式の Update / End | 旧 EEW Widget を残す |
