## Summary

- Flutter SDK導入をYumNumm版`mise-flutter`へ一本化します。
- Scene spikeからevidence、validator、Dart define manifest、operator checklistを削除します。
- exampleを3操作と6 counterだけのprofile/release manual smoke harnessへ簡素化します。
- iOS/Android実機確認は未実施ですが、foundation実装を停止する条件にはしません。

## Stack

- Base: `develop`
- Merged predecessors: [#1565](https://github.com/YumNumm/EQMonitor/pull/1565)
  design、[#1566](https://github.com/YumNumm/EQMonitor/pull/1566) Scene spike
- Head: `codex/eqmonitor-map-mise-simplification`
- Next: `03-foundation`

## Fixed revisions

- Flutter: `4dacd3fc91d96262a33e5c598e17d816f0b35641`
- Flutter Scene / scene: `7f71993b7e2a0ab1d2f59726a406098709be7291`

Flutter revisionは`mise.toml`、Flutter Sceneは`packages/eqmonitor_map/pubspec.yaml`と
root `pubspec.lock`を正本にします。Flutter/Dart commandは`mise exec --`経由で
実行します。

## Scene spike harness

- procedural meshとcustom materialをFlutter Sceneで描画します。
- Flutterの`TextPainter`で地理anchor付きoverlay labelを重ねます。
- position/colorのpartial updateを開始・停止できます。
- background/foreground、app resource rebuild、controller dispose/remountを操作できます。
- frame、partial update、resume、remount、resource rebuild、exceptionの6 counterだけを
  remount間で維持します。
- Scene lifecycleとresource generationを非同期処理で検証し、stale completionを適用しません。
- background中はpartial updateを停止し、foreground後のresource rebuild成功時だけ再開します。

## Removed infrastructure

- checkout clean状態やSDK revisionをruntimeのDart defineへ複製するmanifest writer
- canonical evidence JSON、collector、gate、validator、clipboard UI
- operator attestation checklist、evidence専用frame timing、4-run判定
- evidence専用のsource、生成コード、tool、unit test、運用文書

## Toolchain and CI

- `mise.toml`のcustom Flutter pluginが固定revisionを導入します。
- packageをstrict analyze/unit test、exampleをAndroid/iOSのprofile/release buildで検査します。
- 署名、配布、deploy secretは扱いません。

## Manual smoke status

Result: `NOT RUN`。

このLinux hostでは物理iOS/Android端末のprofile/releaseを起動していません。
procedural/custom material描画、`TextPainter` overlay、回転、partial update、
background復帰、resource rebuild、dispose/remount、exception counter/logの確認は
`packages/eqmonitor_map/README.md`のchecklistに従い、物理端末で別途実施します。

## Validation

```bash
mise install flutter
mise exec -- flutter --version --machine
mise exec -- dart pub get --enforce-lockfile
mise exec -- dart format --output=none --set-exit-if-changed \
  packages/eqmonitor_map/lib packages/eqmonitor_map/test packages/eqmonitor_map/example/lib
mise exec -- flutter analyze --no-pub --fatal-infos packages/eqmonitor_map
mise exec -- actionlint \
  .github/workflows/wc-check-eqmonitor-map-scene-spike.yaml \
  .github/workflows/wc-check-dart-analyze.yaml \
  .github/workflows/wc-check-dart-test.yaml \
  .github/workflows/wc-check-integration.yaml \
  .github/workflows/deploy-app.yaml \
  .github/workflows/wc-changes.yaml
cd packages/eqmonitor_map && mise exec -- flutter test
```

- package unit test: 50件pass
- strict analyze: issue 0
- format、actionlint、`git diff --check`: pass

## Deferred work

- Performance HUD
- Widget/golden/performance testとbenchmark
- iOS/Android実機profile/release manual smoke
- PMTiles/MVT trusted tile pipeline
- 宣言的`MapNode`/`MapElement`とreconciler
- label placement/collision/semantics

検証の未完了項目は
[`docs/todo/800_eqmonitor_map_deferred_verification.md`](../../todo/800_eqmonitor_map_deferred_verification.md)
で追跡します。bearing/pitch、Web/desktop、汎用package化は初期scope外です。
