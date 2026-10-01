# 通知音のネイティブテスト

Runner と同じ `NotificationSoundImporter` / `NotificationSoundStore` を iOS Simulator 上で実行する。
Runner は Xcode project のファイル参照から、このパッケージ内の実装を直接コンパイルする。
音声デコード・変換・WAV 出力は AVFoundation、保存は一時ディレクトリ内の実ファイルを使う。

Mac では、このディレクトリで実行する。端末名は `xcrun simctl list devices available` に合わせる。

```sh
xcodebuild test -scheme NotificationSounds \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  CODE_SIGNING_ALLOWED=NO
```

PR の `iOS Notification Sound Tests` は利用可能な iPhone Simulator を選び、結果を artifact に保存する。

- WAV はテスト中に PCM16 の RIFF ヘッダーを組み立て、初回の短い読み込み、4096フレームの境界、48 kHz ステレオ、29.9秒への切り詰めを検証する。
- `Fixtures/tone-48000-stereo.mp3` は自作の440 Hz正弦波。48 kHz、ステレオ、PCM16、12000フレームを LAME 3.101 beta 3 で128 kbpsに符号化した。元音声は0.25秒で、MP3にはエンコーダの遅延・パディングが含まれる。
- 出力を再オープンして形式・長さ・音声サンプルを確認する。元ファイルが空音声として保存される場合も失敗する。
- 不正な入力は拒否され、元の OS エラーと失敗箇所が保持されることを確認する。

実機の Files picker、App Group entitlement、通知配信による音声再生は別途確認が必要。
