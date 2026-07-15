# MapLibre Android ProGuard 保護設計

## 背景

Android の release ビルドで R8 が有効な場合、MapLibre の
`org.maplibre.android.style.expressions.Expression$Converter` が APK から削除され、
jnigen が実行時にクラスを解決できず `ClassNotFoundException` が発生する。

MapLibre Android の consumer rules はパッケージを個別列挙しているが、
`org.maplibre.android.style.expressions` が含まれていない。一方、jnigen の生成コードは
Java クラス名を文字列で参照するため、R8 は Dart 側からの利用を静的に検出できない。

## 方針

アプリの ProGuard rules で MapLibre Android SDK 全体を保持する。

```proguard
-keep class org.maplibre.android.** { *; }
```

MapLibre のパッケージを個別に列挙せず、今後 jnigen の対象クラスが増えた場合も
同種の削除を防止する。release ビルド全体の minify と resource shrinking は維持する。

## 変更範囲

- Android アプリ用の ProGuard rules ファイルを追加する。
- release build type から当該 rules を明示的に読み込む。
- release APK に `Expression$Converter` が残ることを検証する。
- 修正前後の APK サイズを比較し、PR に記録する。
- Android release と jnigen の注意点を `docs/knowledge/` に記録する。

MapLibre fork の参照 commit、Dart のマップ実装、minify の有効・無効は変更しない。

## 検証

1. 修正前の release APK では対象クラスが存在しないことを再現する。
2. 修正後に同じ条件で release APK を作成する。
3. APK の DEX を解析し、対象クラスが存在することを確認する。
4. Android Gradle 設定のテストと Flutter の静的解析を実行する。
5. 修正前後の APK サイズ差を確認する。

実機で release APK を起動できる場合は、MapLibre を使用する画面を開き、
同じ `ClassNotFoundException` が発生しないことも確認する。

## リスク

MapLibre Android SDK の難読化・削除が抑止されるため、APK サイズは増加する可能性がある。
ただし、MapLibre 以外の依存関係には R8 が引き続き適用される。実行時 JNI 解決の確実性を
優先し、サイズ増加量はビルド成果物で定量確認する。
