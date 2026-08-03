# EQMonitor Map Scene physical verification plan

## Purpose and current status

Flutter Scene spikeを物理iOS/Android端末のprofile/releaseで再現可能に検証し、schema v4
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
| Widget interaction matrix | NOT RUN / DEFERRED | foundation UI未実装 |
| deterministic golden matrix | NOT RUN / DEFERRED | Fill/Line/label renderer未実装 |
| physical profile performance/HUD overhead | NOT RUN / DEFERRED | renderer、基準端末、承認済み閾値なし |

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

stdoutが単一のcanonical JSONであること、4 runにmissing/duplicateがないこと、schema v4、
固定revision、engine artifact content hash、provenance、counter/performance/runtime proofが
一致することを確認する。
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

## Deferred Widget verification

ownerはFlutter UI担当、review ownerはEQMonitor map maintainerとする。foundationのcamera、
loading/degraded state、gesture actionを公開後、network、wall/monotonic clock、viewport、DPRを
注入可能なfakeへ固定する。テストは実通信、現在時刻、乱数、platform channelへ依存させない。

最低matrixは次とする。

- pan: pointer deltaと期待camera centerを固定する。
- pinch zoom: 2 pointerの開始/終了座標と期待zoomを固定する。
- loading: 初回snapshot未着時のprogress semanticsと可変text scaleでoverflowがないこと。
- degraded: stale/expired/error fixtureごとの表示、操作可否、semanticsを検査する。
- logical viewport `390x844` / `800x1280`、DPR `1.0` / `2.0` / `3.0`を上記へ適用する。

実装時にtest fileを作成し、repository rootから次を実行する。

```bash
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter test --no-pub \
  packages/eqmonitor_map/test/widget
```

全matrixがexit 0、例外/overflow/pending timerがなく、同じfixtureから同じcamera/state/semanticsを
得ることを受入条件とする。失敗時はfixture、入力sequence、viewport/DPR、failure logを保存し、
期待値を実出力へ合わせるだけの変更は行わない。現状態は`NOT RUN / DEFERRED`である。

## Deferred golden verification

ownerはrenderer担当、baseline review ownerはEQMonitor map maintainerとdesign担当とする。
固定PMTiles/MVT fixture、固定viewport/camera、bundled font、注入clockを使用し、networkと
host fontへ依存させない。最低matrixはFill、Line、labelそれぞれについてLight/Dark、
text scale `1.0` / `1.5` / `2.0`、DPR `1.0` / `2.0` / `3.0`を組み合わせる。north-upの
真上視点だけを対象とし、bearing/pitch baselineは作成しない。

review済みbaselineの検査は次で実行する。baseline更新は差分画像をreviewする専用changeでのみ
行い、通常検証では`--update-goldens`を付けない。

```bash
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter test --no-pub \
  packages/eqmonitor_map/test/golden
```

全matrixがexit 0で、未承認のpixel diff、overflow、missing glyphがないことを受入条件とする。
失敗時はactual/expected/diff image、fixture revision、viewport/DPR/theme/text scaleをartifactへ
保存する。許容差は測定とreviewなしに設定せず、失敗を隠すbaseline更新を禁止する。現状態は
`NOT RUN / DEFERRED`である。

## Deferred physical performance and HUD-overhead verification

ownerはmobile renderer担当、review ownerはperformance担当とEQMonitor map maintainerとする。
foundation renderer、固定地図fixture、計測event、HUD on/off切替、hostへcanonical resultを返す
integration driver、物理iOS/Android基準端末が揃った後にprofile modeだけで測定する。端末model、
OS、backend、thermal state、電源状態、固定revisionを各artifactへ記録する。

各platform/backendで同一操作scriptをHUD off/onそれぞれ5回実行する。各runは同じviewportと
fixtureでpan、pinch zoom、高速移動、background復帰を行い、frame build/raster、dropped frame、
queue待機、decode、mesh build、GPU submission/completion、cache、CPU/memory、計測event dropを
収集する。実装後の実行形は次とし、`physical_device_id`と出力先を空のまま実行しない。

```bash
test -n "$physical_device_id"
test -n "$performance_artifact_directory"
for hud_mode in off on; do
  for repetition in 1 2 3 4 5; do
    EQMONITOR_PERFORMANCE_ARTIFACT_DIRECTORY="$performance_artifact_directory" \
      MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter drive --profile \
      -d "$physical_device_id" \
      --driver=test_driver/integration_test.dart \
      --target=integration_test/eqmonitor_map_performance_test.dart \
      --dart-define=EQMONITOR_PERFORMANCE_HUD="$hud_mode" \
      --dart-define=EQMONITOR_PERFORMANCE_REPETITION="$repetition"
  done
done
```

artifactにはraw sample、集計値、device/build metadata、操作script version、HUD mode、repetition、
exceptions/event drop、device logを含める。5回すべてが完走しraw artifactを読めること、例外と
event dropがないこと、HUD off/on差を同一metricで算出できることを測定完了条件とする。
frame/memory/HUD overheadのpass閾値は実測baselineとreviewで別途承認するまで設定しない。
閾値未承認、thermal throttling、欠測、途中失敗はpassにせず`NOT RUN / DEFERRED`またはfailed
としてartifactと再現commandを残す。現状態は`NOT RUN / DEFERRED`である。

## Failure handling and deferred verification

failure時はcanonical JSON、build/device log、backend、操作回数、memory/frame timingを保存し、
原因と再現手順をknowledge/TODOへ追記する。壊れたJSONを修復してpassさせず、修正後にrunを
最初から再採取する。

Widget/golden/performance benchmark、Performance HUDと回帰閾値の追跡先は
[`docs/todo/800_eqmonitor_map_deferred_verification.md`](../../todo/800_eqmonitor_map_deferred_verification.md)
とする。上記sectionを実行するまで、このphysical gate作業では実行済み扱いにしない。
