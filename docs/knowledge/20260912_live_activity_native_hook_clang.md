# Live Activity native hook の Clang ヘッダー解決

- Xcode 27 beta 4でRunnerをビルドした際、`live_activity_util` のffigenが `CoreFoundation.h: fatal error: 'stdarg.h' file not found` を出した。
- Objective-C parserはこのエラーを無視して生成を続行するため、`BUILD SUCCEEDED` だけでは生成物の健全性を確認できない。
- `-isysroot` はiOS SDKを指定するが、Clang自身のbuiltin headersの場所は指定しない。native hookでは、選択中のXcodeの `xcrun clang -print-resource-dir` を取得し、ffigenの `Headers.compilerOptions` に `-resource-dir` として渡す。
- 取得失敗・空パス・`include/stdarg.h` 不在は、コード生成より前に明示的に失敗させる。Xcodeのバージョンや絶対パスをハードコードしない。
- 同じSwift生成headerとffigen設定で、resource-dirなしは上記エラーを再現し、指定ありではheader診断が消えた。生成したDart/Objective-Cは手修正しない。

確認:

```sh
xcrun --sdk iphoneos --show-sdk-path
xcrun clang -print-resource-dir
# appから通常のnative hookを通す
mise exec -- flutter build ios --simulator --debug --no-codesign
```

- ログの `SEVERE` / `fatal error` / `Ignored source errors` を確認する。iOS SDK由来の無関係なAPIが生成差分に出る場合も、必要な `EQMLiveActivityUtil` のAPIと型が欠落していないことを確認する。
