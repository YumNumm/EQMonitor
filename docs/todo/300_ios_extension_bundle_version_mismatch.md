# iOS App Extension の CFBundleVersion が親アプリと不一致

## 症状

`xcodebuild archive` の `ValidateEmbeddedBinary` で warning が出る。

```text
warning: The CFBundleVersion of an app extension ('1') must match that of
its containing parent app ('1287').
```

## 原因

`app/ios/Runner.xcodeproj/project.pbxproj` で、Runner だけ
`CURRENT_PROJECT_VERSION = 1287` になっている一方、
`AppIntentExtension` / `Widget` / `FcmServiceExtension`
はすべて `CURRENT_PROJECT_VERSION = 1` のまま。

## 対応案

各 extension の `CURRENT_PROJECT_VERSION` / `MARKETING_VERSION` を
Runner と同じ `FLUTTER_BUILD_NUMBER` / `FLUTTER_BUILD_NAME` 由来の値へ
揃える（`Flutter/Generated.xcconfig` の変数を参照させる）。

現状はビルドを止めない warning だが、App Store Connect のバリデーションが
将来厳格化した場合に提出が弾かれる可能性がある。
