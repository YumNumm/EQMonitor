# MapLibre ベースマップ復旧設計

## 背景

全 MapLibre 画面が共有するベースマップソースが、従来の
`https://v2.map.eqmonitor.app/all.pmtiles` から同梱済みの
`earthquake_tsunami_all.pmtiles` に切り替えられた。

同梱済みファイルには `countries` がなく、既存スタイルが参照する
source-layer 名とも一致しない。また Android の MapLibre Native は
`pmtiles://asset://` をサポートしない。

## 方針

- 従来の HTTPS `all.pmtiles` を取得し、既存のプラットフォームアセット
  `earthquake_tsunami_all.pmtiles` の内容を置き換える。
- アセット名と iOS / Android のプロジェクト設定は維持し、変更範囲を抑える。
- `BaseMapPmtilesRepository` は `AssetsUtil` から絶対パスを解決する。
- MapLibre には `pmtiles://${Uri.file(absolutePath)}` を渡す。
- HTTPS への実行時フォールバックは追加しない。

## エラー処理

ローカルファイルが存在しない、または空の場合は現在の明示的なエラーを維持する。
生命に関わる表示で不正な地図へ黙って切り替えない。

## 検証

新規テストは追加しない。代わりに以下を確認する。

- 取得したファイルが PMTiles v3 であること
- メタデータに既存スタイルが必要とする source-layer が含まれること
- `pmtiles://asset://` と到達不能コードが残っていないこと
- 対象 Dart ファイルの解析が通ること
- iOS / Android のアセット登録が維持されていること
- `git diff --check` が通ること

## 公開

修正を分割可能な粒度でコミットし、`develop` 宛ての draft PR を作成する。
