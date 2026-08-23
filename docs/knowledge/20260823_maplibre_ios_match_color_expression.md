# MapLibre iOS: match式の色出力は型付きで変換する

## 事象

市区町村別最大震度の塗り分けで、iOSだけ全市区町村が白く表示された。
Dart側の式は `match` の出力に `rgba` を使っており、Androidでは正しく描画された。

## 原因

レイヤーの Initialize / Update / Dispose の競合や Pigeon の転送ではなく、
flutter-maplibre iOS側でJSON式を `NSExpression(mglJSONObject:)` へ汎用変換した際、
`match` の色出力が色型として保持されなかったことが原因だった。

## 対処

`YumNumm/flutter-maplibre` のiOS実装で、色プロパティの `match` 式を
`NSExpression(forMGLMatching:in:defaultValue:)` により型付きで構築する。
EQMonitorではMapLibreの6パッケージを同じ修正コミットへ固定する。

## 検証

依存更新後は次を確認する。

```sh
mise exec -- flutter pub get
mise exec -- flutter analyze
mise exec -- flutter test app/test/feature/intensity_history/intensity_fill_expression_test.dart
```

式構造のDartテストだけではiOSネイティブ変換の型問題を検出できないため、
市区町村別最大震度をiOS Simulatorでも表示し、震度別の色を目視確認する。
