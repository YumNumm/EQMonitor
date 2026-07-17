# Push Token Lifecycle Design

## 目的

アプリ起動時に取得できた通知トークンを必ずサーバへ upsert し、アプリ起動中のトークン更新も継続的に反映する。ネットワーク障害時は成功するまで自動再試行する。

サーバでは最終 upsert から 30 日以上経過したトークンを日次削除し、結果を Argo Workflows から Slack へ通知する。Live Activity は iOS 18 以上の APNs Broadcast Channel 方式に統一し、配信に使っていない per-activity update token 経路を廃止する。

## 対象トークン

| 種別 | Android | iOS 17 以下 | iOS 18 以上 |
| --- | --- | --- | --- |
| FCM | 同期する | 同期する | 同期する |
| APNs 通知 | 対象外 | 同期する | 同期する |
| APNs push-to-start | 対象外 | 取得・監視・送信しない | 同期する |

各 Live Activity に発行される per-activity update token は対象外とする。Live Activity の開始には push-to-start token、更新・終了には APNs Broadcast Channel ID を使用する。

## クライアント設計

### 起動時同期

現在の SharedPreferences に保存したトークンハッシュによる差分判定を削除する。次のキーも削除する。

- `last_fcm_token_hash`
- `last_apns_token_hash`
- `last_apns_push_to_start_token_hash`

アプリの ProviderContainer が作成され、デバイスプロビジョニングが完了した後に、プラットフォームで利用可能なトークンソースを購読する。各ソースが最初に返した非空トークンは、過去の起動時に同じ値を送信済みでも必ず upsert する。

永続的な同期済み状態は持たない。起動セッション内だけ、トークン種別ごとに次を保持する。

- 最新の取得値
- 最後に同期成功した値
- 同期状態
- 現在の試行番号と次回試行時刻

これにより、サーバが配信失敗や 30 日保持ルールで行を削除した場合も、次のアプリ起動で同じトークンを再登録できる。

### 独立同期ワーカー

FCM、APNs 通知、push-to-start に独立した常駐同期ワーカーを割り当てる。ワーカーは Riverpod の配線や API 型に依存しない単一責務のクラスとし、同期関数、待機関数、時刻取得を注入可能にする。

各ワーカーは次の規則で動作する。

1. 非空トークンを受け取る。
2. 同一セッションで同期成功済みの同値なら何もしない。
3. それ以外は対応する API へ upsert する。
4. 成功時は同期済み値と状態を更新する。
5. retryable な失敗時はバックオフ後に最新値を再送する。
6. retry 不可の失敗時は失敗状態で停止する。
7. 新しい値を受け取った場合は、retry 不可で停止中でも新しい同期サイクルを開始する。

3 種類のワーカーは互いを待たない。一種類のエラーやバックオフが、他のトークン同期を止めてはならない。

### 最新値の優先

retry 待機中に新しいトークンが到着した場合、待機を解除して古い値を破棄し、最新値を直ちに同期する。送信中に値が変わった場合は送信中の呼び出しを無理に中断せず、その完了後に最新値を同期する。

古い値の送信が成功しても、その間に新しい値が到着していればワーカー全体を同期済みにはしない。最新値の成功だけを同期完了とみなす。

### リトライ

retryable なエラーは、アプリ起動中に成功するまで再試行する。待機時間は次の指数バックオフとし、上限を 60 秒にする。

```text
2s, 4s, 8s, 16s, 32s, 60s, 60s, ...
```

`Retry-After` が指定された場合も 60 秒を上限にする。ワーカー破棄時は待機と次回試行をキャンセルする。

対象となるのはネットワーク到達不能、タイムアウト、HTTP 5xx、HTTP 429 など、既存の例外マッピングで retryable とされた失敗である。HTTP 400 系の不正リクエストは自動再試行しない。HTTP 401 は既存どおりプロビジョニング状態を解除し、再認証・再登録フローへ戻す。

既存のデバイスプロビジョニング用 `RetryController` の最大試行回数は変更しない。無制限リトライは push token 同期ワーカーだけのポリシーとする。

### iOS 18 制限

push-to-start は iOS 18 以上でのみ有効にする。Dart 側では注入可能な capability provider で OS major version を判定し、iOS 17 以下では push-to-start の初期値取得と更新 Stream の生成を行わない。

Swift 側にも `if #available(iOS 18.0, *)` を置き、Dart 側の誤配線があっても iOS 17 以下で ActivityKit の push-to-start token を取得・監視しない。OS バージョン文字列の解析だけを安全性の境界にしない。

### per-activity update token の削除

次のクライアント経路を削除する。

- EEW と揺れ検知 Activity の `pushTokenUpdates` 監視
- update token を Dart Stream に変換する provider
- update token 同期 service と起動 wiring
- `DeviceRepository.syncLiveActivityUpdateToken`
- update token 受信テレメトリ

push-to-start token の初期値取得と更新監視は残す。

## サーバ設計

### Token upsert

`device_fcm_token` と `device_apns_token` に次の列を追加する。

```sql
updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
```

両テーブルの `updated_at` に cleanup 用 index を追加する。FCM、APNs 通知、push-to-start のいずれも、既存行と同じ値を upsert した場合を含め、成功した upsert ごとに `updated_at = now()` を設定する。

トークンの unique 制約と、同一トークンが別デバイスへ移動した場合に旧所有行を削除する現行動作は維持する。

### 即時削除

notification-sender が APNs または FCM から無効トークン応答を受け、Redis Streams 経由で該当行を削除する現行経路は維持する。日次 cleanup はこの経路の代替ではなく、長期間アプリを起動していない端末を除外する補完策である。

### 30 日 cleanup

実行開始時に UTC の基準時刻を一度だけ確定し、次を削除対象とする。

```text
updated_at <= execution_started_at - 30 days
```

削除単位はトークン行であり、デバイス本体、認証情報、通知設定は削除しない。例えば APNs 通知だけが最近 upsert されている場合、古い push-to-start 行だけを削除する。

FCM と APNs の削除を一つの DB transaction で実行する。処理結果は次の構造で返す。

```json
{
  "status": "success",
  "startedAt": "2026-07-14T00:00:00.000Z",
  "finishedAt": "2026-07-14T00:00:01.000Z",
  "cutoff": "2026-06-14T00:00:00.000Z",
  "deleted": {
    "fcm": 10,
    "apnsNotification": 4,
    "apnsPushToStart": 3,
    "total": 17
  }
}
```

cleanup は notification-resolver のコンテナイメージに、常駐 resolver とは独立した CLI entrypoint として同梱する。これにより既存の DB 接続設定、database package、デプロイ用イメージを再利用し、常駐プロセスへ日次処理の責務を混在させない。

### per-activity update token の削除

現行 backend では per-activity update token は配信先として使用されず、開始から token 受信までの遅延計測専用である。次を同時に削除する。

- update token の GET、PUT、DELETE API
- `live_activity_update_token` テーブルと migration
- notification-resolver による空レコード作成
- token 受信遅延 Histogram
- token 未受信 Gauge
- OpenAPI 契約と生成 Dart client/model

Live Activity の start message と Broadcast update/end messageについては回帰テストを残す。

## Argo CronWorkflow

EQMonitor Helm chart に `device-token-cleanup` という名前の token cleanup 用 `CronWorkflow` を追加する。

| 設定 | 値 |
| --- | --- |
| schedule | `30 3 * * *`（毎日 03:30） |
| timezone | `Asia/Tokyo` |
| concurrencyPolicy | `Forbid` |
| startingDeadlineSeconds | `300` |
| retry | 失敗時 2 回 |
| serviceAccountName | `argo-workflow` |
| successfulJobsHistoryLimit | `3` |
| failedJobsHistoryLimit | `3` |

production で有効にする。develop は値で明示的に有効・無効を選択でき、デフォルトでは無効とする。cleanup コンテナは `DATABASE_URL` を既存の `eqmonitor-secrets` から取得する。

### Slack 実施レポート

`CronWorkflow` の `onExit` handler は成功・削除 0 件・失敗を含む全実行について Slack Incoming Webhook へレポートする。

成功レポートには次を含める。

- Workflow 名と namespace
- phase
- 開始・終了時刻と所要時間
- cutoff
- FCM 削除件数
- APNs 通知削除件数
- push-to-start 削除件数
- 合計削除件数

失敗レポートには Workflow 名、namespace、phase、失敗 step を含める。Webhook URL は Helm values やログへ出さず、各 EQMonitor namespace の Secret `device-token-cleanup-slack` の `webhook-url` key から参照する。

cleanup step と Slack step は分離する。cleanup が成功して Slack だけ失敗した場合も Workflow 上で通知失敗を確認できるようにする。Secret の作成方法、key 名、手動実行コマンド、Workflow と Slack の確認方法を運用知見として `docs/knowledge/` に記録する。

## 状態表示と観測

既存のデバイスプロビジョニング banner と debug page は、3 種類のワーカー状態を集約して表示する。

- 未取得
- 同期中
- retry 待機中と次回時刻
- 同期済み
- retry 不可エラー
- プラットフォーム対象外

例外文字列をそのまま UI に表示しない。既存の `DeviceProvisioningException.userMessage` を使用する。同期失敗 telemetry の記録や upload が失敗しても、token upsert とリトライを止めない。

## テスト設計

### Flutter / Dart

TDD で次を検証する。

- 各起動セッションの初回値を必ず同期する
- 同一セッション中の同値を重複送信しない
- 更新値を再同期する
- retry 待機中の新値が古い値を置き換え、待機を解除する
- 送信中の新値を送信完了後に同期する
- retryable 失敗を 6 回を超えて継続する
- バックオフが 60 秒で止まる
- retry 不可エラーではループしない
- 新値または手動操作で retry 不可状態から再開する
- 一種類の失敗が他のワーカーを止めない
- provider 破棄時に待機と次回試行を止める
- iOS 17 以下では push-to-start取得・監視・APIを呼ばない
- iOS 18 以上では push-to-start の初期値と更新値を同期する
- Android、iOS 17 以下、iOS 18 以上の対象種別
- API endpoint、APNs token type、APNs environment の変換
- HTTP 401 時の deprovisioning
- telemetry 失敗が同期を壊さない

FFI callback 自体は CI の Dart unit test だけでは再現できない。Swift 側の availability guard を iOS build で検証し、Dart 側は capability と token source を注入して全分岐をテストする。

### Backend

次を unit test または DB integration test で検証する。

- 同値 upsert でも `updated_at` が更新される
- cutoff と同時刻を含む 30 日以前だけを削除する
- 新しい行を残す
- FCM、APNs 通知、push-to-startを独立集計する
- 一部だけ古いデバイスでは古い行だけを削除する
- cleanup の再実行が冪等である
- transaction 失敗時に部分削除しない
- CLI の成功 JSON と失敗終了コード
- update token 経路削除後も start と Broadcast update/end が生成される

### デプロイ

Helm render test または同等の manifest 検証で次を確認する。

- schedule と timezone
- `concurrencyPolicy: Forbid`
- retry、履歴保持、GC
- cleanup image と command
- DB Secret 参照
- `onExit` と Slack Secret 参照
- production で有効、develop でデフォルト無効

## 検証コマンド方針

Flutter と Dart のコマンドはすべて `mise exec --` 経由で実行する。対象 test に加え、app 全体の analyze/test、backend の typecheck/lint/test、migration 整合性、Helm template を確認する。

ActivityKit の実機 token 発行、APNs Broadcast capability、Slack Incoming Webhook の到達は CI だけでは保証できない。リリース前に iOS 17 と iOS 18 の実機、Argo Workflow の手動 submit、Slack 着信を確認する。

## 完了条件

- アプリ起動ごとに利用可能な全 token が再 upsert される
- token 更新時に最新値が自動同期される
- retryable な障害は成功まで自動再試行される
- iOS 17 以下から push-to-start token が送信されない
- per-activity update token 経路がクライアント・サーバ双方から削除される
- 30 日以上 upsert のない token 行が日次削除される
- 全 Workflow 実行結果が Slack へ通知される
- 対象 unit test、integration test、analyze、typecheck、lint、Helm render が通る
