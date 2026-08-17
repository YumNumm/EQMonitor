# Asset Pack Top-Level Function Cleanup Design

## Goal

`asset_pack` の既存動作と公開 provider API を維持したまま、
`avoid_top_level_functions` の33件をすべて解消する。

## Context

Asset Pack 配信機能には、JSON検証、ZIP展開、ダウンロード、保存、
切り替えを補助するトップレベル関数が残っている。通常の
`flutter analyze app` では検出されないが、Melosから package context で
解析すると native analyzer plugin が warning として報告する。

lint の無効化や ignore は行わない。生命に関わる地図・観測点データを
扱うため、検証処理の省略、固定値 fallback、ランダム値生成も行わない。

## Architecture

各 helper を、その処理を既に統括している責務クラスの public method へ
移動する。新しいグローバル状態や Riverpod provider は追加しない。
既存 provider 関数は `@Riverpod` による正規の例外なので維持する。

- 配信 manifest の型検証は
  `AssetPackDistributionManifestJsonValidator` の static method とする。
- ZIP entry 検証と展開は `AssetPackArchiveExtractor` に統合する。
- content manifest の読込・解析・ファイル検証は
  `AssetPackContentValidator` に統合する。
- 配信HTTP、署名sidecar decode、rollback防止、cache保存は
  `AssetPackDistributionRepository` に統合する。
- active pack 読込、fallback、SHA-256検証は
  `AssetPackRepository` に統合する。
- version検証、bundled source 解決、staging install、cleanupは
  `AssetPackStorageRepository` に統合する。
- archive SHA-256検証と一時ファイル削除は
  `AssetPackUpdateInstaller` に統合する。
- background downloader の標準adapterは
  `R2AssetPackArchiveDownloader` の static method とする。

## Data Flow

既存の呼び出し順、引数、戻り値、例外型を変えない。呼び出し元は
同じインスタンス上の public method を呼ぶ。別repositoryが必要とする
manifest読込は、既に注入されている `AssetPackContentValidator` の
public method を使用する。

constructorで受け取る download adapter や file resolver は維持し、
既存テストの fake 注入境界を変えない。Riverpod provider名と生成コードの
再生成も不要にする。

## Error Handling

`AssetPackArchiveException`、`AssetPackContentException`、
`AssetPackDistributionException`、`AssetPackNotReadyException`、
`AssetPackStorageException`、`AssetPackInstallException` の発生条件と
日本語メッセージを保持する。catch範囲、cleanup順、rollback判定も変えない。

analyzer telemetry の外部通信失敗は製品コードの問題ではないため、
検証時に Dart analytics を無効化して再実行する。

## Testing

挙動変更を行わないため、既存の asset pack unit/widget tests を回帰テストに
使用する。先に `avoid_top_level_functions` 33件を RED として記録済みで、
実装後は次を fresh run する。

```bash
cd app
mise exec -- flutter test test/feature/asset_pack
cd ..
DASH__SUPPRESS_ANALYTICS=true mise exec -- dart run melos run analyze
cd app
mise exec -- flutter test
```

最終 analyze は info、warning、error のすべてが0件であることを確認する。
