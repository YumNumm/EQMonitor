# 推定震度計算で不完全な震源データを除外する挙動のテストを追加する

## 背景

`app/lib/core/provider/estimated_intensity/provider/estimated_intensity_provider.dart` の
`_targetHypocenters` は、Task 12（`app/lib/core` 配下のトップレベル関数と `!` を解消する）で
次のように修正した。

- 修正前: 緯度・経度は `hypocenter?.latitude != null && hypocenter?.longitude != null` で
  フィルタしていたが、magnitude/depth は未チェックのまま `hypocenter!.magnitude!` のように
  `!` でアクセスしており、magnitude/depth のいずれかが null の EEW 電文が来ると
  実行時に例外が発生する潜在的なクラッシュリスクがあった。
- 修正後: `_toHypocenterInput` を新設し、magnitude/depth/lat/lon のいずれかが null なら
  `null` を返して `.nonNulls` でフィルタし、その地震を推定震度計算対象から安全に除外する
  ようにした。

## 残課題

この「不完全な震源データを持つ EEW を推定震度計算から除外する」という挙動そのものを
検証する単体テストが存在しない。`EstimatedIntensity` notifier の既存テストは
正常系のデータのみを対象としており、magnitude/depth が欠落した `EewTelegramItem` を
入力した場合に例外を投げず、かつその地震だけが除外されることを確認するテストケースを
追加することが望ましい。
