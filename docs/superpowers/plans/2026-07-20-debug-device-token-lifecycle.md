# Debug Device Token Lifecycle Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** デバッグ「デバイス・通知」画面に、プッシュトークン種類別の強制再送信と、デバイス削除・再プロビジョニング操作を追加する。

**Architecture:** Worker に `forceResync()` を追加し、Notifier 経由で種類別に呼び出す。削除・再プロビジョンは `DeviceProvisioningNotifier` に正規 API として追加し、確認ダイアログ付き Flow から Mutation 実行する。UI は既存 `DebugDeviceSettingsPage` のみ拡張する。

**Tech Stack:** Flutter / Dart, Riverpod 3 (Mutation), flutter_hooks, HookConsumerWidget

## Global Constraints

- 配置は既存の `DebugDeviceSettingsPage`（`/settings/debug/device-settings`）のみ。新ルート禁止
- トークン再送信は FCM / APNs（通知） / Push to Start ごと。同期済みでも強制 upsert
- 再プロビジョニングは「サーバー削除 → ローカルクリア → 再登録」
- 削除単体はサーバー削除後、ローカル（Bearer / `device_provisioned`）もクリア
- `debug_device_admin` と本番 `DeviceProvisioningBanner` は変更しない
- Flutter / Dart コマンドは常に `mise exec --` 経由
- `!` 禁止、top-level / クラス内プライベートメソッド禁止（既存ファイルの既存プライベートは触らない）、Widget に関数/getter 禁止
- 依存は `flutter pub add` / `mise exec --` 経由のみ（pubspec 手編集禁止）
- コミットメッセージ: 英語1単語 prefix + 簡潔な日本語1行。コミット後 push
- 生成ファイル（`.g.dart`）は手編集禁止。`build_runner` で再生成

## File Structure

| ファイル | 責務 |
|----------|------|
| `app/lib/feature/devices/data/repository/push_token_sync_worker.dart` | `forceResync()` |
| `app/lib/feature/devices/data/model/push_token_force_resync_result.dart` | 再送信結果 enum |
| `app/lib/feature/devices/data/notifier/push_token_sync_notifier.dart` | 種類別 `forceResync` + Mutation |
| `app/lib/feature/devices/data/notifier/device_provisioning_notifier.dart` | `deleteDeviceAndClearLocal` / `reprovision` + Mutation |
| `app/lib/feature/devices/data/flow/debug_device_lifecycle_flow.dart` | 確認ダイアログ → Mutation → SnackBar |
| `app/lib/feature/devices/ui/page/debug_device_settings_page.dart` | デバイス操作セクション・トークン再送信 UI |
| `app/test/feature/devices/push_token_sync_worker_test.dart` | `forceResync` テスト追加 |

---

### Task 1: PushTokenSyncWorker.forceResync

**Files:**
- Modify: `app/lib/feature/devices/data/repository/push_token_sync_worker.dart`
- Test: `app/test/feature/devices/push_token_sync_worker_test.dart`

**Interfaces:**
- Consumes: 既存 `accept` / `retry` / `InterruptibleBackoff`
- Produces: `void forceResync()` — `_latestToken` が無い場合は no-op。ある場合は `_lastSyncedToken` / `_blockedToken` をクリアし、同一トークンでも再 upsert する

- [ ] **Step 1: Write the failing tests**

`app/test/feature/devices/push_token_sync_worker_test.dart` の `group('PushTokenSyncWorker')` 末尾（既存テストの後、`});` の前）に追加:

```dart
    test('forceResync upserts again after the same token was synced', () async {
      final upserts = <String>[];
      final worker = PushTokenSyncWorker(
        upsert: (token) async => upserts.add(token),
        backoff: InterruptibleBackoff(delayOverride: (_) async {}),
      );
      addTearDown(worker.dispose);

      worker.accept(token: 'same-token');
      await worker.states.whereState<PushTokenSyncWorkerSynced>().first;
      expect(upserts, ['same-token']);

      final nextSynced = worker.states
          .whereState<PushTokenSyncWorkerSynced>()
          .first;
      worker.forceResync();
      await nextSynced;
      expect(upserts, ['same-token', 'same-token']);
    });

    test('forceResync clears a non-retryable failure and upserts again', () async {
      var calls = 0;
      final worker = PushTokenSyncWorker(
        upsert: (_) async {
          calls++;
          if (calls == 1) {
            throw const InvalidRequestException(statusCode: 400);
          }
        },
        backoff: InterruptibleBackoff(delayOverride: (_) async {}),
      );
      addTearDown(worker.dispose);

      worker.accept(token: 'blocked-token');
      await worker.states.whereState<PushTokenSyncWorkerFailed>().first;
      expect(calls, 1);

      final synced = worker.states.whereState<PushTokenSyncWorkerSynced>().first;
      worker.forceResync();
      await synced;
      expect(calls, 2);
    });

    test('forceResync is a no-op when no token has been accepted', () async {
      final upserts = <String>[];
      final worker = PushTokenSyncWorker(
        upsert: (token) async => upserts.add(token),
        backoff: InterruptibleBackoff(delayOverride: (_) async {}),
      );
      addTearDown(worker.dispose);

      worker.forceResync();
      await Future<void>.delayed(Duration.zero);
      expect(upserts, isEmpty);
      expect(worker.state, isA<PushTokenSyncWorkerAbsent>());
    });
```

- [ ] **Step 2: Run tests to verify they fail**

Run:

```bash
cd app && mise exec -- flutter test test/feature/devices/push_token_sync_worker_test.dart
```

Expected: FAIL — `forceResync` 未定義

- [ ] **Step 3: Implement forceResync**

`push_token_sync_worker.dart` の `retry()` の直後に追加:

```dart
  void forceResync() {
    if (_disposed) {
      return;
    }
    final token = _latestToken;
    if (token == null || token.isEmpty) {
      return;
    }

    _attempt = 0;
    _blockedToken = null;
    _lastSyncedToken = null;
    _latestToken = null;
    _backoff.interrupt();
    accept(token: token);
  }
```

- [ ] **Step 4: Run tests to verify they pass**

Run:

```bash
cd app && mise exec -- flutter test test/feature/devices/push_token_sync_worker_test.dart
```

Expected: PASS（全テスト）

- [ ] **Step 5: Commit and push**

```bash
git add app/lib/feature/devices/data/repository/push_token_sync_worker.dart \
  app/test/feature/devices/push_token_sync_worker_test.dart
git commit -m "$(cat <<'EOF'
feat: PushTokenSyncWorker に forceResync を追加

EOF
)"
git push -u origin HEAD
```

---

### Task 2: PushTokenSyncNotifier.forceResync

**Files:**
- Create: `app/lib/feature/devices/data/model/push_token_force_resync_result.dart`
- Modify: `app/lib/feature/devices/data/notifier/push_token_sync_notifier.dart`
- Regenerate: `push_token_sync_notifier.g.dart`（必要なら）

**Interfaces:**
- Consumes: Task 1 の `PushTokenSyncWorker.forceResync()`、`notificationTokenStreamProvider`、`PushTokenKind`
- Produces:
  - `enum PushTokenForceResyncResult { started, tokenAbsent, notApplicable }`
  - `Future<PushTokenForceResyncResult> forceResync({required PushTokenKind kind})`
  - `static final forceResyncMutation = Mutation<PushTokenForceResyncResult>()`

- [ ] **Step 1: Add result enum**

Create `app/lib/feature/devices/data/model/push_token_force_resync_result.dart`:

```dart
enum PushTokenForceResyncResult {
  started,
  tokenAbsent,
  notApplicable,
}
```

- [ ] **Step 2: Add forceResync to notifier**

`push_token_sync_notifier.dart` に import を追加し、`syncMutation` の近くに:

```dart
  static final forceResyncMutation = Mutation<PushTokenForceResyncResult>();
```

`retryFailed()` の近くにメソッドを追加:

```dart
  Future<PushTokenForceResyncResult> forceResync({
    required PushTokenKind kind,
  }) async {
    final worker = switch (kind) {
      PushTokenKind.fcm => _fcmWorker,
      PushTokenKind.apnsNotification => _apnsNotificationWorker,
      PushTokenKind.apnsPushToStart => _apnsPushToStartWorker,
    };
    if (worker == null) {
      return PushTokenForceResyncResult.notApplicable;
    }

    final notificationToken = ref.read(notificationTokenStreamProvider).value;
    final streamToken = switch (kind) {
      PushTokenKind.fcm => notificationToken?.fcmToken,
      PushTokenKind.apnsNotification => notificationToken?.apnsToken,
      PushTokenKind.apnsPushToStart => notificationToken?.apnsPushToStartToken,
    };
    if (streamToken != null && streamToken.isNotEmpty) {
      worker.accept(token: streamToken);
      worker.forceResync();
      return PushTokenForceResyncResult.started;
    }

    if (worker.state is PushTokenSyncWorkerAbsent ||
        worker.state is PushTokenSyncWorkerDisposed) {
      return PushTokenForceResyncResult.tokenAbsent;
    }

    worker.forceResync();
    return PushTokenForceResyncResult.started;
  }
```

必要な import:
- `package:eqmonitor/feature/devices/data/model/push_token_force_resync_result.dart`
- `package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart`

- [ ] **Step 3: Analyze**

Run:

```bash
cd app && mise exec -- dart analyze lib/feature/devices/data/notifier/push_token_sync_notifier.dart \
  lib/feature/devices/data/model/push_token_force_resync_result.dart
```

Expected: No issues

- [ ] **Step 4: Commit and push**

```bash
git add app/lib/feature/devices/data/model/push_token_force_resync_result.dart \
  app/lib/feature/devices/data/notifier/push_token_sync_notifier.dart
git commit -m "$(cat <<'EOF'
feat: PushTokenSyncNotifier に種類別 forceResync を追加

EOF
)"
git push
```

---

### Task 3: DeviceProvisioningNotifier 削除・再プロビジョン

**Files:**
- Modify: `app/lib/feature/devices/data/notifier/device_provisioning_notifier.dart`

**Interfaces:**
- Consumes: `DeviceRepository.deleteDevice`、`DeviceProvisioningRepository.clearProvisioned`、既存 `provision()`
- Produces:
  - `static final deleteMutation = Mutation<void>()`
  - `static final reprovisionMutation = Mutation<void>()`
  - `Future<void> deleteDeviceAndClearLocal()`
  - `Future<void> reprovision()`

- [ ] **Step 1: Add delete and reprovision methods**

`device_provisioning_notifier.dart` の `provisionMutation` 付近に Mutation を追加し、`provision()` の後に:

```dart
  static final deleteMutation = Mutation<void>();
  static final reprovisionMutation = Mutation<void>();

  Future<void> deleteDeviceAndClearLocal() async {
    final deviceRepo = await ref.read(deviceRepositoryProvider.future);
    final provisioningRepo = await ref.read(
      deviceProvisioningRepositoryProvider.future,
    );
    final deviceId = await ref.read(deviceIdProvider.future);

    final result = await deviceRepo.deleteDevice(deviceId);
    switch (result) {
      case Success():
        break;
      case Failure(:final exception, :final stackTrace):
        Error.throwWithStackTrace(
          exception,
          stackTrace ?? StackTrace.empty,
        );
    }

    await provisioningRepo.clearProvisioned();
    _retryController.reset();
    state = const AsyncData(DeviceProvisioningStatus.required);
    ref.invalidate(pushTokenSyncProvider, asReload: true);
  }

  Future<void> reprovision() async {
    await deleteDeviceAndClearLocal();
    await provision();
  }
```

`deleteDevice` がサーバー削除 + Bearer クリア済みのため、追加で必要なのは `clearProvisioned` のみ。`Success` / `Failure` は既存の `core/foundation/result.dart` を使用。

- [ ] **Step 2: Analyze**

Run:

```bash
cd app && mise exec -- dart analyze lib/feature/devices/data/notifier/device_provisioning_notifier.dart
```

Expected: No issues

- [ ] **Step 3: Commit and push**

```bash
git add app/lib/feature/devices/data/notifier/device_provisioning_notifier.dart
git commit -m "$(cat <<'EOF'
feat: デバイス削除と再プロビジョニング API を Notifier に追加

EOF
)"
git push
```

---

### Task 4: Flow + Debug UI

**Files:**
- Create: `app/lib/feature/devices/data/flow/debug_device_lifecycle_flow.dart`
- Create: `app/lib/feature/devices/data/flow/debug_device_lifecycle_flow.g.dart`（build_runner）
- Modify: `app/lib/feature/devices/ui/page/debug_device_settings_page.dart`
- Regenerate: `debug_device_settings_page.g.dart`（変更があれば）

**Interfaces:**
- Consumes: Task 2/3 の Mutation とメソッド、確認ダイアログ文言は仕様どおり
- Produces: `DebugDeviceLifecycleFlow` with:
  - `Future<void> confirmAndDelete(WidgetRef ref, BuildContext context)`
  - `Future<void> confirmAndReprovision(WidgetRef ref, BuildContext context)`
  - `Future<void> forceResyncToken(WidgetRef ref, BuildContext context, {required PushTokenKind kind})`

- [ ] **Step 1: Create flow**

Create `app/lib/feature/devices/data/flow/debug_device_lifecycle_flow.dart`:

```dart
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_force_resync_result.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_device_lifecycle_flow.g.dart';

@riverpod
DebugDeviceLifecycleFlow debugDeviceLifecycleFlow(Ref ref) =>
    DebugDeviceLifecycleFlow();

class DebugDeviceLifecycleFlow {
  Future<void> confirmAndDelete(WidgetRef ref, BuildContext context) async {
    final confirmed = await _confirm(
      context: context,
      title: 'デバイスを削除',
      content: 'サーバー上のデバイスとローカル認証情報を削除します。よろしいですか？',
      confirmLabel: '削除',
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) {
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    try {
      await DeviceProvisioningNotifier.deleteMutation.run(
        ref,
        (tsx) async =>
            tsx.get(deviceProvisioningProvider.notifier).deleteDeviceAndClearLocal(),
      );
      if (!context.mounted) {
        return;
      }
      messenger.showSnackBar(
        const SnackBar(content: Text('デバイスを削除しました')),
      );
    } on Object catch (error) {
      if (!context.mounted) {
        return;
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(_errorMessage(error)),
          backgroundColor: context.designSystem.colorTheme.error,
        ),
      );
    }
  }

  Future<void> confirmAndReprovision(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final confirmed = await _confirm(
      context: context,
      title: '再プロビジョニング',
      content: '削除してから再登録します。通知トークンも再同期されます。よろしいですか？',
      confirmLabel: '実行',
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) {
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    try {
      await DeviceProvisioningNotifier.reprovisionMutation.run(
        ref,
        (tsx) async =>
            tsx.get(deviceProvisioningProvider.notifier).reprovision(),
      );
      if (!context.mounted) {
        return;
      }
      messenger.showSnackBar(
        const SnackBar(content: Text('再プロビジョニングが完了しました')),
      );
    } on Object catch (error) {
      if (!context.mounted) {
        return;
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(_errorMessage(error)),
          backgroundColor: context.designSystem.colorTheme.error,
        ),
      );
    }
  }

  Future<void> forceResyncToken(
    WidgetRef ref,
    BuildContext context, {
    required PushTokenKind kind,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final result = await PushTokenSyncNotifier.forceResyncMutation.run(
        ref,
        (tsx) async => tsx
            .get(pushTokenSyncProvider.notifier)
            .forceResync(kind: kind),
      );
      if (!context.mounted) {
        return;
      }
      final message = switch (result) {
        PushTokenForceResyncResult.started => '${_kindLabel(kind)} の再送信を開始しました',
        PushTokenForceResyncResult.tokenAbsent =>
          'トークン未取得のため再送信できません',
        PushTokenForceResyncResult.notApplicable =>
          '${_kindLabel(kind)} はこの端末では非対応です',
      };
      messenger.showSnackBar(SnackBar(content: Text(message)));
    } on Object catch (error) {
      if (!context.mounted) {
        return;
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(_errorMessage(error)),
          backgroundColor: context.designSystem.colorTheme.error,
        ),
      );
    }
  }

  Future<bool> _confirm({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmLabel,
    required bool isDestructive,
  }) async {
    var confirmed = false;
    await showAdaptiveDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              confirmed = true;
              Navigator.of(dialogContext).pop();
            },
            style: isDestructive
                ? TextButton.styleFrom(
                    foregroundColor:
                        dialogContext.designSystem.colorTheme.error,
                  )
                : null,
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    return confirmed;
  }

  String _errorMessage(Object error) {
    if (error is DeviceProvisioningException) {
      return error.userMessage;
    }
    return error.toString();
  }

  String _kindLabel(PushTokenKind kind) => switch (kind) {
    PushTokenKind.fcm => 'FCM',
    PushTokenKind.apnsNotification => 'APNs（通知）',
    PushTokenKind.apnsPushToStart => 'Push to Start',
  };
}
```

注意: プロジェクト規約でクラス内プライベートメソッドは原則禁止。Flow 内の `_confirm` / `_errorMessage` / `_kindLabel` は、既存 Flow（例: ads）が短いヘルパーを持つ場合に合わせるか、インライン化すること。**実装時はプライベートメソッドを避け、確認ダイアログ用に別クラス `DebugDeviceLifecycleConfirmDialog` を同ファイルまたは別ファイルに切り出す。** `_errorMessage` / `_kindLabel` は extension または top-level 禁止のため、同ファイルの専用クラス（例: `DebugDeviceLifecycleMessages`）に置く。

推奨の切り出し:

```dart
class DebugDeviceLifecycleMessages {
  String errorMessage(Object error) { ... }
  String kindLabel(PushTokenKind kind) { ... }
}

class DebugDeviceLifecycleConfirmDialog {
  Future<bool> show({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmLabel,
    required bool isDestructive,
  }) async { ... }
}
```

Flow はこれらのクラスを保持（コンストラクタ注入可、デフォルト生成）。

- [ ] **Step 2: Run build_runner for the flow**

Run:

```bash
cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: `debug_device_lifecycle_flow.g.dart` 生成

- [ ] **Step 3: Update DebugDeviceSettingsPage UI**

`debug_device_settings_page.dart` の `SliverList.list` children を次の順にする:

1. `_ProvisioningStartupSection`（既存）
2. **`_DeviceLifecycleSection`（新設）**
3. `_DeviceInfoSection`（既存）
4. `_NotificationPermissionSection`（既存）
5. `_TokenSection`（拡張）
6. 以降既存どおり

**`_DeviceLifecycleSection`（新設、HookConsumerWidget）:**

- title: `デバイス操作`
- `deleteMutation` / `reprovisionMutation` を watch
- どちらか Pending なら両ボタン disabled + 進捗
- `FilledButton.tonalIcon` 危険色相当で「削除」→ `debugDeviceLifecycleFlowProvider` の `confirmAndDelete`
- `FilledButton.icon` 「再プロビジョニング」→ `confirmAndReprovision`
- 削除成功後に `_deviceInfoProvider` / `_isProvisionedProvider` / `_deviceTokenPresentProvider` を invalidate

**`_TokenSection` を HookConsumerWidget に変更:**

- 各 `_TokenStatusRow` に再送信ボタンを渡す
- `NotApplicableTokenState` ではボタン非表示
- `SyncingTokenState` では disabled
- `forceResyncMutation` Pending 時も対象行を disabled（または全行 disabled）
- 押下で `forceResyncToken(ref, context, kind: ...)`

`_TokenStatusRow` は `onResend`（`VoidCallback?`）を受け取り、非 null のときだけボタン表示。ロジックは親で組み立てる（Widget にメソッドを定義しない）。

削除後の invalidate 例（Flow 成功後、またはセクション内）:

```dart
ref.invalidate(_isProvisionedProvider, asReload: true);
ref.invalidate(_deviceTokenPresentProvider, asReload: true);
if (deviceId.isNotEmpty) {
  ref.invalidate(_deviceInfoProvider(deviceId), asReload: true);
}
```

invalidate は Flow 成功直後に UI 側で行うか、Flow に deviceId を渡して行う。Flow が WidgetRef を持つので Flow 内で invalidate してよい（プライベート `@riverpod` は page ファイル内のため、**UI セクション側で invalidate** する）。

- [ ] **Step 4: Analyze changed UI/flow files**

Run:

```bash
cd app && mise exec -- dart analyze \
  lib/feature/devices/data/flow/debug_device_lifecycle_flow.dart \
  lib/feature/devices/ui/page/debug_device_settings_page.dart
```

Expected: No issues

- [ ] **Step 5: Commit and push**

```bash
git add app/lib/feature/devices/data/flow/debug_device_lifecycle_flow.dart \
  app/lib/feature/devices/data/flow/debug_device_lifecycle_flow.g.dart \
  app/lib/feature/devices/ui/page/debug_device_settings_page.dart \
  app/lib/feature/devices/ui/page/debug_device_settings_page.g.dart
git commit -m "$(cat <<'EOF'
feat: デバッグ画面にトークン再送信とデバイス操作を追加

EOF
)"
git push
```

---

## Spec Coverage Checklist

| Spec 要件 | Task |
|-----------|------|
| Worker `forceResync` | Task 1 |
| Notifier 種類別 forceResync + Mutation | Task 2 |
| 削除 + ローカルクリア | Task 3 |
| 再プロビジョン（削除→再登録） | Task 3 |
| 確認ダイアログ Flow | Task 4 |
| UI: デバイス操作セクション | Task 4 |
| UI: トークン行ごとの再送信 | Task 4 |
| SnackBar 文言（未取得含む） | Task 4 |
| Worker テスト | Task 1 |
| debug_device_admin / 本番バナー非変更 | 全 Task（触らない） |
