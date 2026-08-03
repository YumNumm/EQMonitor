## Summary

- EQMonitor専用のminimal Flutter package/exampleとFlutter Scene adapter spikeを追加します。
- schema v4の再現可能なobservability/evidence gateとfail-closed validatorを追加します。
- 物理端末gateはこのLinux環境では`NOT RUN / BLOCKED`で、evidence JSONは作成していません。

## Stack

- Base: `codex/eqmonitor-map-01-design`
- Head: `codex/eqmonitor-map-02-scene-spike`
- Next: `03-foundation`（device gateがexit 0になった場合だけ着手）

## Fixed revisions

- Flutter framework: `4dacd3fc91d96262a33e5c598e17d816f0b35641`
- Flutter Scene: `695c954f237fabef65d49fa7199002851d2dcd88`
- Dart source: `d402ff7c9c8442d64aa8148609480aa0e04a24fd`
- Flutter engine source: `b1e405a9c311d858bef870c472bb24c015f4bcf9`
- Flutter engine artifact: `73ac711b34da2a090d79ddb423918de40a7ffbf9`

## Device gate result

Result: `NOT RUN / BLOCKED`。

Linux hostにはAndroid SDK、physical Android device、macOS/Xcode、physical iOS deviceが
ありません。Android/iOS profile/release build、Impeller/Vulkan/GLES、physical lifecycle、
rotation/DPR、memory/frame timingを実行・観測していません。4 evidence JSONは欠落した
ままで、validatorはexit 1と4 missing runを返します。実施手順と受入条件は
[`physical verification plan`](../plans/2026-08-02-eqmonitor-map-scene-physical-verification.md)
に固定しています。

## Safety and fail-closed behavior

- Flutter Scene型をadapter境界へ隔離し、generation/source/resource authorityを分離します。
- compile-time manifestは固定SDK/Scene/Dart/renderer revisionとdirty checkoutを検証します。
- Flutter engine source revisionとartifact content hashを別fieldとして固定値と照合します。
- validatorはTask 5 gateを再利用し、missing/duplicate/malformed/unknown schema/invalid field、
  revision mismatch、failed/unobserved capabilityをすべてexit 1にします。
- stdoutは単一canonical JSONだけで、parse stackを出しません。
- 物理端末なしで空・架空・手編集したpass evidenceを作りません。

## Validation

実装完了時のfresh command結果をTask 7 reportに記録します。物理platform関連はすべて
`NOT RUN / BLOCKED`であり、validator非0は想定されるblocking resultです。

```bash
MISE_EXEC_AUTO_INSTALL=0 mise exec -- dart format --output=none \
  --set-exit-if-changed packages/eqmonitor_map
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter analyze --fatal-infos \
  packages/eqmonitor_map
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter test packages/eqmonitor_map/test
MISE_EXEC_AUTO_INSTALL=0 mise exec -- \
  dart run packages/eqmonitor_map/tool/validate_scene_spike_evidence.dart
git diff --check codex/eqmonitor-map-01-design...HEAD
```

## Known Flutter Scene API gaps

固定Flutter Sceneのpublic APIでは次を観測できず、schema v4 evidenceでは
`unavailablePublicApi/unobserved`です。この3項目がrequiredである間、4 run採取後も
global gateはpassしません。

- `gpuCompletionOrSafeRetirement`
- `contextResourceRebuild`
- `explicitResourceDisposal`

upstream追加時はpublic barrel、iOS/Android実装、semanticsを再監査し、schema/gateを
review後に4 runをclean checkoutから再採取します。

## Deferred work

- Widget/golden/performance test、benchmark、Performance HUD
- PMTiles/MVT trusted tile pipeline
- 宣言的`MapNode`/`MapElement`とreconciler
- label placement/collision/semantics
- 将来の3D、地下震源、断層面/断層モデル

deferred verificationは
[`docs/todo/800_eqmonitor_map_deferred_verification.md`](../../todo/800_eqmonitor_map_deferred_verification.md)
で追跡します。bearing/pitch、Web/desktop、汎用package化は初期scope外で、iOS/Android向け
EQMonitor専用rendererを維持します。
