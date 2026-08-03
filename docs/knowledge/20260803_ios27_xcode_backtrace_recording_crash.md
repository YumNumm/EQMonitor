# iOS 27実機 + Xcode起動でのbacktrace recordingクラッシュ

iOS 27の実機へXcodeからdebug起動すると、起動直後に次のabortで落ちる（またはsplashで
固まる）。

```text
-- LLDB integration loaded --
objc[1976]: -[OS_dispatch_mach_msg _setContext:]: unrecognized selector sent to instance 0x105abacb0 (no message forward handler is installed)
-[OS_dispatch_mach_msg _setContext:]: unrecognized selector sent to instance 0x105abacb0 (no message forward handler is installed)
```

## 原因

Xcodeの Queue Debugging（Enable backtrace recording）が、GCDのenqueue元callstackを
記録するためにlibdispatchへ instrumentation を差し込む。iOS 27で dispatch object の
内部が変わり、`OS_dispatch_mach_msg` が応答しない `_setContext:` を送るため
`unrecognized selector` でabortする。

アプリのコードとは無関係で、Xcodeが `DYLD_INSERT_LIBRARIES` で仕込むlaunch時の機能。
そのため次の切り分けが成立する。

- Xcodeから起動 → クラッシュする
- ホーム画面からアプリを直接タップ → 正常に動く
- iOS 26.x以前の実機 → 同じXcodeでも再現しない

`flutter run` はこのlibraryを注入しないため、`flutter run` 経由では発生しない。
Xcodeから起動したときだけ疑う。

## 対処

scheme の LaunchAction に `queueDebuggingEnableBacktraceRecording = "NO"` を入れる。
GUIでは Product > Scheme > Edit Scheme > Run > Options > Queue Debugging の
Enable backtrace recording を外す操作に対応する。

```xml
<LaunchAction
   buildConfiguration = "Debug"
   ...
   enableGPUValidationMode = "1"
   queueDebuggingEnableBacktraceRecording = "NO"
   allowLocationSimulation = "YES">
```

適用済み: `packages/eqmonitor_map/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme`

Xcodeを開いたまま編集すると上書きされることがあるため、Xcodeを閉じてから編集するか、
編集後にschemeを開いてチェックが外れていることを確認する。

`app/ios` 側のschemeは未適用。iOS 27実機でXcodeからdebug起動して同じabortが出たら
同じ属性を追加する。

## 再有効化

iOS 27側で修正されたら戻してよい。恒久的な設定変更ではなく、iOS 27に対する暫定回避
であることをscheme変更時に共有する。
