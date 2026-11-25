# kyoshin_waveform

防災科学技術研究所の K-NET・KiK-net の強震記録を、観測点ごとの加速度波形として扱う純 Dart パッケージ。
K-NET ASCII 形式の読み込みと、チャンネルを観測点ごとの記録にまとめる処理を持つ。

形式の仕様は防災科研の [K-NET ASCIIフォーマットについて](https://www.kyoshin.bosai.go.jp/ja/knetascii/) による。

## 使い方

```dart
final channels = [for (final text in files) const KnetAsciiParser().parse(text)];
final records = const KyoshinWaveformRecordAssembler().assemble(channels);
final surface = records.first.threeComponents(.surface);
```

## 形式の扱い

- ヘッダは17行で、各行の19文字目以降を値とする。18行目以降は符号付き整数の生データ。
- ヘッダの時刻は JST。`KnetAsciiParser` は UTC に直して返す。
- `Record Time` はトリガーの時刻で、公開データはその15秒前から始まる。`KnetAsciiChannel.startTime` は `Record Time` の15秒前。
- 加速度（gal）は、生データから記録全長の平均値（オフセット）を引き、スケールファクタを掛けた値。
  防災科研がヘッダの最大加速度を求める方法と同じで、テストで実記録の最大加速度と一致することを確かめている。
- `Dir.` は K-NET が `N-S`・`E-W`・`U-D`、KiK-net が `1`〜`6`。KiK-net の 1〜3 は地中（NS1・EW1・UD1）、4〜6 は地表（NS2・EW2・UD2）。
- 1つの観測点の記録は、観測点コードと `Record Time` が同じチャンネルをまとめたもの。チャンネル間でサンプリング周波数が異なる場合は `FormatException` にする。

## テスト用のデータ

`test/fixtures/EHM0012408081643.*` は、防災科研の K-NET で公開されている 2024-08-08 16:43 の地震の EHM001 の記録。
