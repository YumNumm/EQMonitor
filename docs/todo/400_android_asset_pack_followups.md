# Android Asset Pack 周辺の未対応項目

`--target android-debug`（`tool/asset_pack/stage_from_r2.sh`）でローカルの
`flutter run` から Asset Pack を読めるようにした際に見つかった、今回は対応を
見送った項目。

## 1. Asset Pack デバッグ画面が Android で必ずエラーになる

`AssetsUtil.diagnosePack` は Apple プラットフォーム専用で、Android では
`UnsupportedError` を投げる。`asset_pack_debug_page.dart` はプラットフォームを
問わずこれを呼ぶため、Android では `providerDidFail: assetPackDiagnosticsProvider`
が必ず発生する。

画面側でプラットフォーム分岐し、Android では `filesDir` の展開状況を出す別の
診断内容にする必要がある。

## 2. `AssetsUtil.kt` の空文字 assets root ブランチ

`resolvePackRoot` の `candidateAssetRoots = listOf(packName, "")` のうち空文字
側にヒットすると、`copyAssetDirectoryRecursively` が `flutter_assets` を含む
APK の assets ツリー全体を `filesDir/eqmonitor_assets/` へ再帰コピーしてしまう。

現状 AGP は APK ビルドで Asset Pack のアセットを assets ルートへ融合しない
（`:app:assemble*` の依存に Asset Pack タスクが1つも現れない）ため到達しないが、
将来 AGP の挙動が変わると顕在化する。空文字候補を削るか、pack の
`manifest.json` に列挙されたパスのみをコピーする実装に変更する。

## 3. 展開キャッシュが versionCode 単位のためローカルで stale になる

`extractFusedAssetPackToFilesDir` は `filesDir/eqmonitor_assets/.version` に
versionCode を書いて再展開を抑止する。ローカル開発で versionCode を変えずに
別バージョンの pack を再ステージすると、古い展開結果が使われ続ける。

暫定回避は `adb shell pm clear net.yumnumm.eqmonitor`。恒久対応として marker に
manifest の `pack_version` も含めることを検討する。
