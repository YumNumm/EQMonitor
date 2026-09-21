# Asset Pack の同梱・更新・内容検証

2026-09-21 にアプリ実装・staging script・pubspecと照合。
公開レイアウト、dispatch、署名鍵・R2設定は [配布runbook](../asset-pack-cd.md) を参照する。
release実機検証・容量・配信地物の未完了項目は [Asset Pack TODO](../todo/850_asset_pack.md)。

## 同梱の正本とローカル準備

- 配布元は `https://assets.eqmonitor.app/v1/assets`。Managed Background Assets / Play Asset Deliveryは使わない。
- 同梱解決の正本は `app/lib/feature/asset_pack/data/repository/bundled_asset_pack_repository.dart`。
  `rootBundle` から `<applicationSupport>/eqmonitor_asset_packs/bundled/<pack_version>/` へ展開する。
- `packages/assets_util` は削除済み。ただしAndroidのgenerated assets、Xcodeの `platform/` folder参照、
  `AssetsUtil.xcframework` は残る。runbookのnative配置説明を現在の読み出し経路と混同しない。
- repository rootで署名済み公開物をstagingする。秘密鍵・GH_TOKENは不要。

```sh
mise exec -- tool/asset_pack/stage_from_r2.sh --target bundled
# iOS native用slim JMA表も更新する場合
mise exec -- tool/asset_pack/stage_from_r2.sh --target all
```

- `--target ios-native` はslim表のみ。版を固定する場合は `--version X.Y.Z` を追加する。
  manifest署名・entry・ZIP size/SHA-256・必須レイアウトを検証後に `app/assets/platform/` を置き換える。
- `app/assets/parameters/jma_code_table.json` はコミット対象。同梱pack実体はGit管理外。
- Flutter assetsは再帰しない。pubspecには `assets/platform/`、`assets/platform/map/`、
  `assets/platform/parameters/` が個別宣言されており、新しいsubdirectoryは追記が必要。
- 現checkoutでは `platform/` も追跡済み `.gitkeep` も存在しない。
  旧記録の「clean checkoutには `.gitkeep` がある」は成立せず、ビルド前stagingが必要。
  ディレクトリだけ作ってもmanifestがないため実行時は `AssetPackNotReadyException` になる。
- stagingはディレクトリごと交換するため、将来placeholderを追加する場合も消失を考慮する。
  空ディレクトリ・pubspec同梱漏れのgateはTODOとして残る。

## runtimeで維持する契約

- 同梱packはstagingへ展開後にrenameする。失敗した展開は破棄し、再試行可能にする。
  解決不能は `AssetPackNotReadyException` とし、固定値・偽地図へフォールバックしない。
- `AssetPackDistributionRepository` はEd25519検証済みmanifestだけを保存し、
  受理済みrevision / latest versionの巻き戻しと `minimum_app_version` 不足を検出する。
- 署名は JSON 再serialize 後でなく受信 byte 列そのものを parse 前に検証する。manifest の形式は `asset_pack_distribution_manifest_validator.dart` が正本。正の revision、prerelease なしの版、重複なし降順・latest 一致、version に対応した固定 archive path、空でない日英 changelog を検証する。
- 配布ZIPはimmutable。公開順序 `ZIP → manifest.sig → manifest.json` と公開後再検証はrunbookの契約。
  backendの現在の公開実行結果は今回未確認。
- `AssetPackUpdateInstaller` はZIP size/SHA-256、展開後全fileのsize/SHA-256を検証する。
  未知の将来asset IDも検証し、未宣言fileを拒否する。
- `AssetPackArchiveExtractor` は絶対/drive/backslash/dot-segment path、重複path、symlinkを拒否する。
  上限は `AssetPackArchiveLimits`（現行1,024 entries、単体768 MiB、総展開1 GiB）が正本。
- 検証済みstagingをactivateしてからactive preferenceを更新し、他のdownload版を掃除する。
  downloaded版の読込み・整合性検証に失敗したらpreferenceと該当directoryを外し、
  同じreadを同梱packで一度だけ再試行する。同梱packをdownload cleanupへ巻き込まない。
- アプリ更新で同梱版の方が新しくなった場合は古いactive downloadを削除し、同梱版を選ぶ。
- downloaderのtask IDはversion固定。完了済みZIPは再取得せず検証へ進める。
  OS終了後の復元・進捗継続はrelease smokeで確認する。
- 公開鍵の正本は `trusted_asset_pack_keys.dart` と `tool/asset_pack/trusted_keys/`。
  現行key IDは `asset-pack-2026-08-16`。旧署名manifestが配信され得る間は旧公開鍵を残す。

## PMTilesの配信内容を検証する

- SHA-256一致は「配信されたbytesを正しく受け取った」証拠で、地物の完全性は保証しない。
  ZIP容量、layer ID、`tilestats.count` だけで合格にせず、実tileのdistinct `regioncode` を元データと比較する。
- 旧v0.0.1/v0.0.2で市区町村が1894→65へ減った原因は、CIのtippecanoe 2.49.0によるdrop。
  2.79.0では同入力・z8で1894を保持した。`maxzoom=8` 自体を原因としてz10へ戻さない。
- metadataの `generator_options` / `strategies`、特に `dropped_by_rate` と生成ツール版を確認する。
  1894は旧fixtureの期待値であり、現在の元データが更新された場合は期待集合も更新する。
- GDAL 3.8.4の `COORDINATE_PRECISION=7` によるGeometryCollection化は独立した欠落原因。
  `areaForecastLocalE=530`（兵庫県北部）、`areaForecastLocalEew=9280`（兵庫）の存在も確認する。
  tippecanoe固定だけでこの問題まで解決済みとはしない。
- 生成ツールはCI/localで揃える。最新配信物にbackend修正が含まれるかは未確認。
  旧版への単純rollbackを完了扱いにせず、地物被覆と日本の二重描画も検証する。

## 未検証のrelease smokeと容量

- Android release APK/AAB・iOS releaseで、offline初回起動、更新同意・進捗、R2更新適用、
  破損時fallback、OS終了後のdownload復元を確認する。platform/build mode/pack versionを結果に残す。
- R2設定・署名検証・Dart unit test成功は端末検証の代わりにはならない。release smokeは未完了。
- `rootBundle.load()` は単一asset全体をメモリへ載せる。初回peak RSSとbundle＋展開先の
  二重ディスク容量を低メモリ端末で測る。書込み後のevictだけでpeak低下を保証しない。
- AndroidのR8/PlatformView起動確認は [ネイティブビルド](native_build_release.md) を参照する。
