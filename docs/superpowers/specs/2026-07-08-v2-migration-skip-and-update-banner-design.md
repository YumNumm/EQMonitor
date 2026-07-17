# v2移行スキップ + アップデートバナー + Changelog Markdown化 設計書

- 日付: 2026-07-08
- 対象: `app/`（Flutter）, `packages/eqmonitor_api/`（生成クライアント）, `backend/`（submodule）
- ステータス: 承認済み（実装計画へ）

## 背景と目的

v2.6 系（旧アプリ）から v3 への移行体験を改善する。移行が可能なユーザーには冗長なオンボーディングを省略し、更新後にホームで変更内容へ誘導する。あわせて、変更履歴（Changelog）を GitHub Releases 由来の Markdown で提供・表示できるようにする。

満たすべき要件:

1. **移行成功時はオンボーディングをスキップ**。オンボーディング1枚目（デバイス登録=welcome ステップ）で移行が可能ならその場で移行を実行し、「次へ」でホームへ直行する。
2. **ホームシート上部にアップデートバナー**を表示する（例: 「v3 へアップデートしました」）。Dismissable。今後のバージョンアップ時にも表示する。タップで Changelog 画面へ遷移する。
3. **移行で飛ばした権限**（通知/位置）は、ホームシートの権限バナーで後から補完する。普通にインストールした後で権限が減った場合にも表示する。
4. **Changelog API を Markdown 化**する。バックエンドは GitHub Releases から再取得して Markdown 本文を返し、アプリはそれを Markdown 描画する。

## 現状（調査結果サマリ）

- **オンボーディング**: `app/lib/feature/onboarding/ui/page/onboarding_page.dart`。ステップ enum は `welcome → permissions → notificationSettings → complete`（`ui/model/onboarding_step.dart`）。`PageView` は `NeverScrollableScrollPhysics`、各ステップが `_StepNavigationState`（`onNext` 等）を `register` し、ボトムバーの「次へ」が `onNext` を呼ぶ。遷移はページ位置ではなく `onboardingCompletedProvider`（SharedPreferences `onboarding_completed`）+ ルータ redirect（`core/router/router.dart`）で決まる。
- **移行**: `welcome_step_page.dart` が `deviceProvisioningProvider` を監視し、`required` かつ idle のとき自動で `DeviceProvisioningNotifier.provision()` を起動。`provision()`（`feature/devices/data/notifier/device_provisioning_notifier.dart`）は legacy device id があれば `runV3MigrationWorkflow`（`feature/devices/data/workflow/device_migration_workflow.dart`）→ `markMigratedFromLegacy()` を実行。`deviceMigratedFromLegacyProvider` が移行有無を返す。
- **complete ステップ**: `complete_step_page.dart` の `onNext` が `OnboardingCompleted.completeMutation` → `complete()` → `HomeRoute().go(context)`。
- **ホームシート**: 実体は `app/lib/page/home_page.dart` の `_SheetBody`（`BasicModalSheet` でラップ）。上部の並びは `eewCards / MaintenanceBanner / WhatsNewBanner / DeviceProvisioningBanner / _LocationPermissionBanner(条件付き)`。
- **WhatsNewBanner**: `app/lib/feature/start/ui/component/whats_new_banner.dart`。現状は `startProvider.app.version.latest.showWhatsNew`（サーバフラグ）で表示可否を決め、「v{version} にアップデートしました」を表示、タップで `_WhatsNewSheet`（`latest.whatsNew.content` の Markdown モーダル）を開く。Dismiss はバージョン単位で `SharedPreferencesKey.whatsNewSeenVersion`（`whats_new_seen_version`）に保存。
- **位置権限バナー**: `_LocationPermissionBanner`（home_page.dart 内）。`backgroundLocationPermissionProvider` を監視し `always` 未満で表示。Dismiss は `locationPermissionBannerDismissedProvider`（`feature/location/data/notifier/location_permission_banner_dismissed_notifier.dart`）→ `SharedPreferencesKey.locationPermissionBannerDismissed`。**通知権限バナーは存在しない**。
- **権限 read API**: `permissionRepositoryProvider`（`feature/permission/data/repository/permission_repository.dart`）。`getNotificationPermission()`（firebase_messaging）/`getLocationPermission()`（geolocator）。`permissionProvider`（`PermissionState`）も利用可。
- **Changelog（アプリ）**: 画面 `ChangelogPage`（`feature/changelog/ui/page/changelog_page.dart`、ルート `changelog`、設定画面から `push`）。`changelogProvider`（`CachedNotifier`、ETag 対応）→ `ChangelogApiClient.getV1Changelog()`。モデル `ChangelogEntry`={version, date, url, sections(title, items[])}。
- **Changelog（バックエンド）**: `GET /v1/changelog` = `backend/api/api/src/features/changelog/routes/changelog.ts`（Hono + hono-openapi + Valibot）。レスポンス schema は `responses.ts`、データは `datasource/changelog-datasource.ts` が `backend/packages/changelog/src/index.ts` の**ハードコード配列 `CHANGELOG`** から生成。エントリ interface は `content` を持たず、`sections` と（未公開の）`whats_new` を持つ。**GitHub Releases からの生成スクリプトは未整備**（コメントのみ）。
- **アプリ版数**: `packageInfoProvider`（`core/provider/package_info.dart`、`main.dart` で override）。
- **OpenAPI/クライアント生成**: バックエンド `pnpm generate:openapi` → `backend/api/api/openapi.json`。CI が `packages/eqmonitor_api/openapi/openapi.json` へ反映し、`swagger_parser`（`packages/eqmonitor_api/swagger_parser.yaml`）+ `build_runner` で Dart クライアント生成。

## コンポーネント設計

### A. 移行成功時のオンボーディングスキップ

**対象**: `app/lib/feature/onboarding/ui/components/welcome_step_page.dart`（および必要なら `onboarding_page.dart` のナビ配線）。

**振る舞い**:

- welcome ステップでプロビジョニングが完了した時点で分岐する。
  - **移行成功（legacy device id が存在し `deviceMigratedFromLegacy == true`）**: 「次へ」ボタンのラベルを `はじめる` にし、`onNext` を「オンボーディング完了 + ホーム遷移」に差し替える。処理は complete ステップと同一:
    ```dart
    await OnboardingCompleted.completeMutation.run(
      ref,
      (tsx) async => tsx.get(onboardingCompletedProvider.notifier).complete(),
    );
    if (context.mounted) const HomeRoute().go(context);
    ```
    ページ位置ではなく `onboardingCompleted` フラグ + ルータ redirect で遷移するため、`permissions`/`notificationSettings`/`complete` の各ページを踏まずにホームへ到達する。
  - **移行なし（新規ユーザー=legacy なし）**: 従来どおり `onNext = navigation.nextPage` で `permissions` へ進む。
  - **移行失敗/リトライ中/エラー**: スキップしない。従来のエラーダイアログ/リトライ導線を維持し、成功するまで welcome に留まる。

**判定の入力**: `deviceProvisioningProvider`（status/mutation）と `deviceMigratedFromLegacyProvider`。`readLegacyDeviceId()` の有無で「移行可能だったか」を、`wasMigratedFromLegacy()` で「移行完了したか」を判断する。

**新規ユーザーのアップデートバナー抑制連携**（コンポーネント C と接続）: 新規ユーザー（非移行）のオンボーディング完了時に `whatsNewSeenVersion = 現在版` を初期化し、初回起動でアップデートバナーが出ないようにする。移行ユーザーは初期化しない（= バナーを1回見せる）。初期化処理は complete ステップの `complete()` 前後、もしくは `OnboardingCompleted.complete()` 内で「非移行時のみ」実施する。

**留意点**:

- welcome の現行実装は「プロビジョニング解決後に nav state を register」する。移行成功パスは register 時の `onNext`/label を条件分岐で差し替える形にする（自動ホーム遷移はユーザーの「次へ」押下後に限定し、勝手に画面遷移しない）。
- 移行ユーザーは `permissions` を飛ばすため OS 権限が未許可のままホームに到達しうる → コンポーネント B で補完する。

### B. ホームシートの通知権限バナー（権限リカバリ）

**対象**: 新規ウィジェット（例）`app/lib/feature/permission/ui/component/notification_permission_banner.dart` と dismiss notifier、`home_page.dart` の `_SheetBody` への差し込み。

**振る舞い**:

- `_LocationPermissionBanner` と同型。`permissionRepositoryProvider.getNotificationPermission()`（または `permissionProvider`）を監視し、通知が未許可（`authorized`/`provisional` 以外）のとき表示。
- タップで通知許可を要求（`permissionRepositoryProvider.requestNotificationPermission()`）。まだ未許可なら OS 設定アプリへ誘導。
- 右上の閉じるボタンで dismiss。dismiss は専用 notifier で永続化（`location_permission_banner_dismissed_notifier.dart` パターン）:
  - 新規キー `SharedPreferencesKey.notificationPermissionBannerDismissed`（`notification_permission_banner_dismissed`）。
- アプリ lifecycle が `resumed` に戻ったら権限状態を再評価（`permissionProvider`/repository provider の invalidate）。これにより「後から権限を切った」ケースでも再表示される。
- 表示位置は `_SheetBody` 上部、既存の位置権限バナー付近（`WhatsNewBanner`/`DeviceProvisioningBanner` と並ぶ）。

**表示条件の補足**: 移行ユーザーに限らず全ユーザーで有効。dismiss 済みなら非表示だが、権限がさらに変化した場合の再表示可否は「dismiss 済みでも未許可なら再表示」ではなく「dismiss フラグを尊重」する（位置権限バナーと同じ挙動）。※必要なら将来「権限が変化したら dismiss をリセット」に拡張可能。

### C. アップデートバナー（既存 `WhatsNewBanner` を転用・改修）

**対象**: `app/lib/feature/start/ui/component/whats_new_banner.dart`。

**変更点**:

1. **トリガーをローカルのバージョン差検知へ**:
   - `packageInfoProvider` の `version`（現在版）と `SharedPreferencesKey.whatsNewSeenVersion`（最後に確認/Dismiss した版）を比較。
   - `seenVersion != currentVersion` のとき表示。サーバフラグ `startProvider.app.version.latest.showWhatsNew` 依存は撤去する。
2. **タップ先を Changelog 画面へ**:
   - 従来の `_WhatsNewSheet` モーダル（`latest.whatsNew.content`）は廃止。タップで `const ChangelogRoute().push<void>(context)`。
3. **既読/Dismiss の保存**:
   - バナーをタップして Changelog を開いた時、および閉じるボタンで dismiss した時に `whatsNewSeenVersion = currentVersion` を保存 → 同一版では再表示しない。
4. **文言**:
   - 「v{currentVersion} へアップデートしました」（既存の `にアップデートしました` を踏襲）。アイコン/レイアウトは既存を流用。
5. **新規インストール抑制**（コンポーネント A と接続）:
   - 新規ユーザーはオンボーディング完了時に `seenVersion = currentVersion` を初期化済みのため初回は非表示。移行ユーザーは未初期化のため1回表示。既存 v3 ユーザーが本機能を含む版に更新した初回は `seenVersion` が旧版/未設定 → バナー表示（= 期待どおり「アップデートしました」）。

**依存の整理**: `startProvider`/`LatestVersion.whatsNew`/`_WhatsNewSheet` への依存を除去し、`packageInfoProvider` + `sharedPreferencesDataSourceProvider` + `ChangelogRoute` に依存する形へ単純化する。

### D. Changelog API の Markdown 化（GitHub Releases 由来）

**バックエンド** (`backend/`):

1. **生成スクリプトの新設**（例）`backend/packages/changelog/bin/generate.ts`（`package.json` に `"generate"` スクリプト追加）:
   - `gh api`（または GitHub REST `GET /repos/YumNumm/EQMonitor/releases`）で全リリースを取得。
   - 各リリースから `version`（タグから semver 抽出）、`date`（`published_at`）、`url`（`html_url`）、`content`（リリース本文 = Markdown）を導出し、`src/index.ts` の `CHANGELOG` を再生成（最新が先頭）。
   - 手動実行 → 生成物をコミットする codegen ステップ（現状のハードコード運用を置換）。
2. **データモデル**: `ChangelogEntry` interface に `content: string`（Markdown）を追加。既存 `sections` は移行期間として残す（後方互換）。API レスポンスは `content` を主として返す。
3. **API 層**:
   - `backend/api/api/src/features/changelog/model/responses.ts` の `ChangelogEntrySchema` に `content`（string）を追加。
   - `backend/api/api/src/features/changelog/datasource/changelog-datasource.ts` のマッピングに `content` を追加。ETag は本文が変わるため自然に更新される。
4. **OpenAPI / Dart クライアント再生成**:
   - `pnpm generate:openapi` → `backend/api/api/openapi.json` 更新。
   - `packages/eqmonitor_api/openapi/openapi.json` へ反映し、`swagger_parser` + `build_runner` で Dart モデル/クライアント再生成（`ChangelogEntry` に `content` フィールドが増える）。

**アプリ** (`app/`):

- `feature/changelog/ui/page/changelog_page.dart` の各エントリ描画を、`sections` の構造描画から `MarkdownBody(data: entry.content, styleSheet: ...)` に置換。`content` が空/未提供の場合のフォールバック（`sections` から生成 or プレースホルダ文言）を用意。

## データ/永続化キー

| キー | 定数 | 用途 | 変更 |
|---|---|---|---|
| `whats_new_seen_version` | `SharedPreferencesKey.whatsNewSeenVersion` | アップデートバナーの既読版数 | 用途を「サーバ版数の既読」→「ローカル現在版の既読」に転用 |
| `notification_permission_banner_dismissed` | `SharedPreferencesKey.notificationPermissionBannerDismissed`（新規） | 通知権限バナーの dismiss | 新規追加 |
| `onboarding_completed` | 既存 | オンボーディング完了 | 変更なし（welcome から早期完了を書く経路が増える） |
| `device_migrated_from_legacy` | 既存 | 移行完了フラグ | 変更なし（スキップ判定に利用） |

## エッジケース

- **移行可能だが失敗**: スキップしない。welcome に留まり再試行。
- **移行ユーザーが権限を全許可済み（旧アプリから）だが OS 上は新規扱い**: 新規インストール扱いのため権限は未許可になりうる → 通知/位置権限バナーで補完。
- **既存 v3 ユーザー（本機能導入前の版）が更新**: `whatsNewSeenVersion` 未設定 → 初回起動でアップデートバナー表示（許容。実際に更新しているため文言と整合）。
- **`content` 未提供のエントリ**（生成漏れ/旧データ）: アプリは `sections` フォールバックまたはプレースホルダを表示。
- **オフライン**: Changelog は `CachedNotifier` によりキャッシュ表示。バナー表示可否はローカル版数比較のみでネットワーク非依存。

## テスト方針

- **A（オンボーディングスキップ）**: 移行成功/移行なし/移行失敗の3分岐で、welcome の `onNext` 挙動（早期完了→ホーム / 次ページ / 留まる）を widget/unit テスト。`onboardingCompletedProvider` が完了時に true になること。
- **B（通知権限バナー）**: 権限 granted/denied で表示可否、dismiss 永続化、resumed 再評価。dismiss notifier の read/write。
- **C（アップデートバナー）**: `seenVersion == current` で非表示、差分ありで表示、タップで `ChangelogRoute` push + `seenVersion` 更新、dismiss で更新。新規オンボーディング完了で初期化され非表示になること。
- **D（Changelog Markdown）**: バックエンドは生成スクリプトの出力形（`content` を含む）とレスポンス schema の検証。アプリは `content` の `MarkdownBody` 描画、フォールバック。OpenAPI 差分と Dart クライアント再生成の追随。

## スコープ外 / フォローアップ

- バックエンドの実デプロイ（本 spec は実装+再生成まで。配信は別途）。
- `sections` の完全廃止（当面は後方互換で残置。将来別 spec で削除可）。
- 権限バナーの「権限変化時に dismiss をリセット」高度化。

## 実装順序（想定）

1. D-バックエンド（生成スクリプト + schema + datasource）→ OpenAPI/Dart 再生成。
2. D-アプリ（ChangelogPage の Markdown 描画）。
3. C（WhatsNewBanner 転用）。
4. B（通知権限バナー + キー追加）。
5. A（welcome スキップ + 新規ユーザー seenVersion 初期化）。
6. テスト・`melos run analyze`・`melos run test`。
