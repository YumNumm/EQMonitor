# pending位置の原子的な永続化

位置pendingは、位置とconsumer別ack状態を分割キーではなく単一recordとして保存する。
新recordの永続化成功後だけ旧キーを削除し、不完全な旧recordは緯度・経度を含む全キーを削除する。

## Android

`SharedPreferences.Editor.commit()`が`false`でも、process内mapは変更後の値になり得る。
save/ack前のserialized recordを保持し、失敗時は`apply()`でprocess内stateを直前のrecordへ戻す。
同期commitは成功判定に必要なため、`ApplySharedPref`の抑制理由をコード上で明示する。

```shell
cd app/android
mise exec -- /path/to/gradle-9.3.1/bin/gradle \
  :background_location_tracker:testDebugUnitTest --rerun-tasks --console=plain
```

## iOS

`UserDefaults`の複数キーread-backはdurable writeの証明にならない。
binary plistの単一recordをatomic replaceし、fileと親directoryを同期する。
storeにはDI可能なstorage protocolを置き、write/remove失敗時に旧recordがpeekできることをtestする。

```shell
cd app/ios
xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests \
  -destination 'platform=iOS Simulator,id=<SIMULATOR_ID>' \
  -only-testing:WidgetModelsTests/BackgroundLocationPendingLocationStoreTests
```
