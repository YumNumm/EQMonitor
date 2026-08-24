# Android releaseでMapLibreのPlatformViewを保持する

## 症状

Androidのdebugビルドでは地図が表示される一方、R8を有効にしたreleaseビルドでは地図領域が真っ白になることがある。

`adb logcat`には次の例外が出る。

```text
MethodChannel#flutter/platform_views: java.lang.NullPointerException:
Attempt to invoke interface method 'android.view.View PlatformView.getView()'
on a null object reference
```

この例外はPMTilesを読み込む前のPlatformView生成時に発生する。AAB内のPMTiles有無や`pmtiles://file:///...`のURIとは別問題として切り分ける。

## 原因

`maplibre_android`はDart JNIの生成コードから、次のFlutterクラスを元の完全修飾名で参照する。

- `io.flutter.plugin.platform.PlatformView`
- `io.flutter.plugin.platform.PlatformViewFactory`

consumer ProGuardルールからFlutter PlatformViewのkeep指定がなくなると、R8がこれらを難読化する。Dart JNI側のクラス参照と一致しなくなり、`MapLibreMapFactory.create()`からFlutterへ返すPlatformViewが`null`になる。

## 必須ルール

`packages/maplibre_android/android/consumer-rules.pro`で次のルールを維持する。

```proguard
-keep class io.flutter.plugin.platform.** { public *; }
```

MapLibreやGson用のkeepルールを整理するときも、この行を削除しない。

## 検証方法

debugビルドだけではR8の問題を検出できない。Android releaseをビルドし、mappingでクラス名が保持されていることを確認する。

```bash
mise exec -- flutter build apk --release
rg '^io\.flutter\.plugin\.platform\.(PlatformView|PlatformViewFactory|PlatformViewsController) ->' \
  build/app/outputs/mapping/release/mapping.txt
```

正常な出力では、矢印の右側も元の完全修飾名になる。

```text
io.flutter.plugin.platform.PlatformView -> io.flutter.plugin.platform.PlatformView:
io.flutter.plugin.platform.PlatformViewFactory -> io.flutter.plugin.platform.PlatformViewFactory:
```

CDではAsset Packのstaging確認に加え、release成果物を起動してMapLibreのPlatformView生成を確認するsmoke testが必要になる。AAB内のPMTiles確認だけでは、この種のR8回帰は検出できない。
