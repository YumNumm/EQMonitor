# 揺れ検知のビルド時無効化フラグ

## 概要

`BuildConfig`(`app/lib/core/model/environment.dart`)にビルド時フラグを追加した。

| getter/field | dart-define | 既定 | 意味 |
|---|---|---|---|
| `isShakeDetectionEnabled` | `IS_SHAKE_DETECTION_ENABLED` | **true** | 揺れ検知機能を有効にするか |

`isBetaTesting` / `isProFeaturesEnabled` が既定 false なのに対し、
本フラグは既定 true（未指定＝有効）である点に注意する。
`const bool.fromEnvironment('IS_SHAKE_DETECTION_ENABLED', defaultValue: true)`
と `@Default(true)` の両方で true を指定している。

## 無効時の挙動

キルスイッチは `ShakeDetectionAcceptedSnapshot`(揺れ検知の canonical snapshot)に
集約している。`build()` 冒頭でフラグを見て、無効なら WebSocket / REST の
listener を一切登録せず常に `null` を返す。`applySnapshot()` にも同じ guard を置き、
経路によらず state が更新されないようにしている。

これにより以下が連鎖的に停止する（各 UI 側に分岐を撒かない）。

- `shakeDetectionProvider` → `shakeDetectionVisibleProvider` が空
- ホーム地図の揺れ検知レイヤー・ホームの揺れ検知カード
- Live Monitor の揺れ検知ベースライン・カード・レイヤー
- タイムシフト自動復帰の揺れ検知トリガー

加えて `shakeDetectionVisibleProvider` にも guard を置き、デバッグ挿入
(`shakeDetectionDebugOverlayProvider`)経由でも表示されないようにしている。

ルーターでは `/settings/notification/shake` を `HomeRoute` へ redirect する
(`isDeveloperUiEnabled` / `isProFeaturesEnabled` と同じ場所)。

## CI での配布別の指定

`.github/workflows/deploy-app.yaml` で、公開テスト配布のビルドにのみ
`--dart-define IS_SHAKE_DETECTION_ENABLED=false` を付与する。

- iOS: `deploy-ios-external == 'true'`（TestFlight external グループ配布）
- Android: `android-track == 'external'`

内部配布(internal)や develop への通常 push では付与されず、既定の true になる。
判定は `scripts/ci/resolve_deploy_app_policy.sh` の出力に従う。

## テスト時の注意

`buildConfigProvider` は `BuildConfig.fromEnvironment()` を返すため、
dart-define のないテストでは `Flavor.values.byName('')` で例外になる。
`buildConfigProvider` を読む provider のテストでは必ず override すること。
共通の生成ヘルパは `app/test/fixtures/build_config.dart` の `BuildConfigFixture`。

```dart
ProviderContainer(
  overrides: [
    buildConfigProvider.overrideWithValue(
      const BuildConfigFixture().build(isShakeDetectionEnabled: false),
    ),
  ],
);
```

## ビルド例

```bash
# 揺れ検知を無効にして dev 実行
cd app && flutter run --dart-define-from-file=../environment/.env.dev \
  --dart-define IS_SHAKE_DETECTION_ENABLED=false
```
