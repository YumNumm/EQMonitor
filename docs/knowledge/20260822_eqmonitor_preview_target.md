# Widget / Live Activity の Xcode Previews を高速に回す（EQMonitorPreview）

## なぜ WidgetExtension スキームだと遅いのか

`Runner.xcodeproj/xcshareddata/xcschemes/WidgetExtension.xcscheme` の BuildAction には
`WidgetExtension.appex` と **`Runner.app`** の 2 つが入っており、LaunchAction の runnable も
`Runner.app` になっている。appex は単体で起動できずホストアプリのインストールが必要なため、
Widget / Live Activity のプレビューを開くと Flutter アプリ本体（Runner）のビルドが毎回走る。

そこで、ホストを 2 ファイルだけの軽量アプリに差し替えた専用ターゲットを用意している。

| ターゲット | 役割 |
| --- | --- |
| `EQMonitorPreview`（app） | プレビュー用のホスト。`EQMonitorPreviewApp` と `ContentView` だけ |
| `EQMonitorPreviewWidget`（app-extension） | `Widget/` と `Shared/` を相乗りさせた widget extension |

`EQMonitorPreview` スキームを選んで `Widget/LiveActivity/**` のキャンバスを開くと、
この 2 ターゲットだけがビルドされる。1 ファイル変更時の再ビルドは `SwiftCompile` 2 タスク・
実測 5 秒程度。

## プレビューをアプリターゲットに相乗りさせてはいけない

`attributes.previewContext(state, viewKind:)` や `#Preview(as: .systemSmall)` は WidgetKit が
Live Activity / ウィジェットの枠を描画する API で、**widget extension のプロセスでしか動かない**。
アプリターゲットに Widget のソースを追加してプレビューを開くと、WidgetKit 内部で trap して
`EXC_BREAKPOINT` でクラッシュする（クラッシュログの最上位フレームが WidgetKit になる）。

Apple の Developer Forums でもフレームワークエンジニアが
「widget プロセスは制約が多く、widget コンテキストを持たない任意の SwiftUI View のプレビューは
サポートしていない。共通 View は別フレームワークに切り出してそこでプレビューせよ」と回答している。
<https://developer.apple.com/forums/thread/758477>

逆向きの制約もある。`ShakeDetectionLiveActivityView` の `#Preview` のように素の View を
そのまま渡すプレビューは widget extension では「missing previewContext」になりやすい。
Live Activity の枠込みで見たいなら `previewContext(_:viewKind:)`、
素の View として見たいなら別ターゲット、と使い分ける。

## 報の進行を State 切り替えで確認する

`previewContext(_:viewKind:)` は 1 プレビュー 1 状態しか持てない。EEW は同じ Activity を
報ごとに更新し続けるため、更新時の破綻（震度バッジの桁増え・警報への切り替わり・
カウントダウンから「到達済み」への変化）を見るには複数の ContentState を 1 プレビューに渡す。

`#Preview(as:using:widget:contentStates:)`（iOS 17+）の `contentStates` は
`PreviewActivityBuilder` の result builder で、`buildArray` があるので `for` ループを書ける。
系列は `EewContentState.warningSequence()` / `canceledSequence()` として
`EewLiveActivityAttributes.swift` に持たせている。

```swift
#Preview("EEW 報の進行 - Lock Screen", as: .content, using: eewPreviewAttributes) {
    EewLiveActivityWidget()
} contentStates: {
    for state in EewContentState.warningSequence() {
        state
    }
}
```

主要動到達の予想時刻は `Date()` からの相対で組み立てる。固定日時にすると常に
「到達済み」になり、残り時間の表示を確認できない。

## Xcode 16 以降の同期グループ（objectVersion 70）でのファイル所属

`Widget/` は `PBXFileSystemSynchronizedRootGroup` なので、所属は
`PBXFileSystemSynchronizedBuildFileExceptionSet` の `membershipExceptions` で決まる。
挙動が所有ターゲットかどうかで反転するので注意する。

- グループを `fileSystemSynchronizedGroups` に持つターゲット（`WidgetExtension`）
  → `membershipExceptions` のファイルは**ビルドから除外**される（例: `Info.plist`）
- グループを持たないターゲット（`EQMonitorPreviewWidget`）
  → `membershipExceptions` のファイルが**ビルドに追加**される

`Widget/` に新しいファイルを足したら、`EQMonitorPreviewWidget` 側の exception set にも
追記しないとプレビュー用ターゲットでは未定義エラーになる。

## EQMonitorPreviewWidget に必要なもの

`Shared/` は通常の `PBXGroup`（同期グループではない）なので、ファイルを置いても自動では
所属しない。`Sources` ビルドフェーズへ `PBXBuildFile` を明示的に足す必要がある。
忘れると `cannot find type 'EewDisplay' in scope` のような未定義エラーが大量に出る。

- `Shared/*.swift` を全て `Sources` に追加（`WidgetExtension` と同じ 14 ファイル）
- `EQMonitorAPI`（`Packages/EQMonitorAPI` のローカルパッケージ）を `Frameworks` にリンク
  - `IntensityValue` / `TelegramStatus` / `EarthquakeDisplayItem` が `import EQMonitorAPI` している
- フォント 2 つと `jma_code_table.json` を `Resources` に追加
  - `AppFonts` は `Bundle.main` からフォントを実行時登録するため、同梱しないとプレビューの
    書体がシステムフォントにフォールバックして実機と見た目が変わる
- `Widget/Assets.xcassets` は exception set に `Assets.xcassets` を書いて取り込む
  （`Image("AppIconForeground")` の解決に必要）
- 除外するもの
  - `Widget/WidgetBundle.swift`: `@main` が `EQMonitorPreviewWidgetBundle` と衝突する
  - `Widget/Controls/*.swift`: `AppIntentExtension/` の Intent 型を参照しており、
    ControlWidget は Previews で描画できないので取り込まない

## バンドル ID とビルド設定

- appex のバンドル ID はホストアプリの ID を prefix にする必要がある。
  `net.yumnumm.EQMonitorPreview` / `net.yumnumm.EQMonitorPreview.Widget` にしている。
  ここを外すとシミュレータへのインストールが失敗し、プレビューが起動できない。
- ビルド設定は `WidgetExtension` に合わせる。特に
  `IPHONEOS_DEPLOYMENT_TARGET = 17.6` と `SWIFT_DEFAULT_ACTOR_ISOLATION` 未設定。
  食い違うと「プレビューでは通るが WidgetExtension でコンパイルエラー」になる。
- 実機用の entitlements（App Group）は付けていない。静的なプレビューでは App Group を
  読まないため。`ConfigReader` も Info.plist / ハードコードにフォールバックする。

## 動作確認

```shell
cd app/ios
xcodebuild -project Runner.xcodeproj -scheme EQMonitorPreview \
  -destination 'generic/platform=iOS Simulator' -configuration Debug build
```

appex が正しく埋め込まれたかは、生成物の構成とインストール可否で確認する。

```shell
APP=~/Library/Developer/Xcode/DerivedData/Runner-*/Build/Products/Debug-iphonesimulator/EQMonitorPreview.app
ls "$APP"/PlugIns/EQMonitorPreviewWidget.appex
xcrun simctl install <udid> "$APP"
```

## 注意

`xcodebuild` を直接叩くと副作用が出ることがある。

- パッケージ解決が走り、`Package.resolved` のリモート依存（MapLibre / RevenueCat 等）が
  最新版に更新される
- `-project` 指定でビルドすると `Runner.xcworkspace` 側の `Package.resolved` が消えることがある

いずれも意図しない差分なので、コミット前に `git --no-pager status` で確認する。
