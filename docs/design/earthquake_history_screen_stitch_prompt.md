# 地震履歴画面 デザインリファクタ用プロンプト（Stitch向け）

このドキュメントは、地震監視アプリ「EQMonitor」の**地震履歴画面**のデザインをリファクタするために、Stitchへ渡すプロンプトとして使う想定でまとめています。そのままコピーしてStitchに貼り付けてください。

---

## 1. アプリの概要

- **アプリ名**: EQMonitor
- **ジャンル**: 地震監視・地震情報アプリ（日本向け）
- **プラットフォーム**: Flutter（iOS / Android）
- **デザイン基盤**: Material 3、useMaterial3: true
- **フォント**: Noto Sans JP（本文）、Noto Sans Mono（日時・数値）
- **テーマ**: ColorScheme ベース、ダーク/ライト対応、震度に応じたカスタム色（ユーザー設定で変更可）あり

---

## 2. 地震履歴画面の役割

- 過去の地震一覧を**日付ごとにグループ化**して表示する
- **検索条件**（期間・震央・最大震度・地域の震度・深さ・マグニチュード）で絞り込み可能
- 各項目タップで**詳細画面**へ遷移
- **プルダウンで更新**、**末尾スクロールで追加取得**（無限スクロール）

---

## 3. 現在の画面構成（リファクタ対象）

### 3.1 レイアウト構造

- **Scaffold** → **RefreshIndicator** → **CustomScrollView**
  - **SliverAppBar**（pinned）
    - タイトル: 「地震履歴」
    - アクション: 「検索条件」ボタン（OutlinedButton + Icons.search）
  - **日付ごとのセクション**（Sticky Header）
    - 各セクション: **日付ヘッダー**（例: 2025/03/19）+ **リスト**
  - 日付ヘッダー: `surfaceContainerHighest` 背景、`titleSmall` 太字、`onSurfaceVariant` 色、横16・縦8 padding
  - リスト各項目: **EarthquakeHistoryListTile** + 高さ0の **Divider**（`onInverseSurface`）
  - 末尾: **ローディング/エラー/「全件取得済み」** のいずれか

### 3.2 一覧アイテム（EarthquakeHistoryListTile）の内容

各項目に表示する情報:

| 要素 | 内容 | 備考 |
|------|------|------|
| **Leading** | 最大震度アイコン | 震度1〜7のアイコン（約40px）、震度に応じた色 |
| **Title** | 震央・震度のテキスト | 例: 「○○沖(○○)」「最大震度5強を○○で観測」、titleMedium・太字 |
| **Subtitle** | 日時 + 深さ | 「yyyy/MM/dd HH:mm頃発生 深さ 10km」、等幅フォント。長周期階級がある場合は Chip |
| **Trailing** | マグニチュード | 「M7.2」など、labelLarge・太字・等幅 |
| **背景** | 任意 | 最大震度に応じた色の薄い背景（alpha 0.4）をオプションで表示 |

- タップで詳細画面へ遷移
- `VisualDensity.compact` でコンパクト表示

### 3.3 空状態・エラー・完了状態

- **条件に合う地震が0件**: 中央にアイコン（Icons.search_off）+ 「条件を満たす地震情報は見つかりませんでした」（太字・中央揃え）
- **エラー**: カード型の ErrorCard（エラーメッセージ + 再読み込みボタン）
- **全件取得済み**: SafeArea内でアイコン（Icons.search）+ 「全件取得済みです」（太字・中央揃え）

### 3.4 検索条件モーダル（ボトムシート）

「検索条件」タップで開くモーダル:

- **タイトル**: 「検索条件」
- **背景**: `surfaceContainerLow`
- **各セクション**: チェックボックスで有効/無効 + タイトル + 説明文 + 有効時のみ子UI
  - 期間（日付範囲）
  - 震央地名（ドロップダウン）
  - 最大震度（RangeSlider、震度1〜7）
  - 地域の震度（都道府県/市区町村切り替え、地域選択、震度範囲、地図から選択・現在地はTODO）
  - 震源の深さ（0〜700km、RangeSlider）
  - マグニチュード（0〜9、RangeSlider）
- **フッター**: キャンセル / 適用（FilledButton）

---

## 4. APIレスポンスの型

地震履歴画面で利用しているAPIのレスポンス型（バックエンド eqmonitor_api パッケージの型定義ベース）です。デザイン時に「どの情報が必ずあるか」「どこが null になり得るか」の参考にしてください。

### 4.1 一覧取得 `GET /v2/earthquake` → EarthquakeListResponse

```ts
// リスト1ページ分のレスポンス
EarthquakeListResponse {
  items: EarthquakePartial[];      // 地震の配列
  next_token?: string;             // 次ページ用カーソル（base64）。無い場合は全件取得済み
  next_pooling?: string;          // ポーリング用カーソル（base64）
}
```

### 4.2 一覧アイテム EarthquakePartial（表示の元データ）

```ts
EarthquakePartial {
  event_id: string;                // イベントID（yyyyMMddHHmmss形式）
  status: TelegramStatus;         // NORMAL | TRAINING | TEST
  origin_time_precision: OriginTimePrecision;  // MILLISECOND | SECOND | MINUTE | HOUR | DAY | MONTH
  datasource: EarthquakeDatasource;  // JMA_INTENSITY_DATABASE | JMA_DISASTER_INFORMATION_XML
  origin_time?: DateTime;        // 発震時刻（null のときは arrival_time を表示に使う）
  arrival_time?: DateTime;        // 検知時刻
  hypocenter?: Hypocenter;       // 震源情報（震央名・座標・マグニチュード・深さ）
  intensity?: Intensity;          // 震度情報（最大震度・都道府県別・長周期階級など）
  estimated_intensity_tile?: string;  // 推計震度PMTilesのURL
}
```

### 4.3 震源 Hypocenter

```ts
Hypocenter {
  value: CodeName;                 // { code, name } 震央地名（例: 〇〇沖）
  coordinates: Coordinate;        // 緯度・経度
  magnitude: Magnitude;           // { type, value? } マグニチュード（type=NORMAL のとき value が M値）
  depth: Depth;                   // { type, value? } 深さ（type=NORMAL のとき value が km）
  detailed?: CodeName;            // 震央の詳細地名（例: 〇〇）
  auxiliary?: HypocenterAuxiliary;
}
// CodeName = { code: string, name: string }
// Magnitude.value / Depth.value が無い場合は「不明」「700km以上」等の表現になる
```

### 4.4 震度 Intensity

```ts
Intensity {
  max_intensity: JmaIntensity;     // 最大震度（1〜7の階級、例: 5強）
  prefectures: IntensityItem[];   // 都道府県別震度
  regions: IntensityItem[];       // 地域別
  max_lpgm_intensity?: JmaLpgmIntensity;  // 最大長周期地震動階級（任意）
}
// IntensityItem = { value: CodeName, max_intensity?, max_lpgm_intensity? }
```

### 4.5 詳細取得 `GET /v2/earthquake/:eventId` → EarthquakeDetailResponse

```ts
EarthquakeDetailResponse {
  earthquake: Earthquake;  // EarthquakePartial に telegrams[] が加わった詳細型
}
// Earthquake = EarthquakePartial の拡張（telegrams で電文履歴を持つ）
```

- 一覧では **EarthquakePartial** のみ使用。表示に使うのは `event_id`, `origin_time`/`arrival_time`, `hypocenter`, `intensity`, `datasource` など。
- `hypocenter` / `intensity` は **null になり得る**（震源・震度未確定の電文など）。その場合は震央名・震度・M・深さを表示しないか「不明」扱い。

---

## 5. デザイン上の制約・方針（リファクタ後も維持したい点）

- **Material 3** のコンポーネントと ColorScheme を前提とする
- **アクセシビリティ**: 十分なコントラスト、タップ領域、読み上げを考慮
- **震度色**: アプリ内で震度ごとの色が定義されており、一覧の背景やアイコンに利用している（リファクタ後も「震度で色分け」の概念は維持したい）
- **情報の優先度**: 震央・発震時刻・最大震度・マグニチュードが主要。長周期階級は補足
- **日本語**: すべてのラベル・メッセージは日本語

---

## 6. リファクタで検討してほしい観点（例）

- 一覧アイテムの**情報階層**と**視認性**の改善（震度・時刻・Mをよりスキャンしやすく）
- **日付セクション**の見せ方（ストickyヘッダーのスタイル、日付のフォーマット）
- **空状態・エラー・完了**の表現（アイコン・コピー・レイアウト）
- **検索条件**の開き方とシート内の情報設計（項目数が多いためグルーピングやナビゲーションの検討）
- **プルトゥリフレッシュ**や**無限スクロール**のフィードバックの分かりやすさ
- 他画面（ホームの地震履歴カード、詳細画面）との**一貫性**

---

## 7. 依頼文（Stitchにそのまま送る用）

```
地震監視アプリの「地震履歴」画面のデザインをリファクタしてほしいです。

【画面の役割】
- 過去の地震を日付ごとにグループ化して一覧表示
- 検索条件（期間・震央・震度・地域・深さ・マグニチュード）で絞り込み可能
- 各項目タップで詳細へ遷移。プルで更新・下方向スクロールで追加読み込み

【現在の構成】
- 画面上部: タイトル「地震履歴」+ 「検索条件」ボタン
- 日付ごとのストickyヘッダー + リスト（各項目は「震度アイコン / 震央・震度テキスト / 日時・深さ / M」のListTile、震度に応じた薄い背景色あり）
- 0件時・エラー時・全件取得済み時の状態表示あり
- 検索条件はボトムシートで、期間・震央・最大震度・地域の震度・深さ・マグニチュードをチェックで有効化して設定

【技術前提】
- Material 3、ColorScheme、日本語、モバイル（iOS/Android）

【お願い】
上記を踏まえ、情報の見やすさ・操作の分かりやすさ・空/エラー/完了状態の表現・検索条件の使いやすさを改善するデザイン案（ワイヤーまたはUI案）を出してください。震度による色分けは維持したいです。
```

---

以上です。必要に応じて「7. 依頼文」だけをStitchに送るか、2〜6を要約して添えると、より意図が伝わりやすくなります。
