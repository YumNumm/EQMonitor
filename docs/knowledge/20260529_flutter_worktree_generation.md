# Flutter worktree での生成・検証時の注意

## 背景

分離 worktree で Flutter / Dart の生成やテストを実行する場合、通常 checkout 側にある生成ディレクトリが存在せず、Flutter の plugin copy が失敗することがある。

## 手順

`melos run generate` は現状 `generate:dart` / `generate:flutter` を参照するが、該当 script が定義されていない。アプリ側の Riverpod / Freezed 生成だけが必要な場合は、`app/` で build_runner を直接実行する。

```bash
mise exec -- dart run build_runner build -d
```

worktree で `flutter pub get` や `flutter test` が plugin copy の `rsync` で失敗する場合は、生成物ディレクトリの親を作ってから再実行する。

```bash
mkdir -p build/ios/SourcePackages build/macos/SourcePackages
mise exec -- flutter test test/feature/subscription/data/notifier/subscription_notifier_test.dart
```

リポジトリルートから実行する場合と `app/` から実行する場合で `build/` の位置が変わるため、実行ディレクトリに合わせて作成する。
