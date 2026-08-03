# EQMonitor Map Scene physical verification plan

## Purpose and current status

Flutter Scene spikeを物理iOS/Android端末のprofile/releaseで再現可能に検証し、schema v3
canonical evidenceを採取する計画である。2026-08-02のLinux hostでは以下の全項目を
実行できないため、現在状態は`NOT RUN / BLOCKED`である。pass表現や代替evidenceを
使用しない。

## Owners and prerequisites

実施ownerはmobile renderer担当者、review ownerはEQMonitor map maintainerとする。
実施前に次を満たす。

- macOS、固定Flutter SDK、Xcode、署名可能なphysical iOS device
- Android SDK/NDK、固定Flutter SDK、physical Android device
- profile/release buildが可能な署名・developer mode設定
- fixed revisions:
  - Flutter framework `4dacd3fc91d96262a33e5c598e17d816f0b35641`
  - Flutter Scene `695c954f237fabef65d49fa7199002851d2dcd88`
  - Dart source `d402ff7c9c8442d64aa8148609480aa0e04a24fd`
  - engine source `b1e405a9c311d858bef870c472bb24c015f4bcf9`
  - engine artifact `73ac711b34da2a090d79ddb423918de40a7ffbf9`
- `git status --porcelain=v1 --untracked-files=all`が空のclean checkout
- `mise bootstrap repos status --missing`が成功
- device IDを`flutter devices`で確認し、変数が空でないことを`test -n`で検証

## Linux host limitations

このhostでは次を実行していない。すべて`NOT RUN / BLOCKED`である。

| Verification | Status | Blocker |
| --- | --- | --- |
| Android SDK/profile/release build | NOT RUN / BLOCKED | Android SDKなし |
| Android physical device | NOT RUN / BLOCKED | deviceなし |
| iOS/macOS/Xcode/profile/release build | NOT RUN / BLOCKED | Linux host |
| iOS physical device | NOT RUN / BLOCKED | deviceなし |
| Impeller/Vulkan/GLES real GPU backend | NOT RUN / BLOCKED | real GPU/deviceなし |
| physical lifecycle/activity recreation | NOT RUN / BLOCKED | deviceなし |
| portrait/landscape、DPR変化 | NOT RUN / BLOCKED | deviceなし |
| physical memory/frame timing | NOT RUN / BLOCKED | deviceなし |

## Preflight and clean-runner compile

各platform ownerはfresh runnerで依存cacheに頼らず、DataAssets/native asset/fmat hookを
含むcompileを確認する。generated/native assetが欠落する場合はrunへ進まない。

```bash
git status --porcelain=v1 --untracked-files=all
mise bootstrap repos apply --yes
mise bootstrap repos status --missing
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter --version --machine
cd packages/eqmonitor_map/example
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter clean
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter pub get
MISE_EXEC_AUTO_INSTALL=0 mise exec -- \
  dart run ../tool/write_scene_spike_defines.dart
```

Android ownerはprofile/release APKまたはapp bundle compile、iOS ownerは署名前提を満たす
profile/release app compileを行い、DataAssets/native asset/fmat hookのcompile logを保存する。

## Android physical runs

1. physical device IDを確認し、Vulkan対応とOS/device modelを記録する。
2. Android profile/releaseをbuildし、同じartifactをphysical deviceでrunする。
3. backendをUIでphysical Vulkanとしてattestし、実際のbackend logと照合する。
4. 各modeで60秒以上partial updateを実行する。
5. procedural mesh、unlit/custom material、position/color partial update、label overlayを観察する。
6. background/foregroundを3回、dispose/remountを3回行う。
7. portrait/landscapeとDPR、exceptions、controller/app resource generation、memory、frame
   timingを記録する。
8. Developer Optionsの`Don't keep activities`を有効にし、Activity recreationを3回行う。
9. support対象にGLES fallbackがある場合は別runで同じ手順を実施する。primary 4 evidence
   とduplicateになるJSONは同じgate directoryへ置かず、補助記録として分離する。

```bash
test -n "$physical_android_device_id"
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter build apk --profile \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter build apk --release \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter run --profile \
  -d "$physical_android_device_id" \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter run --release \
  -d "$physical_android_device_id" \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json
```

## iOS physical runs

1. physical device ID、device model、iOS versionを記録する。
2. iOS profile/releaseをbuildし、physical deviceでrunする。
3. 各modeで60秒以上partial updateを実行し、描画、label、custom materialを観察する。
4. background/foregroundを3回、dispose/remountを3回行う。
5. portrait/landscapeへ回転し、resizeとDPRを記録する。
6. exceptions、controller/app resource generation、memory、frame timingを記録する。

```bash
test -n "$physical_ios_device_id"
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter build ios --profile \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter build ios --release \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter run --profile \
  -d "$physical_ios_device_id" \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter run --release \
  -d "$physical_ios_device_id" \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json
```

## Evidence capture and names

UIの`Copy canonical JSON`から得た文字列を加工せず次へ保存する。

- `packages/eqmonitor_map/example/evidence/ios-profile.json`
- `packages/eqmonitor_map/example/evidence/ios-release.json`
- `packages/eqmonitor_map/example/evidence/android-profile.json`
- `packages/eqmonitor_map/example/evidence/android-release.json`

各runには端末/OS/backend/build mode、固定revision、clean renderer revision、60秒以上の
elapsed time、frame/partial/lifecycle/remount count、runtime custom material proof、
exceptions、generation、performance snapshot、required capabilityを含める。

## Validation and acceptance criteria

repository rootから次を実行する。

```bash
MISE_EXEC_AUTO_INSTALL=0 mise exec -- \
  dart run packages/eqmonitor_map/tool/validate_scene_spike_evidence.dart
```

stdoutが単一のcanonical JSONであること、4 runにmissing/duplicateがないこと、schema v3、
固定revision、provenance、counter/performance/runtime proofが一致することを確認する。
missing、duplicate、malformed、unknown schema、invalid field、revision mismatch、failedまたは
unobserved capabilityが1つでもあればexit 1としてrejectする。

`03-foundation`の受入条件はvalidator exit 0である。ただし現固定Flutter Sceneには次の
3 public APIがなく、現状は各runで`unavailablePublicApi/unobserved`となるためpass不能である。

- `gpuCompletionOrSafeRetirement`
- `contextResourceRebuild`
- `explicitResourceDisposal`

## Upstream API re-audit

Flutter Scene更新候補でpublic APIが追加された場合、固定commitで次を再監査する。

1. curated public barrelからAPIへ到達できること。
2. iOS/Android native実装がplaceholder/empty implementationでないこと。
3. GPU completionのordering、context loss/restore generation、resource disposal ownershipを
   sourceとtestで確認すること。
4. fixed revision、schema、required provenance、gate testをreview付きで更新すること。
5. clean checkoutから4 physical runsをすべて再採取すること。

既存evidenceのstatus変更やmanual attestationだけではpassさせない。

## Failure handling and deferred verification

failure時はcanonical JSON、build/device log、backend、操作回数、memory/frame timingを保存し、
原因と再現手順をknowledge/TODOへ追記する。壊れたJSONを修復してpassさせず、修正後にrunを
最初から再採取する。

Widget/golden/performance benchmark、Performance HUDと回帰閾値は
[`docs/todo/800_eqmonitor_map_deferred_verification.md`](../../todo/800_eqmonitor_map_deferred_verification.md)
へdeferする。このphysical gate作業では実行済み扱いにしない。
