# 起動最適化 設計書

- 日付: 2026-07-07
- 対象: Flutterアプリ (`app/`)
- 関連: SWRキャッシュ化 (地震履歴・お知らせ) は別スペックで扱う

## 背景・目的

アプリの起動 (Splash 含む) が遅い。原因は、起動体験に必須でない重い初期化 (走時表・観測点パラメータのパース) の完了を Splash が待ってから Home へ遷移していること、およびそれらのパースがメインスレッド同期で行われ UI をブロックすることにある。

目的は「初期化はトリガーするがナビゲーションをブロックしない」体験への転換。Splash は重い Provider の完了を待たず即 Home へ遷移し、重い Provider は起動と同時にバックグラウンドで温め、使う側が `.future` / `AsyncValue` を await して各自ローディング表示する。

あわせて、最適化の効果を定量判断できるよう、起動計測基盤を先に用意する。

## 現状の問題 (調査結果)

### Splash のゲート

`app/lib/page/splash_page.dart` は次の 3 Provider がすべて `hasValue` になるまで Home 遷移しない:

1. `kyoshinMonitorInternalObservationPointsConvertedProvider` — `parameterSetProvider` 経由で最大 10MB の JSON 5 ファイルをパース (キャッシュ miss 時)
2. `travelTimeInternalProvider` — `tjma2001.csv` (565KB) をメインスレッドで同期 CSV パース
3. `earthquakeHistoryConfigProvider` — SharedPreferences (軽量)

### 消費側の前提

- `travelTimeProvider` (同期) は `travelTimeInternalProvider` の `.requireValue` を返すため「ロード済み」前提。実際の消費者は EEW 発表時のみ動く `eewEstimatedRegionIntensityProvider` (`app/lib/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart:45`) と `travelTimeDepthMap` のみ。EEW 側は既に async のため await へ変更可能。
- 観測点パラメータの消費側 (地図の Kyoshin Monitor 表示・揺れ検知・現在地) は `.future` 参照済みで、ローディング状態を扱える。

### main.dart の runApp 前ブロッキング

`app/lib/main.dart` の `_main()` は runApp 前に次を await している。うち override 値を生まない副作用初期化は遅延可能:

- `MobileAds.instance.initialize()` (L168) — 広告 SDK。起動直後不要。
- `FlutterLocalNotificationsPlugin().initialize()` / `_registerNotificationChannelIfNeeded()` / FCM 表示オプション (L190-216) — 副作用 init。override 値を生まない。
- `FirebaseAppCheck.instance.activate()` (L171) — API 認証トークンに使用。初回 API 呼び出しとの順序に注意。

override 値が必要な処理 (SharedPreferences / PackageInfo / deviceInfo / appDir / kyoshinColorMap / telemetryDbPath / timezone) は引き続き runApp 前に必要。

### 既存の計測・送信基盤

`packages/telemetry_store` に `TelemetryEvent` (sealed/freezed) → `TelemetryRecorder.record` → DB → `ApiEventSender` (`POST /v2/device/me/telemetry/events`) のパイプラインが既にある。バックエンド (`backend/api/api/src/features/telemetry/routes/telemetry.ts`) は `app_launch` 以外の event_type を汎用の `client_telemetry` テーブル (event_type + payload JSON) に格納するため、**新イベント種別の追加にバックエンド変更は不要**。

## 設計

実装順序は「計測 → 非ブロッキング化 → main 遅延 → (計測で効果確認して) compute 化」。計測を最初に置くのは、compute 化の効果を実測で判断するため。

### Phase 1: 起動計測基盤

#### StartupProfiler

純粋な Dart クラス (Provider や Flutter に依存しない) として実装し、単体テスト可能にする。

- 責務: 起動フェーズごとの経過時間をマイクロ秒で記録・保持・シリアライズする。
- インターフェース (案):
  - `void mark(String phase)` — 起動基準時刻からの経過をマイクロ秒で記録。
  - `void measure(String phase, {required int startMicros, required int endMicros})` — 区間を明示指定して記録 (isolate/非同期区間用)。
  - `Map<String, int> get timingsMicros` — 記録済みタイミングの読み取り。
  - `Map<String, dynamic> toPayload()` — telemetry 送信用の payload 生成。
- 時刻源は注入可能にする (テスト時は固定値を渡せる)。`Stopwatch` もしくは注入した `int Function()` を使い、`DateTime.now()` 直呼びは避ける。

#### 計測ポイント

最低限:
- main 開始 → Firebase init 完了
- Firebase init → `.wait` ブロック完了
- `.wait` 完了 → runApp 呼び出し
- runApp → Home 初回フレーム (`WidgetsBinding.instance.addPostFrameCallback` 等で捕捉)
- 走時表ロード (`travelTimeInternalProvider`) の所要
- パラメータロード (`parameterSetProvider` / 観測点変換) の所要

各パースを compute 化する Phase 4 では、パース区間も個別計測する。

#### デバッグページ

`app/lib/feature/settings/children/config/debug/` 配下に起動計測ページを新設。各フェーズを ms 単位で表示 (内部保持は microsec)。既存 debug ページ群のスタイル・ルーティングに合わせる。

#### サーバ送信

`TelemetryEvent.startupTiming` を 1 種類追加する。

- payload: 各フェーズの microsec、および起動種別・端末識別に必要な最小メタ (既存 `appLaunch` を踏襲)。
- `eventType` は `startup_timing`。
- `TelemetryRecorder.record` → 既存アップロードパイプラインで `client_telemetry` に蓄積。バックエンド変更不要。
- 記録は起動をブロックしない (runApp 後に fire-and-forget、例外はガードして記録)。

#### テスト

- `StartupProfiler` の mark / measure / `toPayload` の正しさ (時刻源を注入して決定的に検証)。
- `TelemetryEvent.startupTiming` の `eventType` / `toPayload` のスナップショット的検証。

### Phase 2: 非ブロッキング化 (Splash ゲート解体)

- `splash_page.dart`: 3 Provider の待機をやめ、`ref.read` でトリガーのみ行い即 Home へ遷移する。keepAlive のためバックグラウンドでロードは継続する。
- `.requireValue` / 同期前提の消費箇所を洗い出す:
  - `travelTimeProvider` (sync, requireValue) の全消費者を async 安全化する。
  - `eewEstimatedRegionIntensityProvider:45` を `ref.read(travelTimeProvider)` から `await ref.watch(travelTimeInternalProvider.future)` へ変更する。
  - `travelTimeDepthMap` など他の同期消費者があれば同様に扱う。
- パラメータ・観測点の消費側 (地図・揺れ検知・現在地) がロード中 UI を持つことを確認し、無ければ整備する。
- Splash のエラー表示 (現状 `ErrorCard` + reload) は、各消費画面のローディング/エラー表示へ移す。

### Phase 3: main.dart のブロッキング削減

- `MobileAds.initialize`、通知プラグイン init / チャンネル登録 / FCM 表示オプションを runApp 後へ移す。
- 例外を握りつぶさないため、`unawaited` 化する処理は必ず try/catch で `talker.error` (+ Crashlytics) に記録するガードを通す。既存の telemetry uploader (`main.dart` L266-274) の try/catch パターンに倣い、共通ヘルパー化を検討する。
- 通知プラグイン init を遅延することで、起動直後の通知タップ処理に取りこぼしが出ないかを確認する。問題があれば当該初期化のみ runApp 前に残す。
- `FirebaseAppCheck.activate` は、App の初回 API 呼び出し (interceptor が App Check トークンを使用) との順序を検証したうえで、安全なら並列化/遅延する。危険なら現状維持。

### Phase 4: パースの compute 化 (計測で効果確認)

- 走時表 CSV パース・パラメータ JSON パースを `compute()` (短命 isolate) へ移す。長寿命 isolate は作らない。
- Phase 1 の計測でパース区間を前後比較する。10MB JSON は isolate 境界の転送コストで逆効果になりうるため、計測で改善が確認できたものだけ採用する。効果が出なかったものは見送り、その旨を log に残す (無言で打ち切らない)。

## テスト方針

- 単体テスト: `StartupProfiler`、`TelemetryEvent.startupTiming`、ガード付き unawaited ヘルパーの例外捕捉、async 化した走時表消費ロジック。
- 手動/実機: Splash → Home 描画時間の計測比較、機内モード・初回起動 (キャッシュ miss) で Home が即描画され各機能が個別にローディング → データ表示になること、EEW 発表時に走時表が正しく await され推定震度が出ること。

## 非対象 (Out of Scope)

- 地震履歴・お知らせ一覧の SWR キャッシュ化 (別スペック)。
- 走時表・パラメータの差分取得 API (backend、計画 A〜E)。
- 起動計測用の専用 ClickHouse テーブル/ビューの新設 (当面は汎用 `client_telemetry` に蓄積)。
