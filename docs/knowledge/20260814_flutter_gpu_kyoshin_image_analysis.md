# Flutter GPUによる強震モニタ画像解析の適用条件

## 結論

- Flutter GPUで観測点ごとの色変換を実行すること自体は可能。
- ただしFlutter 3.44安定版では、現行の強震モニタ解析を高速化できる可能性は低い。
- Flutter 3.47以降の`Texture.fromImage`を使うPoCは検討可能だが、Flutter GPUはearly previewであり、本番の唯一の解析経路にはしない。
- 本番採用は、CPU実装との全件一致、実機レイテンシ、UI/raster負荷、消費電力を確認してから判断する。

## 現行ワークロード

- 入力は352x400のGIFで、2026-08-14に取得した実例は6,978 bytesだった。
- 現在の観測点パラメータは1,749点で、全140,800ピクセルではなく指定座標だけを解析する。
- 常駐Worker Isolateで`package:image`のGIFデコード、RGBからHSVへの変換、多項式によるscale算出、GeoJSON生成を直列実行する。
- GPU化してもGIFデコードとGeoJSON生成はCPU側に残る。特にGPU結果はGeoJSON生成のためCPUへ戻す必要がある。

## Flutter 3.44での制約

- Flutter GPUはImpellerを必須とし、API安定性を保証しないearly previewである。
- 公開APIには`RenderPass`があるが、汎用の`ComputePass`はない。解析は1,749x1などの出力Textureへpoint描画するfragment shaderとして模擬する必要がある。
- `DeviceBuffer`はCPUからの`overwrite`と`flush`を提供するが、Dartから内容を読むAPIを持たない。
- 結果のreadbackは`Texture.asImage()`から`ui.Image.toByteData()`を呼ぶ経路になる。
- 3.44の`Texture`には`ui.Image`をゼロコピーで包むAPIがない。GIFを`ui.Codec`でデコードしても、一度RGBAへreadbackしてから`Texture.overwrite`で再アップロードする必要がある。
- `Texture.fromImage`は3.44以後に追加されたため、利用する場合はFlutterの最低バージョン更新が必要になる。

## プラットフォーム条件

- iOSはImpellerのみを使用し、EQMonitorのInfo.plistでは`FLTEnableFlutterGPU=true`が設定済み。
- AndroidはAPI 29以降でImpellerが既定だが、端末やVulkan対応状況によってOpenGLへフォールバックする。EQMonitorのAndroidManifestにはFlutter GPUの有効化設定がない。
- WebはImpellerを使用しないためFlutter GPU経路を利用できない。
- macOSでImpellerが既定になるのはFlutter 3.47以降。
- background isolateでは`dart:ui`メソッドを利用できないため、現在のWorker IsolateをそのままFlutter GPU実装へ置換できない。

## PoCを行う場合の形

1. Flutter 3.47以降で`ui.Codec`から得たGPU-backed `ui.Image`を`Texture.fromImage`で包む。
2. 観測点座標を再利用可能なvertex bufferとして一度だけ作る。
3. point描画で入力Textureをnearest samplingし、RGB、成功/失敗、scaleを小さな出力Textureへ格納する。
4. 出力Textureだけを`toByteData()`でreadbackし、GeoJSONはCPU側で生成する。
5. Flutter GPU初期化失敗時に黙って固定値へフォールバックせず、検証段階では明示的にCPU基準経路を選択する。

## 採用判定

- 先に既存の`parseMicros`、`geoJsonBuildMicros`、画像取得時間、MapLibre source更新時間をprofile buildの実機で収集する。
- CPU候補として、RGBごとのHSV/多項式結果キャッシュと、Flutter engineの`ui.Codec`利用を個別に比較する。
- GPU候補はiOS、Android Vulkan、Android OpenGLの実機でP50/P95/P99を計測する。
- CPUのdouble計算とshaderのfloat計算は境界値がずれる可能性がある。実際の全GIF palette色に加え、RGB境界値を網羅して結果を比較する。
- 解析単体だけでなく、GPUを使う地図描画との競合、raster時間、端末温度、バッテリー消費も評価する。
- CPU経路より十分速く、かつ完全一致と安定性を満たした場合のみ段階的な有効化を検討する。

## 確認コマンド

```sh
mise exec -- flutter --version
mise exec -- flutter run --profile
```

## 参考資料

- https://github.com/flutter/flutter/blob/main/docs/engine/impeller/Flutter-GPU.md
- https://api.flutter.dev/flutter/flutter_gpu/
- https://docs.flutter.dev/perf/impeller
- https://docs.flutter.dev/perf/isolates
- https://api.flutter.dev/flutter/dart-ui/instantiateImageCodec.html
- https://api.flutter.dev/flutter/dart-ui/Image/toByteData.html
