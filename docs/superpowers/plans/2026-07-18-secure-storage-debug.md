# SecureStorage デバッグ画面 & Preferences キー監査 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** デバッグ画面に SecureStorage の Key-Value CRUD（マスク表示付き）を追加し、Hi-net/Knet と App Group デバッグの enum 外キー参照を是正する。

**Architecture:** SharedPreferences デバッグと同型の専用ページを新設。一覧は `readAll()`、CRUD はデバッグ例外として raw `write`/`delete`。本番の Hi-net/Knet は `SecureStorageKey` + `SecurePreferencesDataSource` に統一。App Group デバッグは `AppGroupKeys` を参照する。

**Tech Stack:** Flutter, Riverpod (`@riverpod`), flutter_hooks, go_router_builder, flutter_secure_storage, Material 3

**Spec:** `docs/superpowers/specs/2026-07-18-secure-storage-debug-design.md`

## Global Constraints

- テストは追加しない（仕様で不要と明記）。既存テストが壊れた場合のみ最小修正する
- Flutter / Dart コマンドは常に `mise exec --` 経由
- コード生成: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`
- top-level / プライベート関数禁止。ロジックはクラス、イベントは Action、単純変換はインライン変数
- Widget に関数・ゲッターを定義しない。`StatefulWidget` 禁止（`HookConsumerWidget`）
- `!` 禁止。`dynamic` / `Object` は `Map<String, dynamic>` 以外禁止
- Action: `ref` / `context` はコンストラクタに渡さずメソッド引数で受け取る
- コミットメッセージ: 英語1単語 prefix + 日本語1行
- Spec / Plan ドキュメント単体ではコミット・プッシュしない（実装差分とまとめる）
- workflow 動的キー（`_wf:`）はスコープ外

---

## File Structure

新規:
- `app/lib/feature/settings/children/config/debug/secure_storage/debug_secure_storage_entries_provider.dart` — エントリ一覧
- `app/lib/feature/settings/children/config/debug/secure_storage/debug_secure_storage_action.dart` — 追加/編集/削除
- `app/lib/feature/settings/children/config/debug/secure_storage/debug_secure_storage_page.dart` — 画面

変更:
- `app/lib/core/data/preferences/secure/secure_storage_key.dart` — Hi-net/Knet キー追加
- `app/lib/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart` — DataSource 経由
- `app/lib/feature/knet_waveform/data/provider/knet_credentials_provider.dart` — DataSource 経由
- `app/lib/feature/settings/children/config/debug/app_group/app_group_values_provider.dart` — `AppGroupKeys`
- `app/lib/feature/settings/children/config/debug/app_group/debug_app_group_action.dart` — `AppGroupKeys`
- `app/lib/core/router/router.dart` — `DebugSecureStorageRoute`
- `app/lib/feature/settings/children/config/debug/debug_page.dart` — 導線

生成（手編集禁止）:
- `debug_secure_storage_entries_provider.g.dart`
- `debug_secure_storage_action.g.dart`
- `hinet_credentials_provider.g.dart` / `knet_credentials_provider.g.dart`（必要なら）
- `router.g.dart`

---

### Task 1: SecureStorageKey 追加 + Hi-net/Knet を DataSource 経由に変更

**Files:**
- Modify: `app/lib/core/data/preferences/secure/secure_storage_key.dart`
- Modify: `app/lib/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart`
- Modify: `app/lib/feature/knet_waveform/data/provider/knet_credentials_provider.dart`
- Possibly fix: `app/test/feature/settings/children/config/debug/hinet_seismicity/hinet_credentials_provider_test.dart`（壊れた場合のみ）

**Interfaces:**
- Produces:
  ```dart
  enum SecureStorageKey {
    userId('user_id'),
    deviceToken('device_token'),
    hinetBosaiUserId('hinet_bosai_user_id'),
    hinetBosaiPassword('hinet_bosai_password'),
    knetBosaiUserId('knet_bosai_user_id'),
    knetBosaiPassword('knet_bosai_password'),
    ;
    const SecureStorageKey(this.key);
    final String key;
  }
  ```
- Consumes: `securePreferencesDataSourceProvider`（`getString` / `setString` / `remove`）

- [ ] **Step 1: `SecureStorageKey` に 4 キーを追加**

`app/lib/core/data/preferences/secure/secure_storage_key.dart` を以下で置き換える:

```dart
enum SecureStorageKey {
  userId('user_id'),
  deviceToken('device_token'),
  hinetBosaiUserId('hinet_bosai_user_id'),
  hinetBosaiPassword('hinet_bosai_password'),
  knetBosaiUserId('knet_bosai_user_id'),
  knetBosaiPassword('knet_bosai_password'),
  ;

  const SecureStorageKey(this.key);
  final String key;
}
```

- [ ] **Step 2: Hi-net credentials を DataSource 経由に変更**

`hinet_credentials_provider.dart`:
- `import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';` を削除
- `secure_preferences_data_source.dart` と `secure_storage_key.dart` を import
- `const _hinetUserIdKey` / `_hinetPasswordKey` を削除
- `build` / `save` / `clear` を次の形にする:

```dart
@override
Future<HinetCredentials?> build() async {
  final ds = await ref.watch(securePreferencesDataSourceProvider.future);
  final userId = await ds.getString(key: SecureStorageKey.hinetBosaiUserId);
  final password = await ds.getString(key: SecureStorageKey.hinetBosaiPassword);
  if (userId == null || password == null) {
    return null;
  }
  return HinetCredentials(userId: userId, password: password);
}

Future<void> save({required String userId, required String password}) async {
  final ds = await ref.read(securePreferencesDataSourceProvider.future);
  await ds.setString(key: SecureStorageKey.hinetBosaiUserId, value: userId);
  await ds.setString(
    key: SecureStorageKey.hinetBosaiPassword,
    value: password,
  );
  state = AsyncData(HinetCredentials(userId: userId, password: password));
}

Future<void> clear() async {
  final ds = await ref.read(securePreferencesDataSourceProvider.future);
  await ds.remove(key: SecureStorageKey.hinetBosaiUserId);
  await ds.remove(key: SecureStorageKey.hinetBosaiPassword);
  state = const AsyncData(null);
}
```

- [ ] **Step 3: Knet credentials を同様に変更**

`knet_credentials_provider.dart` でも同じパターン:
- `SecureStorageKey.knetBosaiUserId` / `SecureStorageKey.knetBosaiPassword`
- `securePreferencesDataSourceProvider` 経由
- `const _knetUserIdKey` / `_knetPasswordKey` を削除

- [ ] **Step 4: 既存 Hi-net テストが通るか確認**

Run:

```bash
cd app && mise exec -- flutter test test/feature/settings/children/config/debug/hinet_seismicity/hinet_credentials_provider_test.dart
```

Expected: PASS。FAIL した場合は、既存の MethodChannel モックが `secureStorageProvider` → DataSource 経由で引き続き動くはずなので、`SharedPreferences.setMockInitialValues` と channel mock を維持したまま原因を最小修正する（新規テストは追加しない）。

- [ ] **Step 5: Commit**

```bash
git add \
  app/lib/core/data/preferences/secure/secure_storage_key.dart \
  app/lib/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart \
  app/lib/feature/knet_waveform/data/provider/knet_credentials_provider.dart \
  app/test/feature/settings/children/config/debug/hinet_seismicity/hinet_credentials_provider_test.dart
git commit -m "$(cat <<'EOF'
fix: Hi-net/Knet認証をSecureStorageKey経由に統一

EOF
)"
```

（テスト未変更なら test ファイルは `git add` から外す）

---

### Task 2: App Group デバッグのキーを `AppGroupKeys` に統一

**Files:**
- Modify: `app/lib/feature/settings/children/config/debug/app_group/app_group_values_provider.dart`
- Modify: `app/lib/feature/settings/children/config/debug/app_group/debug_app_group_action.dart`

**Interfaces:**
- Consumes: `AppGroupKeys.apiServerUrl` / `AppGroupKeys.debugMode`（`app/lib/core/provider/app_group_settings_writer.dart`）
- Produces: 挙動不変。文字列リテラルを定数参照に置換のみ

- [ ] **Step 1: `app_group_values_provider.dart` を修正**

`import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';` を追加し:

```dart
final apiServerUrl = await prefs.getString(AppGroupKeys.apiServerUrl);
final debugMode = await prefs.getBool(AppGroupKeys.debugMode);
```

- [ ] **Step 2: `debug_app_group_action.dart` を修正**

既に `app_group_settings_writer.dart` を import 済み。次を置換:

```dart
await prefs.setString(AppGroupKeys.apiServerUrl, result);
// ...
await prefs.setBool(AppGroupKeys.debugMode, value);
```

- [ ] **Step 3: Commit**

```bash
git add \
  app/lib/feature/settings/children/config/debug/app_group/app_group_values_provider.dart \
  app/lib/feature/settings/children/config/debug/app_group/debug_app_group_action.dart
git commit -m "$(cat <<'EOF'
fix: App Groupデバッグのキー参照をAppGroupKeysに統一

EOF
)"
```

---

### Task 3: SecureStorage エントリ Provider + Action

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/secure_storage/debug_secure_storage_entries_provider.dart`
- Create: `app/lib/feature/settings/children/config/debug/secure_storage/debug_secure_storage_action.dart`

**Interfaces:**
- Consumes: `secureStorageProvider`（`app/lib/core/data/preferences/secure/secure_storage.dart`）、`SecureStorageKey`
- Produces:
  ```dart
  @riverpod
  Future<List<({String key, String value})>> debugSecureStorageEntries(Ref ref);

  @riverpod
  DebugSecureStorageAction debugSecureStorageAction(Ref ref);

  class DebugSecureStorageAction {
    Future<void> write(WidgetRef ref, {required String key, required String value});
    Future<void> remove(WidgetRef ref, {required String key});
  }
  ```

- [ ] **Step 1: entries provider を作成**

`debug_secure_storage_entries_provider.dart`:

```dart
import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_secure_storage_entries_provider.g.dart';

@riverpod
Future<List<({String key, String value})>> debugSecureStorageEntries(
  Ref ref,
) async {
  final storage = await ref.watch(secureStorageProvider.future);
  final all = await storage.readAll();
  final knownKeys = SecureStorageKey.values.map((e) => e.key).toSet();

  final unknown = <String>[];
  final known = <String>[];
  for (final key in all.keys) {
    (knownKeys.contains(key) ? known : unknown).add(key);
  }
  unknown.sort();
  known.sort();

  return [
    for (final key in [...unknown, ...known])
      (key: key, value: all[key] ?? ''),
  ];
}
```

- [ ] **Step 2: Action を作成**

`debug_secure_storage_action.dart`:

```dart
import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/secure_storage/debug_secure_storage_entries_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_secure_storage_action.g.dart';

@riverpod
DebugSecureStorageAction debugSecureStorageAction(Ref ref) =>
    DebugSecureStorageAction();

class DebugSecureStorageAction {
  Future<void> write(
    WidgetRef ref, {
    required String key,
    required String value,
  }) async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.write(key: key, value: value);
    ref.invalidate(debugSecureStorageEntriesProvider);
  }

  Future<void> remove(WidgetRef ref, {required String key}) async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.delete(key: key);
    ref.invalidate(debugSecureStorageEntriesProvider);
  }
}
```

- [ ] **Step 3: コード生成**

```bash
cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: `debug_secure_storage_entries_provider.g.dart` と `debug_secure_storage_action.g.dart` が生成される。

- [ ] **Step 4: Commit**

```bash
git add \
  app/lib/feature/settings/children/config/debug/secure_storage/
git commit -m "$(cat <<'EOF'
feat: SecureStorageデバッグ用のentries ProviderとActionを追加

EOF
)"
```

---

### Task 4: SecureStorage デバッグページ UI

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/secure_storage/debug_secure_storage_page.dart`

**Interfaces:**
- Consumes: `debugSecureStorageEntriesProvider`、`debugSecureStorageActionProvider`
- Produces: `DebugSecureStoragePage`（`HookConsumerWidget`）

- [ ] **Step 1: ページを実装**

`debug_secure_storage_page.dart` の要件:

1. `Scaffold` + `AppBar(title: Text('SecureStorage'))` + refresh `IconButton`（`debugSecureStorageEntriesProvider` を invalidate）
2. body: `AsyncValue.when` で一覧。空なら「エントリがありません」
3. `ListView.builder` + `RefreshIndicator`
4. 各行:
   - `title`: key
   - `subtitle`: マスク時は `•••••••• (${value.length})`、平文時は value。`FontFamily.googleSansCode`
   - `trailing`: 目アイコン（マスクトグル）+ 削除アイコン
   - 行タップ: 編集ダイアログ（平文 `TextField` maxLines: 8）
5. マスク状態: `useState<Set<String>>({})` でキー集合を管理（エフェメラル）
6. FAB: 新規追加ダイアログ（キー名 + 値の TextField、保存で `action.write`）
7. 確認ダイアログなし
8. 削除は `action.remove` を直接呼ぶ
9. private Widget class（`_EntriesList` 等）で分割。Widget にメソッド/ゲッターを定義しない
10. top-level 関数を作らない。マスク文字列は build 内のローカル変数で組み立てる:

```dart
final preview = isRevealed
    ? entry.value
    : '•••••••• (${entry.value.length})';
```

参考 UI パターン: `debug_shared_preferences_page.dart`（一覧・FAB・ダイアログ）。ただし型選択 UI は不要（常に String）。

- [ ] **Step 2: analyze**

```bash
cd app && mise exec -- dart analyze lib/feature/settings/children/config/debug/secure_storage/
```

Expected: No issues.

- [ ] **Step 3: Commit**

```bash
git add app/lib/feature/settings/children/config/debug/secure_storage/debug_secure_storage_page.dart
git commit -m "$(cat <<'EOF'
feat: SecureStorageデバッグ画面のUIを追加

EOF
)"
```

---

### Task 5: ルーティングとデバッグメニュー導線

**Files:**
- Modify: `app/lib/core/router/router.dart`
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart`

**Interfaces:**
- Produces:
  ```dart
  class DebugSecureStorageRoute extends GoRouteData with $DebugSecureStorageRoute {
    const DebugSecureStorageRoute();
    @override
    Widget build(BuildContext context, GoRouterState state) {
      return const DebugSecureStoragePage();
    }
  }
  ```
- Path: `secure-storage`（親は既存 debug 配下 → `/settings/debug/secure-storage`）

- [ ] **Step 1: router にルート追加**

1. import:

```dart
import 'package:eqmonitor/feature/settings/children/config/debug/secure_storage/debug_secure_storage_page.dart';
```

2. `TypedGoRoute<DebugSharedPreferencesRoute>(path: 'shared-preferences'),` の直後に追加:

```dart
TypedGoRoute<DebugSecureStorageRoute>(path: 'secure-storage'),
```

3. `DebugSharedPreferencesRoute` クラスの直後にルートクラスを追加（上記 Interfaces どおり）。

- [ ] **Step 2: go_router コード生成**

```bash
cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: `router.g.dart` に `$DebugSecureStorageRoute` が生成される。

- [ ] **Step 3: debug_page に ListTile 追加**

`SharedPreferences` の `ListTile` の直後に追加:

```dart
ListTile(
  title: const Text('SecureStorage'),
  subtitle: const Text('保存されている Key-Value の一覧・編集'),
  leading: const Icon(Icons.lock_outline),
  onTap: () async =>
      const DebugSecureStorageRoute().push<void>(context),
),
```

`DebugSecureStorageRoute` が使えるよう、router の生成 mixin 経由で import されることを確認（既存の `DebugSharedPreferencesRoute` と同様。`debug_page.dart` が router を import しているなら追加 import 不要の場合あり。必要なら `router.dart` から export される型を import）。

- [ ] **Step 4: analyze**

```bash
cd app && mise exec -- dart analyze \
  lib/core/router/router.dart \
  lib/feature/settings/children/config/debug/debug_page.dart \
  lib/feature/settings/children/config/debug/secure_storage/
```

Expected: No issues.

- [ ] **Step 5: Commit（仕様・プランもまとめて）**

```bash
git add \
  app/lib/core/router/router.dart \
  app/lib/core/router/router.g.dart \
  app/lib/feature/settings/children/config/debug/debug_page.dart \
  docs/superpowers/specs/2026-07-18-secure-storage-debug-design.md \
  docs/superpowers/plans/2026-07-18-secure-storage-debug.md
git commit -m "$(cat <<'EOF'
feat: SecureStorageデバッグ画面への導線とルートを追加

EOF
)"
```

（仕様が既に別コミット済みでも、プランは実装と一緒に入れる。仕様の再コミットは差分がなければ skip）

---

### Task 6: 手動確認チェックリスト

テストコードは追加しない。実装後に手動で確認する。

- [ ] **Step 1: アプリ起動 → デバッグメニュー**

- [ ] SecureStorage 行がある
- [ ] タップで `/settings/debug/secure-storage` 相当の画面が開く

- [ ] **Step 2: CRUD**

- [ ] 既存キー（`user_id` / `device_token` / Hi-net 等）が一覧に出る
- [ ] 値がデフォルトでマスクされている
- [ ] 目アイコンまたはトグルで平文表示できる
- [ ] 編集・追加・削除が動作する
- [ ] pull-to-refresh / AppBar refresh で再取得できる

- [ ] **Step 3: 回帰**

- [ ] Hi-net / Knet 認証の保存・読み込み・クリアが従来どおり
- [ ] App Group デバッグで API URL / debugMode の読み書きが動作（iOS）

---

## Self-Review

1. **Spec coverage:** 機能① UI/CRUD/マスク、機能② Hi-net/Knet、機能③ AppGroupKeys、スコープ外 `_wf:`、テスト不要 → すべて Task に対応
2. **Placeholder scan:** TBD / 「適切に」系なし
3. **Type consistency:** entries は `({String key, String value})`、Action は `write`/`remove`、Route は `DebugSecureStorageRoute`
