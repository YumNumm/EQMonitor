# 地震履歴 Parquet アーカイブ + ローカルキャッシュ / オフライン検索

> **ステータス**: Deferred（2026-05-16 時点で今期着手しない方針）
>
> 大規模な drift / R2 / DuckDB 統合のため、サブスク基盤（088 / 089）優先度が高く本タスクは保留。将来再着手時にはこのファイルを `docs/todo/` に戻すこと。

> **着手して実装したら削除すること。**

## 背景

現在の地震履歴はすべてサーバーサイドの REST API に依存しており、ローカルキャッシュもオフライン対応も存在しない。
古い地震データは変化しないため、時系列でパーティション分割した Parquet ファイルにアーカイブし、
クライアントが必要なチャンクをオンデマンドでダウンロード・キャッシュすることで、
オフライン参照・サーバー負荷削減・高速なローカルフィルタリングを実現できる。

参照元: [Cloudflare R2 Data Catalog + DuckDB](https://developers.cloudflare.com/r2/data-catalog/config-examples/duckdb/)

---

## 現状の課題

| 項目 | 現状 |
|---|---|
| ローカルキャッシュ | なし（Riverpod メモリのみ） |
| オフライン対応 | なし |
| 検索・フィルタ | すべてサーバーサイド API |
| 過去データの重複取得 | アプリ再起動のたびに API 再リクエスト |

**主な実装ファイル:**

- `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart`
- `app/lib/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart`
- `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart`
- `packages/eqmonitor_api/lib/src/clients/earthquake_api_client.dart`

---

## アーキテクチャ案の比較

### A. クライアント側ネイティブ DuckDB（FFI）

DuckDB を dart:ffi でモバイルに組み込み、ローカルに保存した Parquet を直接 SQL クエリ。

```
R2 Parquet（月別）
    ↓ HTTP ダウンロード
Local Storage（eq_YYYY_MM.parquet）
    ↓ DuckDB FFI（duckdb_dart）
EarthquakeHistoryRepository
    ↓
Flutter UI
```

**Pros**

- フル SQL でローカルクエリ（マグニチュード・深さ・震度・地域の複合フィルタ）
- Parquet の列指向圧縮によりストレージ効率が高い（JSON 比で 5〜10 倍の圧縮率）
- ダウンロード後は完全オフライン動作
- 将来的にサーバー検索 API の大半を廃止可能

**Cons**

- `duckdb_dart` パッケージは experimental、モバイルサポートは非公式
- バイナリサイズが iOS/Android 両対応で +30〜50 MB
- iOS xcframework の追加・App Store 審査でのサイズ問題リスク
- Parquet への追記（新着データ）のスキーマ管理が複雑
- ビルドチェーンが複雑（xcframework 追加、Android NDK 設定）

---

### B. SQLite（drift）ローカルキャッシュ + R2 Parquet アーカイブ ★推奨

バックエンドが R2 に Parquet を月次出力。アプリは drift（SQLite）で直近データをキャッシュし、
古いデータは月別 SQLite ファイルを R2 からダウンロードして参照。

```
Backend バッチ
    → R2: eq_YYYY_MM.parquet（長期保存・分析用）
    → R2: eq_YYYY_MM.sqlite（アプリ配布用）

App（オンライン）
    API（直近 3 ヶ月）→ local drift DB にキャッシュ
App（オフライン / 過去月）
    R2 から eq_YYYY_MM.sqlite をダウンロード → ATTACH して参照
```

**Pros**

- sqflite / drift は Flutter で最も成熟したエコシステム
- バイナリサイズ増加はほぼゼロ（SQLite は OS バンドル）
- drift のマイグレーション管理で安全なスキーマ更新
- 月別 SQLite を `ATTACH DATABASE` で結合クエリ可能
- 既存の Freezed モデル・Repository 層をほぼそのまま流用できる
- バックエンド側は DuckDB で Parquet → SQLite 変換（数行のスクリプト）

**Cons**

- Parquet の列指向メリットをクライアントでは享受できない（SQLite は行指向）
- バックエンドで Parquet → SQLite 変換ステップが必要
- SQLite ファイルは Parquet より大きい（2〜3 倍程度）
- 月別 SQLite の `ATTACH` 管理が増えると複雑

---

### C. バックエンド / エッジ DuckDB + クライアント JSON キャッシュ

バックエンド（または Cloudflare Worker）が R2 の Parquet を DuckDB でクエリし JSON API を提供。
クライアントは受け取った結果を Isar / drift でローカルキャッシュ。

```
R2 Parquet
    ↓ DuckDB（Cloudflare Worker または Backend サービス）
REST API（フィルタ済み JSON）
    ↓
App: drift / Isar でキャッシュ → オフライン参照
```

**Pros**

- クライアント変更が最小（既存 API の延長）
- サーバーサイドで DuckDB の columnar クエリ性能を活用
- R2 Data Catalog + DuckDB Worker で複雑な集計クエリも高速
- バイナリサイズへの影響ゼロ
- 段階的移行しやすい

**Cons**

- インターネット接続なしでは新規検索不可（キャッシュ範囲外）
- 「クライアント側でフィルタリング」の要件を完全には満たせない
- キャッシュとサーバーデータの整合管理が必要
- Cloudflare Worker の DuckDB WASM は 1.4.0+ が必要、コールドスタートに注意

---

### D. DuckDB-WASM in Flutter WebView（非推奨）

`webview_flutter` に DuckDB-WASM を組み込み JS Bridge 経由でクエリ。

**Pros**

- DuckDB-WASM は公式サポートで安定
- Flutter Web にも同じコードが転用できる

**Cons**

- WebView のオーバーヘッドが大きい（メモリ・起動時間）
- Flutter ↔ JS Bridge は JSON シリアライゼーションが必要で遅い
- iOS WebView は OPFS（Origin Private File System）に制限あり
- デバッグが非常に困難
- **実装コストに対してメリットが薄いため非推奨**

---

## 総合マトリクス

|  | A: DuckDB FFI | B: SQLite/drift ★ | C: Backend DuckDB | D: WASM/WebView |
|---|:---:|:---:|:---:|:---:|
| クライアント側 SQL | ◎ | ○ | × | ◎ |
| オフライン対応 | ◎ | ◎ | △ | ○ |
| 実装難易度 | 高 | **低** | 中 | 非常に高 |
| バイナリサイズ影響 | −50 MB | **±0** | **±0** | ±0 |
| Flutter 安定性 | △ | **◎** | ◎ | △ |
| 既存実装との親和性 | △ | **◎** | ◎ | × |
| Parquet の恩恵（クライアント） | ◎ | × | − | ◎ |
| 段階的移行 | △ | **◎** | ◎ | × |

---

## 推奨アプローチ: B（drift キャッシュ）→ 将来 A（DuckDB FFI）への移行パス

### フェーズ 1: drift ローカルキャッシュ（近期）

1. **`EarthquakeHistoryLocalRepository` インターフェースを定義する**
   - `fetchEarthquakeList()`・`upsertEarthquakes()`・`fetchEarthquakeDetail()` を抽象化
   - `EarthquakeHistoryRepository`（現 API ベース）はこのインターフェースを実装
   - 将来 DuckDB 実装に差し替えやすいよう Repository 層を分離

2. **drift スキーマ設計**
   - `earthquake_partial` テーブル（`event_id` PK、`origin_time` INDEX、`magnitude`、`max_intensity`、`depth` 等）
   - 月別パーティション用の `archived_month` カラムを持たせ、ダウンロード済みチャンクを管理する `archive_chunks` テーブルも用意

3. **キャッシュ戦略**
   - 直近 3 ヶ月: API → drift にキャッシュ（TTL 付き）
   - 3 ヶ月以上前: R2 から月別 SQLite を DL → `ATTACH` してクエリ
   - WebSocket リアルタイム更新は drift にも upsert

4. **Riverpod 統合**
   - `EarthquakeHistoryNotifier` を「オンライン API → キャッシュ保存 → drift から返す」フローに変更
   - オフライン時は drift のみを参照する分岐を追加

### フェーズ 2: R2 Parquet アーカイブ整備（バックエンド）

1. バックエンドで月次バッチ（Cloudflare Worker Cron または GitHub Actions）を実装し、
   `eq_YYYY_MM.parquet` と `eq_YYYY_MM.sqlite` を R2 に出力
2. メタデータ API（利用可能なアーカイブ月一覧・ファイルサイズ）を追加
3. アプリ側でダウンロード管理 UI（ストレージ使用量表示・手動削除）を追加

### フェーズ 3: DuckDB FFI への移行（将来・オプション）

`duckdb_dart` のモバイルサポートが安定し、バイナリサイズ問題が解決した時点で、
`EarthquakeHistoryLocalRepository` の実装を SQLite → DuckDB に差し替える。
フェーズ 1 でインターフェースを分離していれば、UI 層への影響はゼロ。

---

## やること（フェーズ 1 着手時）

- [ ] `EarthquakeHistoryLocalRepository` の抽象インターフェースを定義する
- [ ] drift スキーマ設計・マイグレーション初期ファイルを作成する
- [ ] `EarthquakeHistoryNotifier` に「取得 → キャッシュ保存」フローを追加する
- [ ] オフライン判定（`connectivity_plus` 等）と drift フォールバックを実装する
- [ ] `earthquake_history_repository.dart` の既存 `fetchEarthquakeList` を Repository 抽象化に追従させる
- [ ] バックエンド側の月次 Parquet 出力バッチを設計する（`docs/` にスペック起こし）
- [ ] アーカイブチャンクのダウンロード管理 Provider を設計する

---

## 参照

- `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart`
- `app/lib/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart`
- `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart`
- `app/lib/feature/earthquake_history/data/model/earthquake_partial.dart`
- `packages/eqmonitor_api/lib/src/clients/earthquake_api_client.dart`
- [Cloudflare R2 Data Catalog + DuckDB](https://developers.cloudflare.com/r2/data-catalog/config-examples/duckdb/)
- [duckdb_dart (pub.dev)](https://pub.dev/packages/duckdb_dart)
- [drift (pub.dev)](https://pub.dev/packages/drift)
