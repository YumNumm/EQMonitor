# MapLibre Android / jnigen の ProGuard 設定

## 症状

Android の release ビルドで、MapLibre のクラスに対する
`ClassNotFoundException` が実行時に発生することがある。

例:

```text
java.lang.ClassNotFoundException: Didn't find class
"org/maplibre/android/style/expressions/Expression$Converter"
```

## 原因

`maplibre_android` は jnigen から Java クラスを文字列で解決する。
R8 は Dart/JNI 側の参照を Android バイトコードの到達可能性解析で検出できず、
release の minify 時に必要なクラスを削除する場合がある。

MapLibre のパッケージを個別に keep すると、jnigen の生成対象が増えた際に
再び漏れる可能性がある。EQMonitor では次の規則で MapLibre Android SDK 全体を保持する。

```proguard
-keep class org.maplibre.android.** { *; }
```

release 全体の minify と resource shrinking は無効化しない。

## 検証

Flutter / Dart コマンドは `mise exec --` 経由で実行する。

```bash
cd app
mise exec -- flutter build apk \
  --release \
  --dart-define-from-file=../environment/.env.prod
cd ..
tool/verify_maplibre_android_classes.sh \
  app/build/app/outputs/flutter-apk/app-release.apk
```

検証スクリプトが対象クラスを検出して終了コード `0` を返すことを確認する。
