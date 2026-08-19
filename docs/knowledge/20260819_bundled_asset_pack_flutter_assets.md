# 同梱 Asset Pack を Flutter assets から展開する

`packages/assets_util`（iOS/Android ネイティブ）を削除し、アプリ同梱 Asset Pack
の解決を純 Dart 化した。以降このルールに従う。

## 構成

```
app/assets/platform/            # stage_from_r2.sh --target bundled の配置先
├── manifest.json
├── map/
└── parameters/
```

- `BundledAssetPackRepository` が `rootBundle` から
  `<applicationSupport>/eqmonitor_asset_packs/bundled/<pack_version>/` へ展開する。
- `AssetPackStorageRepository` は展開結果を「同梱 Pack」として扱い、
  R2 ダウンロード版が壊れたときの復帰先にする。
- 展開先は staging ディレクトリからの `rename` でしか出現しないため、
  中断しても半端な Pack は読まれない。
- 同梱 Pack が使えない理由はすべて `AssetPackNotReadyException` に寄せる。
  固定値・偽データへのフォールバックはしない。

## pubspec の注意

`flutter.assets` は再帰しないため、Pack のサブディレクトリを個別に列挙する。

```yaml
    - assets/platform/
    - assets/platform/map/
    - assets/platform/parameters/
```

宣言したディレクトリが存在しないと `flutter build` は失敗する。Pack を staging
していない clean checkout でもビルドできるよう、各サブディレクトリに
`.gitkeep` をコミットしてある。`stage_from_r2.sh` は `platform` ディレクトリを
まるごと差し替えるので、staging すると `.gitkeep` は消える（想定どおり）。

Pack にサブディレクトリが増えたら pubspec も更新する。忘れるとそのファイルは
同梱されず、manifest 検証で `AssetPackNotReadyException` になる。

## 動作確認

```bash
cd app
mise exec -- flutter test --no-pub \
  test/feature/asset_pack/bundled_asset_pack_repository_test.dart
```

`AssetManifest.bin` を含む `CachingAssetBundle` の fake を用意すれば、
展開・再展開スキップ・世代掃除・失敗時の再試行まで unit test で確認できる。

## 既知のトレードオフ

`rootBundle.load()` は asset 全体をメモリへ載せるため、数十MB の基盤地図
PMTiles で初回起動時のピークメモリとディスク使用量が増える。詳細と対策候補は
`docs/todo/800_bundled_asset_pack_flutter_assets_tradeoffs.md` を参照。
