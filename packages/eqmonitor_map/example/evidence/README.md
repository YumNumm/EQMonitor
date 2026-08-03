# Flutter Scene physical evidence

このdirectoryには物理端末のspike harnessが生成したschema v3 canonical JSONだけを
保存します。2026-08-02時点のLinux環境ではplatform buildと物理端末操作を実施できず、
4 runはすべて`NOT RUN / BLOCKED`です。空・架空・手編集したevidenceは追加しません。

## 必須ファイルと現在状態

| File | Platform | Mode | Status |
| --- | --- | --- | --- |
| `ios-profile.json` | physical iOS | profile | NOT RUN / BLOCKED |
| `ios-release.json` | physical iOS | release | NOT RUN / BLOCKED |
| `android-profile.json` | physical Android | profile | NOT RUN / BLOCKED |
| `android-release.json` | physical Android | release | NOT RUN / BLOCKED |

Androidのprimary evidenceはphysical Vulkan backendで採取します。support対象端末でGLES
fallbackも必要な場合は、必須4 runとduplicateにならないよう別directoryへ補助evidenceを
保存し、単独で検査してから結果を実施記録へリンクします。

## 固定revision

- Flutter framework: `4dacd3fc91d96262a33e5c598e17d816f0b35641`
- Flutter Scene: `695c954f237fabef65d49fa7199002851d2dcd88`
- Dart source: `d402ff7c9c8442d64aa8148609480aa0e04a24fd`
- Flutter engine source: `b1e405a9c311d858bef870c472bb24c015f4bcf9`
- Flutter engine artifact: `73ac711b34da2a090d79ddb423918de40a7ffbf9`

## 採取

clean checkoutでrevisionとdevice IDを確認し、example directoryから実行します。

```bash
git status --porcelain=v1 --untracked-files=all
mise bootstrap repos status --missing
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter devices
test -n "$physical_device_id"
MISE_EXEC_AUTO_INSTALL=0 mise exec -- \
  dart run ../tool/write_scene_spike_defines.dart
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter run --profile \
  -d "$physical_device_id" \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter run --release \
  -d "$physical_device_id" \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json
```

各runで60秒以上partial updateを続け、描画、label、custom material、例外、generation、
memory、frame timingを観察します。background/foreground、dispose/remount、回転、DPR
変化を実施し、Androidは`Don't keep activities`によるActivity recreationも確認します。
UIの`Copy canonical JSON`が返した文字列を対応ファイルへそのまま保存します。

DataAssets/native asset/fmat hookを含むclean-runner compileと詳細な操作・受入条件は
[`physical verification plan`](../../../../docs/superpowers/plans/2026-08-02-eqmonitor-map-scene-physical-verification.md)
を正本とします。

## 検査とfailure handling

repository rootから実行します。stdoutは単一のcanonical JSON、pass時はexit 0、欠落・
重複・malformed・unknown schema・invalid field・revision mismatch・failed/unobserved
capabilityではexit 1です。

```bash
MISE_EXEC_AUTO_INSTALL=0 mise exec -- \
  dart run packages/eqmonitor_map/tool/validate_scene_spike_evidence.dart
```

現在はexit 1で4 runすべてが`missingRuns`に列挙されるのが正しい結果です。実機採取後も
`gpuCompletionOrSafeRetirement`、`contextResourceRebuild`、
`explicitResourceDisposal`はpublic APIがなく`unavailablePublicApi/unobserved`なので、
validatorはpassしません。failure時はJSONと端末/build logを保持し、原因を修正または
upstream APIを再監査して再採取します。statusを手編集してpassへ変換しません。
