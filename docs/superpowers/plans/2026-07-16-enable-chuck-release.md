# Release Mode Chuck Enablement Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Release Mode でも Chuck の通信記録と Inspector 導線を有効にし、通知だけは Debug Mode に限定する。

**Architecture:** ビルドモードから Chuck の3機能の有効状態を決める immutable なポリシーを追加する。Chuck provider、Dio provider、デバッグ設定画面は同じポリシーを参照し、Release と Debug の差を単体テストで固定する。

**Tech Stack:** Flutter 3.44.4、Dart、Riverpod、flutter_test、chuck_interceptor

## Global Constraints

- Flutter / Dart コマンドは `mise exec --` 経由で実行する。
- Release Mode では通信記録と Inspector 導線を有効にする。
- Release Mode では Chuck の通知を表示しない。
- 地震情報や API 応答へ固定値のフォールバックを追加しない。

---

### Task 1: Chuck build mode policy と既存配線

**Files:**
- Create: `app/lib/core/provider/chuck_build_mode_policy.dart`
- Create: `app/test/core/provider/chuck_build_mode_policy_test.dart`
- Modify: `app/lib/core/provider/chuck_provider.dart`
- Modify: `app/lib/core/provider/dio_provider.dart`
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart`

**Interfaces:**
- Consumes: Flutter の compile-time 定数 `kDebugMode`
- Produces: `ChuckBuildModePolicy` と `chuckBuildModePolicy`

- [ ] **Step 1: Release と Debug の期待値を表す失敗テストを書く**

```dart
import 'package:eqmonitor/core/provider/chuck_build_mode_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChuckBuildModePolicy', () {
    test('Release相当では通信記録とInspectorを有効にし通知を無効にする', () {
      const policy = ChuckBuildModePolicy(isDebugMode: false);

      expect(policy.captureTraffic, isTrue);
      expect(policy.showInspector, isTrue);
      expect(policy.showNotification, isFalse);
    });

    test('Debug相当では通信記録とInspectorと通知を有効にする', () {
      const policy = ChuckBuildModePolicy(isDebugMode: true);

      expect(policy.captureTraffic, isTrue);
      expect(policy.showInspector, isTrue);
      expect(policy.showNotification, isTrue);
    });
  });
}
```

- [ ] **Step 2: テストを実行し、未実装の型で失敗することを確認する**

Run: `cd app && mise exec -- flutter test test/core/provider/chuck_build_mode_policy_test.dart`

Expected: FAIL because `chuck_build_mode_policy.dart` or `ChuckBuildModePolicy` does not exist.

- [ ] **Step 3: 最小のポリシー実装を追加する**

```dart
class ChuckBuildModePolicy {
  const ChuckBuildModePolicy({required bool isDebugMode})
    : captureTraffic = true,
      showInspector = true,
      showNotification = isDebugMode;

  final bool captureTraffic;
  final bool showInspector;
  final bool showNotification;
}
```

- [ ] **Step 4: ポリシーのテストが成功することを確認する**

Run: `cd app && mise exec -- flutter test test/core/provider/chuck_build_mode_policy_test.dart`

Expected: PASS with 2 tests.

- [ ] **Step 5: 既存の Chuck 配線をポリシーへ接続する**

`chuck_provider.dart` に次を追加し、`showNotification` に利用する。

```dart
const chuckBuildModePolicy = ChuckBuildModePolicy(isDebugMode: kDebugMode);

showNotification: chuckBuildModePolicy.showNotification,
```

`dio_provider.dart` の Chuck 登録条件を次へ置き換える。

```dart
if (chuckBuildModePolicy.captureTraffic) {
  final chuck = ref.watch(chuckProvider);
  dio.interceptors.add(chuck.dioInterceptor);
}
```

`debug_page.dart` の Inspector 導線条件を次へ置き換える。

```dart
if (chuckBuildModePolicy.showInspector)
  ListTile(
    title: const Text('Chuck'),
    leading: const Icon(Icons.list),
    onTap: () async => ref.read(chuckProvider).showInspector(),
  ),
```

- [ ] **Step 6: format、対象テスト、静的解析を実行する**

Run: `mise exec -- dart format app/lib/core/provider/chuck_build_mode_policy.dart app/lib/core/provider/chuck_provider.dart app/lib/core/provider/dio_provider.dart app/lib/feature/settings/children/config/debug/debug_page.dart app/test/core/provider/chuck_build_mode_policy_test.dart`

Expected: formatter exits 0.

Run: `cd app && mise exec -- flutter test test/core/provider/chuck_build_mode_policy_test.dart test/core/provider/dio_list_format_test.dart test/feature/settings/data/contact/contact_url_builder_test.dart`

Expected: PASS with 6 tests.

Run: `mise exec -- dart analyze app/lib/core/provider/chuck_build_mode_policy.dart app/lib/core/provider/chuck_provider.dart app/lib/core/provider/dio_provider.dart app/lib/feature/settings/children/config/debug/debug_page.dart app/test/core/provider/chuck_build_mode_policy_test.dart`

Expected: No issues found.

- [ ] **Step 7: 実装をコミットする**

```bash
git add app/lib/core/provider/chuck_build_mode_policy.dart \
  app/lib/core/provider/chuck_provider.dart \
  app/lib/core/provider/dio_provider.dart \
  app/lib/feature/settings/children/config/debug/debug_page.dart \
  app/test/core/provider/chuck_build_mode_policy_test.dart
git commit -m "feat: Release ModeでもChuckを有効化"
```
