# EQMonitor Map Flutter Scene device gate

## 2026-08-02の判断

Scene spikeの物理device gateは`NOT RUN / BLOCKED`であり、`03-foundation`へ進まない。
実行hostはLinuxで、物理iOS/Android端末、Android SDK、macOS/Xcodeがない。したがって
platform build、実GPU backend、lifecycle、rotation/DPR、memoryの証跡は採取していない。
evidence JSONも生成していない。

固定revisionは次の組合せだけを許可する。

- Flutter framework: `4dacd3fc91d96262a33e5c598e17d816f0b35641`
- Flutter Scene: `695c954f237fabef65d49fa7199002851d2dcd88`
- Dart source: `d402ff7c9c8442d64aa8148609480aa0e04a24fd`
- Flutter engine source: `b1e405a9c311d858bef870c472bb24c015f4bcf9`
- Flutter engine artifact: `73ac711b34da2a090d79ddb423918de40a7ffbf9`

toolchainの取得とFlutter Scene public APIの根拠は
[`20260802_eqmonitor_map_flutter_scene_toolchain.md`](20260802_eqmonitor_map_flutter_scene_toolchain.md)
を参照する。固定revisionやpublic APIの代わりにmanual attestation、時間経過、固定値を
使ってpassへ変換しない。

Flutter machine JSONの`engineRevision`と`engineContentHash`は同じ値ではない。前者は
engine source revision、後者はprecache済みengine artifact identityであり、schema v4
evidenceへ`flutterEngineRevision`と`flutterEngineContentHash`として別々に保存する。
compile-time manifestでcontent hashが欠落/blank、40文字lowercase SHAでない、または
`73ac711b34da2a090d79ddb423918de40a7ffbf9`と不一致なら採取前またはgateでfail closedにする。

## Gateの実行

物理端末runではclean checkoutからcompile-time manifestを作り、example UIで60秒以上
partial update、background/foreground、dispose/remount、portrait/landscape、DPR、
custom material、generation、exceptions、memory、frame timingを観測する。Androidでは
Vulkanと`Don't keep activities`も確認する。

```bash
cd packages/eqmonitor_map/example
MISE_EXEC_AUTO_INSTALL=0 mise exec -- \
  dart run ../tool/write_scene_spike_defines.dart
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter run --profile \
  -d "$physical_device_id" \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json

cd ../../..
MISE_EXEC_AUTO_INSTALL=0 mise exec -- \
  dart run packages/eqmonitor_map/tool/validate_scene_spike_evidence.dart
```

validatorはTask 5の`SceneSpikeGate`を正本とし、stdoutに単一のschema v4 canonical
JSONだけを
出す。現在は4 required runが欠落するためexit 1が正しい。実機runを採取しても次の3
capabilityはFlutter Scene public APIがなく、`unavailablePublicApi/unobserved`のため
global gateをblockする。

- `gpuCompletionOrSafeRetirement`
- `contextResourceRebuild`
- `explicitResourceDisposal`

upstream revisionに関連APIが追加された場合は、public barrel、native iOS/Android実装、
completion/callback semantics、resource ownershipを再監査する。その後schemaとrequired
provenanceをreviewし、validator testsを更新して固定revisionの4 runをすべて再採取する。
既存JSONのstatusだけを書き換えて再利用しない。

実施者、backend、build mode、DataAssets/native asset/fmat compile、受入条件、failure
handlingの正本は
[`physical verification plan`](../superpowers/plans/2026-08-02-eqmonitor-map-scene-physical-verification.md)
とする。
