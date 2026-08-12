# eqmonitor_map foundation contracts

## Foundation contract

Issue #1590の実装範囲は、immutableな宣言scene、1 frame 1 clock capture、
source-instance付きatomic revision、canonical render order、version付きpacked
packet/batch、bounded performance観測である。runtime foundationはWidget、GeoJSON、
Style JSON、network client、Flutter Scene/scene型を保持しない。

### 参照実装

- KEVi `5a2bf513b6b9c93ee06473f70b6d27ee96070b3f`から、snapshot、phase内の
  declaration order、reverse hit-test、bounded metricsを採用した。
- dashmap `a6ff92edd999e922f81d26d209d8f589faee3fd0`から、typed-dataのCPU job、
  tile batch、bounded workを採用した。
- Miller projection、global declaration order、mutable setter layer、domainによる
  Flutter Scene直接所有は採用しない。

### 所有境界

- 描画phaseはpositive versionを持つ`MapRenderPhasePolicy`としてcallerが渡す。
  foundationが推測する固定phaseは`labelForeground`だけで、sortはphase、phase内宣言順、
  source、overscaled tile、featureの順とする。
- revisionはsource instance、base/target revision、content digestを検証し、deep ownership
  完了後だけcommitする。active sourceと異なるdeltaはcurrentやresync latchを変更しない。
- packed layout、mesh、packet、batchはversionとtyped bytesを保持する。`contractVersion`、
  meshの`payloadVersion`、`batchKey`、layout、pipeline、material、phase、
  phase-policy versionが一致する連続packetだけをbatch化する。transformはcompatibility
  から除外するが、packetと1対1のimmutable tableとして保持する。
- performance collectorはschema/domainとmonotonic順を集約前に検証する。valid sampleは
  detailed sampling、rate limit、buffer dropより先にaggregateへ入れる。`record`はsample時刻
  までwindowを自動advanceし、完了snapshotを返す。partial snapshotはactive aggregateを
  resetしない。

後続の所有者は、#1591がPMTiles I/O、#1593がFlutter Scene/GPU lifecycle、#1595が
seismic payload、#1596がapp/Home統合である。このfoundationから先取りしない。

### 検証command

Flutter/Dart commandはrepositoryの固定toolchainを使い、必ず`mise exec --`経由で実行する。

```bash
cd packages/eqmonitor_map
rg -n '^## Foundation contract$' ../../docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
mise exec -- dart format --output=none --set-exit-if-changed lib test
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/foundation_public_api_test.dart test/widget/base_map_view_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

このTaskではdevice、simulator、golden、E2Eを実施していない。Flutter Scene/GPUの可視出力、
lifecycle、実機性能は#1593以降のplatform確認として残る。
