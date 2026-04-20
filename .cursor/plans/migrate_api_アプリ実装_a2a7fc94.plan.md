---
name: migrate API アプリ実装
overview: v2.6.0 から v3 への移行を、flutter_udid 由来デバイス ID で GET→PUT→POST /migrate とする（old_device_key 取得時のみ）。取得できなければ移行は行わずオンボーディングへ。耐久ステップは packages/workflows。オンボーディング UI は未実装のため別 TODO。
todos:
  - id: workflows-package
    content: packages/workflows を新設し WorkflowStep / 永続化 / 再開可能な step.do を実装する
    status: pending
  - id: dio-device-header
    content: Dio Interceptor で /v2/device/ 配下（PUT デバイス登録除く）に X-eqmonitor-device-id を付与する
    status: pending
  - id: device-register-flow
    content: GET で未登録(404)を確認してから PUT する手順を Repository と Workflow ステップに落とす
    status: pending
  - id: repo-migrate
    content: DeviceRepository に migrate と GET/PUT の明示フローを追加し DioException を分岐する
    status: pending
  - id: v26-to-v3-workflow
    content: old_device_key 取得時のみ v3 移行 Workflow を起動（起動タイミングはアプリ側で決める）
    status: pending
  - id: onboarding-after-migration-skip
    content: old_device_key 未取得時に遷移する v3 オンボーディングフロー（画面・ルーティング・完了条件）— 未実装、別途実装 TODO
    status: pending
isProject: false
---

# v2.6.0 → v3 マイグレーション実装計画

## スコープの整理

- **過去**: v2.6.0 リリース前に入っていた「それ以前 → v2.6.0」向けクライアント処理（例: 通知リモート設定の初期セットアップ）は、**今回の v3 移行とは別物**。
- **今回**: **v2.6.0 から v3（現在実装中のバックエンド）へ**のマイグレーション。サーバー側は `POST /v2/device/{deviceId}/migrate`（リクエストボディの `old_device_id` に、ローカルから読んだ旧デバイス ID を渡す）が中心。

## デバイス ID と登録順序（必須仕様）

- **デバイス ID**は既存の [`deviceIdProvider`](app/lib/core/provider/device_id.dart) と同様、**`flutter_udid` + SHA512 を UUID 形式にした値**を用いる（ユーザー指定どおり）。
- **登録前に GET**: `GET /v2/device/{deviceId}` で **存在しない（404）ことを確認してから** `PUT /v2/device/{deviceId}` する。  
  - 既に存在する（200）場合は **PUT しない**（上書きや不要な更新を避ける）。  
  - `fetchOrRegister` の「GET 失敗なら PUT」だけでは **意図がコード上不明瞭**なので、**ワークフロー内ではステップを分けて明示**する。

## バックエンド前提（再掲）

- `POST .../migrate` は [`deviceAuthMiddleware`](backend/api/api/src/features/device/middleware/device-header-auth.ts) 対象のため、**新 DB にデバイスが存在**し、**`X-eqmonitor-device-id` = path の deviceId** が必要。
- よって **GET(404 確認) → PUT → POST migrate** の順で、**PUT またはそれ以前の完了後**にのみ migrate が可能。

## 耐久性: `packages/workflows` の新設

[Cloudflare Workflows Workers API](https://developers.cloudflare.com/workflows/build/workers-api/) の **`WorkflowStep`** を参考に、**クライアント側**で「ステップ単位の冪等・再開」を行う小さなライブラリを [`packages/workflows`](packages/workflows) に追加する（**Cloudflare 上で動かす前提ではなく、API 形状の参考**）。

### 参考にするインターフェース（概念）

- **`WorkflowEntrypoint`**: `run(WorkflowEvent<Params> event, WorkflowStep step)` を実装し、制御フロー（if / try / await）は通常どおり書ける。
- **`WorkflowStep.do(name, callback)`**（ドキュメントの `step.do` に相当）:
  - **名前付きステップ**（最大 256 文字相当の制約は任意でよい）。
  - **コールバックの戻り値はシリアライズ可能なものに限定**（プリミティブ、`Map`/`List` 等。Cloudflare ドキュメントの structured-clone 可能な範囲と同趣旨）。
  - **同一インスタンス・同一 `name` のステップは、一度成功したら結果を永続ストアから復元しコールバックを再実行しない**（耐久ステップ）。
  - 失敗時は **再実行時に同じステップから再試行**できるようにする（オプションでリトライ設定を足してもよい）。

### Dart での構成案

- **`WorkflowPersistence`（抽象）**: インスタンス ID、現在のステップ名、完了済みステップと JSON 結果を読み書き。
  - 実装例: `SharedPreferences` / `shared_preferences` 既存レイヤ、または軽量なファイル JSON（パッケージは **Flutter に依存しない pure Dart** を優先し、アプリ側で具体実装をバインドしてもよい）。
- **`WorkflowRuntime` / `WorkflowRunner`**: 永続化を注入し、`run` を **中断から再開**（アプリ再起動後も同じ `instanceId` で `run` を呼ぶと未完了ステップから続行）。
- **バインド**: ワークフロー定義（コールバックに `DeviceRepository` 等を閉じ込めないよう、**引数で依存を渡す** or **ファクトリ**）と、永続化ストアを組み合わせて実行。

### v3 移行ワークフロー例（ステップ分割）

名前は例。実装時に調整可。

1. **`ensureDeviceAbsent`**: `GET /v2/device/{id}` → 404 なら次へ。**200 なら登録スキップフラグ**をステップ結果に含める。
2. **`registerDevice`**: 上で「未登録」のときだけ `PUT`。既に登録済みなら no-op。
3. **`migrateLegacySettings`**: **`old_device_key` から旧デバイス ID を読めた場合のみ** `POST /migrate`（body の `old_device_id`）。**読めない場合は v3 移行ワークフロー全体を実行せず**、後述のオンボーディング分岐へ（migrate API は呼ばない）。
4. **`markLocalComplete`**: ローカルに「v3 移行完了」を保存（移行経路を踏んだ場合のみ）。

各ステップは `step.do` でラップし、**アプリが落ちても**最後に完了したステップの次から再開できるようにする。

## `old_device_key` と分岐（プロダクト仕様）

- v2.6 系ストレージから **`old_device_key`（またはそれに相当するキー）で旧デバイス ID を読む**。読み取れた値を **`MigrateRequest.old_device_id`** に載せる。
- **`old_device_key` が読み取れない場合**:
  - **v3 向けサーバー移行（GET→PUT→POST migrate）およびその耐久ワークフローは一切行わない**（完全スキップ）。
  - **オンボーディングフローへ遷移**させる（新規ユーザー相当の v3 体験）。
- **オンボーディング**（画面・ナビゲーション・完了条件）は**未実装**。実装は別タスクとし、計画 TODO `onboarding-after-migration-skip` に置く。

## 知見の記録（[knowledge-management](.cursor/rules/knowledge-management.mdc)）

- 本移行の**確定した挙動**（`old_device_key` 分岐、オンボーディング遷移、ストレージキー名など）は、作業完了時に `docs/knowledge/{YYYYMMDD}_v26-v3-migration.md` に簡潔に残す（ルールどおり git 管理）。

## アプリ層の既存タスク（継続）

- **Dio**: `X-eqmonitor-device-id`（`PUT` 以外の `/v2/device/` 系）。前回計画どおり必須。
- **`DeviceRepository`**: `getDevice` / `putDevice`（名称は既存に合わせる）/ `migrateFromLegacy` を整理し、**ワークフローから呼び出しやすい**形にする。

## バックエンド考慮漏れ（再掲・短縮）

- **409**: 旧 Supabase 側で既に `migrated_at` 済み。**冪等完了**としてよいか判断。
- **400**: サーバーに `SUPABASE_*` が無い等。**migrate ステップ**でユーザー向けメッセージを分ける。
- **移行内容の完全一致**: [`MigrationWriter`](backend/api/api/src/features/migration/datasource/migration-writer.ts) はデフォルト挿入＋一部コピー。**「v3 で全部同じ」**とは表現しない。

## 依存関係の追加

ユーザールールに従い、**`pubspec.yaml` を手編集せず**、`mise exec -- dart pub add` / `dart pub workspace add` 等で `packages/workflows` を workspace に追加し、`app` から依存追加する。

## 成果物チェックリスト

- [ ] `packages/workflows`: `WorkflowStep` 相当 API + 永続化 + 再開
- [ ] Dio: `X-eqmonitor-device-id`（PUT 登録除く）
- [ ] v2.6→v3 用ワークフロー: **old_device_key 取得時のみ** GET(404)→PUT→POST migrate
- [ ] **old_device_key 未取得** → 移行スキップ + **オンボーディングへ**（オンボーディング本体は TODO `onboarding-after-migration-skip`）
- [ ] 単体テスト: ワークフローが同一ステップを再実行しないこと、リトライ後に続くこと
- [ ] `docs/knowledge/` に v2.6→v3 移行の知見を 1 ファイル記録（knowledge-management）
