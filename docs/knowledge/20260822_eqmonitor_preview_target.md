# EQMonitorPreview ターゲットで Widget / Live Activity の Xcode Previews を高速に回す

`app/ios/Runner.xcodeproj` の `EQMonitorPreview` は、Widget / Live Activity の SwiftUI Previews
専用のホストアプリターゲット。`WidgetExtension` の Previews は Runner（Flutter アプリ本体）の
ビルドを伴うため遅い。プレビュー専用の軽量アプリターゲットを別に用意して、そこに Widget の
ソースを相乗りさせることで、プレビューの再ビルドを数秒に抑える。

## Xcode 16 以降の同期グループ（objectVersion 70）でのファイル所属

`Widget/` は `PBXFileSystemSynchronizedRootGroup` なので、Xcode 上のチェックボックスではなく
`PBXFileSystemSynchronizedBuildFileExceptionSet` の `membershipExceptions` で所属が決まる。
挙動が所有ターゲットかどうかで反転するので注意する。

- グループを `fileSystemSynchronizedGroups` に持つターゲット（`WidgetExtension`）
  → `membershipExceptions` に書かれたファイルは**ビルドから除外**される（例: `Info.plist`）
- グループを持たないターゲット（`EQMonitorPreview`）
  → `membershipExceptions` に書かれたファイルが**ビルドに追加**される

つまり `EQMonitorPreview` 用の exception set からファイル名を消すと、そのファイルは
プレビューターゲットでコンパイルされなくなる。

## 相乗りさせるときの必須作業

`Shared/` は通常の `PBXGroup`（同期グループではない）なので、ファイルを追加しても自動では
所属しない。`Sources` ビルドフェーズへ `PBXBuildFile` を明示的に足す必要がある。
これを忘れると `cannot find type 'EewDisplay' in scope` のような未定義エラーが大量に出る。

`EQMonitorPreview` に必要なもの:

- `Shared/*.swift` を全て `Sources` に追加（`WidgetExtension` と同じ 14 ファイル）
- `EQMonitorAPI`（`Packages/EQMonitorAPI` のローカルパッケージ）を `Frameworks` にリンク
  - `IntensityValue` / `TelegramStatus` / `EarthquakeDisplayItem` が `import EQMonitorAPI` している
- フォント 2 つと `jma_code_table.json` を `Resources` に追加
  - `AppFonts` は `Bundle.main` からフォントを実行時登録するため、同梱しないとプレビューの
    書体がシステムフォントにフォールバックして実機と見た目が変わる
- `Widget/Assets.xcassets` は取り込まず、必要な imageset だけ
  `EQMonitorPreview/Assets.xcassets` に複製する（`AppIconForeground` など）
  - 両方の catalog に `AccentColor` があるため、丸ごと追加すると名前衝突でビルドが失敗する

## 除外しなければならないファイル

- `Widget/WidgetBundle.swift`: `@main` が `EQMonitorPreviewApp` と衝突する
- `Widget/Controls/*.swift`: `AppIntentExtension/` の Intent 型（`EarthquakeSnippetIntent` 等）を
  参照している。ControlWidget は Xcode Previews で描画できないので、
  `AppIntentExtension` を丸ごと相乗りさせるより除外する方が速い

## ビルド設定は WidgetExtension に合わせる

Xcode がターゲットを新規作成した時点の既定値のままにすると、実際の Widget と診断結果が
食い違い「プレビューでは通るが WidgetExtension でコンパイルエラー」になる。

- `IPHONEOS_DEPLOYMENT_TARGET` は `WidgetExtension` と同じ `17.6`
- `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` は設定しない（`WidgetExtension` は未指定）

また、プレビュー用途では `WidgetExtension` への `PBXTargetDependency` と
`Embed Foundation Extensions` フェーズを持たせない。appex のビルドと埋め込みが毎回走って遅くなる。

## 動作確認

```shell
cd app/ios
xcodebuild -project Runner.xcodeproj -scheme EQMonitorPreview \
  -destination 'generic/platform=iOS Simulator' -configuration Debug build
```

1 ファイル変更時の再ビルドは Swift のコンパイルタスクが 2 個程度で数秒に収まる。
`-showBuildTimingSummary` を付けて `SwiftCompile` のタスク数を見ると、
不要なファイルを取り込んでいないか確認できる。

## 注意

`xcodebuild` を直接叩くとパッケージ解決が走り、`Package.resolved` のリモート依存
（MapLibre / RevenueCat 等）が最新版に更新されてしまうことがある。
差分を確認し、意図しないバージョン更新はコミットに含めない。
