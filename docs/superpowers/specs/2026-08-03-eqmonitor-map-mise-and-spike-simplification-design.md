# EQMonitor Map mise・Scene spike簡素化設計

## 目的

Flutter SDKの導入をYumNumm版`mise-flutter`へ一本化し、地図本実装を進めるうえで不要な
Scene spike evidence、validator、Dart define manifestを削除する。Flutter Sceneの手動
smoke testに必要な最小exampleだけを残す。

## Toolchain

`mise.toml`をtoolchainの正本とする。

- `[plugins]`で`flutter = "https://github.com/YumNumm/mise-flutter.git"`を宣言する。
- `[tools]`のFlutterは
  `4dacd3fc91d96262a33e5c598e17d816f0b35641`へ固定する。
- 開発者はproject rootで`mise install`を実行する。個別に登録する場合の
  `mise plugin install flutter https://github.com/YumNumm/mise-flutter.git`もroot
  `README.md`へ記載する。
- `.flutter-scene-sdk`、`mise bootstrap repos`、削除済み`tool/eqmonitor_map` wrapperは
  使用しない。
- `mise.lock`は`mise.toml`と一致させ、FlutterとJavaを含む解決結果を固定する。

GitHub ActionsはFlutter SDKを`actions/checkout`で別途取得しない。`mise-action`がproject
configのcustom pluginを解決し、jobが使うFlutterと追加toolだけをinstallする。repository
内の全workflowから`mise bootstrap repos status`を除去する。

## 削除する仕組み

次を完全に削除する。

- `write_scene_spike_defines.dart`とそのtest
- compile-time build manifestとcheckout dirty判定
- canonical evidence JSONの生成・保存・clipboard UI
- evidence model、collector、gate、validatorと生成コード・test
- operator attestation checklist
- evidence専用のframe timing集計とCI contract test
- `example/evidence` directoryと4 run gate
- evidence採取だけを目的とする文書、TODO、workflow step

Flutter/Engine/Dart revisionをruntimeのDart defineへ複製しない。Flutter revisionは
`mise.toml`、Flutter Scene revisionは`packages/eqmonitor_map/pubspec.yaml`とlockfileを
正本とする。

## 残すScene example

`packages/eqmonitor_map/example`はFlutter Sceneが対象端末で起動するmanual smoke testとして
残す。UIは次だけを提供する。

- procedural meshとcustom materialの表示
- `TextPainter` overlay
- partial position/color updateの開始・停止
- app resource rebuild
- controller dispose/remount
- frame、partial update、resume、remount、rebuild、exceptionの簡易counter

証跡ファイルやpass/fail判定は生成しない。開発者はprofile/releaseで画面を操作し、描画、
回転、background復帰、remount後の継続動作、例外の有無を目視・端末logで確認する。

## 文書

root `README.md`の環境構築へcustom Flutter plugin、`mise install`、revision確認手順を追加する。
`packages/eqmonitor_map/README.md`にはexampleのprofile/release実行とmanual checklistだけを
残す。旧bootstrap、evidence、validator、古いFlutter Scene revisionへの参照は削除する。

過去の実装計画は履歴として残せるが、現在の正しい操作手順と誤認される箇所には廃止済みで
あることを明記する。knowledge文書は現行toolchainへ更新する。

## 検証

現環境で次を実行する。

1. `mise plugins ls --urls`でYumNumm版pluginを確認する。
2. `mise install flutter`と`mise exec -- flutter --version --machine`で固定revisionを確認する。
3. `flutter pub get --enforce-lockfile`後、resolved Flutter Scene revisionがlockfileと一致する
   ことを確認する。
4. `packages/eqmonitor_map`のformat、strict analyze、unit testを実行する。
5. 関連workflowへ`actionlint`を実行する。
6. Linuxで実行できないiOS/Android profile/release smoke testは、READMEのmanual checklistへ
   明示し、実行済みとは扱わない。

## 非対象

- PMTiles/MVT、Foundation、production rendererの実装
- performance HUD、golden、benchmark
- Flutter SceneのGPU completion/context/dispose APIに対する独自gate
- 実機結果のcanonical artifact化
