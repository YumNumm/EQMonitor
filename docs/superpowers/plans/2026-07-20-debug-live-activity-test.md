# Debug Live Activity Test Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Debug 画面から自デバイス向けテスト用 Live Activity の開始・更新・終了を呼べるようにする。

**Architecture:** `POST /v2/device/me/live-activity/test` 系 API を Repository 経由で呼び、専用デバッグページ（iOS のみ入口）で操作する。ContentState / Alert は空ならサーバ既定、入力時は JSON 自由編集。

**Tech Stack:** Flutter, Riverpod (`@riverpod`), HookConsumerWidget, go_router_builder, Dio + Retrofit (`eqmonitor_api`), `Result` capture

## Global Constraints

- テストコードは追加しない（ユーザー指示）
- Flutter / Dart コマンドは `mise exec --` 経由
- top-level 関数・Widget 内プライベートメソッド禁止。ロジックは class + Riverpod DI、イベントは Action class
- `!` 禁止。名前付き引数。`print` 禁止
- SharedPreferences は使わない（セッションは画面内 state のみ）
- 生成ファイル（`*.g.dart`）は手編集禁止。変更後は `mise exec -- dart run build_runner build --delete-conflicting-outputs`（app ディレクトリ）
- コミットメッセージ: `英語1単語prefix: 簡潔な日本語`（例: `feat: Live Activity テスト Repository を追加`）
- 無関係な既存差分（`base_map_pmtiles_repository.dart`, `project.pbxproj` 等）は絶対に stage / commit しない
- iOS のみ Debug Page に入口を出す（`Platform.isIOS`）

## File Structure

```text
app/lib/feature/settings/children/config/debug/live_activity/
├── data/
│   ├── model/debug_live_activity_session.dart
│   ├── repository/debug_live_activity_json_parser.dart
│   └── repository/debug_live_activity_repository.dart
└── ui/
    ├── page/debug_live_activity_page.dart
    └── action/debug_live_activity_action.dart
```

Modify:
- `app/lib/core/router/router.dart`（TypedGoRoute + RouteData）
- `app/lib/feature/settings/children/config/debug/debug_page.dart`（iOS ListTile）
- Generated: `router.g.dart`, `*.g.dart` for new `@riverpod` files

---

### Task 1: Data layer（Parser + Repository + Session model）

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_session.dart`
- Create: `app/lib/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_json_parser.dart`
- Create: `app/lib/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_repository.dart`
- Create (via build_runner): corresponding `*.g.dart`

**Interfaces:**
- Consumes: `apiClientProvider` → `api.ApiClient.device` の
  - `postV2DeviceMeLiveActivityTest`
  - `postV2DeviceMeLiveActivityTestLiveActivityIdUpdate`
  - `postV2DeviceMeLiveActivityTestLiveActivityIdEnd`
- Produces:
  - `class DebugLiveActivitySession { required String liveActivityId; required String eventId; required api.LiveActivityStartTrigger startTrigger; }`
  - `class DebugLiveActivityJsonParser` with:
    - `Result<Map<String, dynamic>?, FormatException> parseOptionalObjectJson({required String raw})` — trim 後空なら Success(null)。不正なら Failure。オブジェクト以外（配列等）は Failure
    - `Result<api.Alert?, FormatException> parseOptionalAlertJson({required String raw})` — 同上。非 null 時は `title`/`body` 必須 String
  - `@riverpod Future<DebugLiveActivityRepository> debugLiveActivityRepository(Ref ref)`
  - `DebugLiveActivityRepository`:
    - `Future<Result<DebugLiveActivitySession, Exception>> start({required api.LiveActivityStartTrigger startTrigger, api.LiveActivityContentState? contentState, api.Alert? alert})`
    - `Future<Result<api.TestLiveActivitySendResponse, Exception>> update({required String liveActivityId, required api.LiveActivityContentState contentState})`
    - `Future<Result<api.TestLiveActivitySendResponse, Exception>> end({required String liveActivityId, api.LiveActivityContentState? contentState})`

- [ ] **Step 1: Session model を作成**

```dart
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

class DebugLiveActivitySession {
  const DebugLiveActivitySession({
    required this.liveActivityId,
    required this.eventId,
    required this.startTrigger,
  });

  final String liveActivityId;
  final String eventId;
  final api.LiveActivityStartTrigger startTrigger;
}
```

- [ ] **Step 2: JSON Parser を作成**

`dart:convert` の `jsonDecode` を使い、上記 Interfaces どおり実装。Riverpod:

```dart
@riverpod
DebugLiveActivityJsonParser debugLiveActivityJsonParser(Ref ref) =>
    DebugLiveActivityJsonParser();
```

- [ ] **Step 3: Repository を作成**

`Result.capture` で Dio 呼び出しを包む。start 成功時は response.data から `DebugLiveActivitySession` を返す。

```dart
@Riverpod(keepAlive: true)
Future<DebugLiveActivityRepository> debugLiveActivityRepository(Ref ref) async =>
    DebugLiveActivityRepository(api: await ref.watch(apiClientProvider.future));
```

- [ ] **Step 4: build_runner**

```bash
cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/settings/children/config/debug/live_activity/data/
git commit -m "$(cat <<'EOF'
feat: Live Activity テスト用 Repository を追加

EOF
)"
```

---

### Task 2: UI + Action + Routing

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/live_activity/ui/action/debug_live_activity_action.dart`
- Create: `app/lib/feature/settings/children/config/debug/live_activity/ui/page/debug_live_activity_page.dart`
- Modify: `app/lib/core/router/router.dart`
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart`
- Regenerate: `router.g.dart`, action `*.g.dart`

**Interfaces:**
- Consumes: Task 1 の Repository / JsonParser / Session
- Produces:
  - `DebugLiveActivityAction` with `start` / `update` / `end` methods taking `(WidgetRef ref, BuildContext context, ...)` — SnackBar で結果表示、成功時はコールバックまたは戻り値で Session を返す
  - `DebugLiveActivityPage` (HookConsumerWidget)
  - Route: `DebugLiveActivityRoute` path `live-activity` under debug → `/settings/debug/live-activity`

**UI requirements:**
1. AppBar title: `Live Activity テスト`
2. `SegmentedButton<api.LiveActivityStartTrigger>` — EEW / 揺れ検知（初期値 EEW）
3. TextField（複数行）: ContentState JSON（hint で空ならサーバ既定と明記）
4. TextField（複数行）: Alert JSON（任意）
5. TextField: 手動 `live_activity_id`（セッション反映・手入力可）
6. Buttons: 開始 / 更新 / 終了。処理中は disabled
7. セッション表示: live_activity_id / event_id / trigger。タップで Clipboard コピー
8. 更新: ContentState 必須（空なら API 前に SnackBar）
9. 更新・終了: ID 空なら SnackBar
10. DioException 409 → SnackBar 文言に「updateToken 未登録の可能性」を含める
11. JSON 不正 → SnackBar、API 未呼び出し

- [ ] **Step 1: Action を実装**

`@riverpod DebugLiveActivityAction debugLiveActivityAction(Ref ref) => DebugLiveActivityAction();`

各メソッドで JsonParser → Repository → SnackBar。`start` は `DebugLiveActivitySession?` を返し、成功時のみ non-null。

- [ ] **Step 2: Page を実装**

HookConsumerWidget。`useState` で trigger / session / busy / controllers。リストは `ListView`（固定高さ禁止のルール遵守）。

- [ ] **Step 3: Router に追加**

`DebugDeviceAdminRoute` の近くに:

```dart
TypedGoRoute<DebugLiveActivityRoute>(path: 'live-activity'),
```

```dart
class DebugLiveActivityRoute extends GoRouteData with $DebugLiveActivityRoute {
  const DebugLiveActivityRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugLiveActivityPage();
  }
}
```

import を追加。

- [ ] **Step 4: Debug Page 入口**

デバイス管理 ListTile の直後（または近傍）、`if (Platform.isIOS)` で:

```dart
if (Platform.isIOS)
  ListTile(
    title: const Text('Live Activity テスト'),
    subtitle: const Text('開始 / 更新 / 終了（自デバイス）'),
    leading: const Icon(Icons.live_tv_outlined),
    onTap: () async =>
        const DebugLiveActivityRoute().push<void>(context),
  ),
```

- [ ] **Step 5: build_runner（app）**

```bash
cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs
```

go_router_builder / riverpod 生成が通ることを確認。

- [ ] **Step 6: Commit**

```bash
git add \
  app/lib/feature/settings/children/config/debug/live_activity/ui/ \
  app/lib/core/router/router.dart \
  app/lib/core/router/router.g.dart \
  app/lib/feature/settings/children/config/debug/debug_page.dart \
  app/lib/feature/settings/children/config/debug/live_activity/
git commit -m "$(cat <<'EOF'
feat: Debug 画面に Live Activity テストを追加

EOF
)"
```

無関係ファイルを stage しないこと。
