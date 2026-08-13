# BETA×prod のデバッグ UI 抑止と EQMonitor Pro フラグ

## 概要

`BuildConfig`(`app/lib/core/model/environment.dart`)に 2 つのビルド時フラグを追加した。

| getter/field | dart-define | 既定 | 意味 |
|---|---|---|---|
| `isBetaTesting` | `IS_BETA_TESTING` | false | BETA 配布ビルドか |
| `isProFeaturesEnabled` | `IS_PRO_FEATURES_ENABLED` | false | EQMonitor Pro を有効化するか |
| `isDeveloperUiEnabled`(派生) | - | - | `!(isBetaTesting && flavor == prod)` |

`isBetaTesting` は従来 getter だったが、テストで override / 明示指定できるよう
Freezed フィールド化した(`fromEnvironment()` で `const bool.fromEnvironment` を注入)。

## デバッグ UI の抑止(isDeveloperUiEnabled)

BETA かつ prod flavor のビルド(= 通常の TestFlight / ストア配布 BETA)では
`isDeveloperUiEnabled == false` となり、以下を無効化する。

- 設定のデバッグメニュー項目・HTTP キャッシュ表示/削除(`settings_page.dart`)
- `DebugLauncher` のシェイク / Shift+D 起動(`debug_launcher.dart`)
- ルーターで `/debug` 配下を `HomeRoute` へリダイレクト(`router.dart`)

→ 影響として TestFlight での App Check アプリ内確認ができなくなる。
  `docs/todo/550_*` と `docs/beta/ios-testflight-checklist.md` 4.1 を参照。

## Pro 機能の一時無効化(isProFeaturesEnabled)

既定 false。`isProProvider` と `SubscriptionNotifier.build()` の入口でゲートし、
UI(設定の Pro セクション・通知設定の Pro 判定・Paywall 導線)と
ルーター(`/subscription/*` → `HomeRoute`)でも抑止する。
再有効化手順は `docs/todo/150_reenable_eqmonitor_pro.md`。

## ハマりどころ

- **`build_runner build --build-filter=...` は対象外の生成物を削除する**。
  特定ファイルだけ再生成したい場合でも、フィルタ付き実行で他の `.g.dart` /
  `.freezed.dart` が消えることがある。フィルタなしのフル生成を使うか、
  実行後に `git status` で削除有無を必ず確認する。
- 生成プロバイダ `BuildConfigProvider` は本バージョンで `.select(...)` を
  公開していない。`ref.watch(buildConfigProvider).<field>` で参照する
  (`BuildConfig` は keepAlive で実質不変のため問題なし)。
- `notification_settings_page` / `subscription_notifier` / `is_pro_provider` が
  `buildConfigProvider` を読むようになったため、これらを使う既存テストは
  `buildConfigProvider.overrideWithValue(...)` が必須(未 override だと
  `Flavor.values.byName('')` で例外)。

## ビルド例

```bash
# Pro を有効化して dev 実行
flutter run --dart-define-from-file=environment/.env.dev \
  --dart-define IS_PRO_FEATURES_ENABLED=true
```
