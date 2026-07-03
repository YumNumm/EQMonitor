# App Intents 対応 Phase 1（SnippetIntent 地震情報カード）実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.
>
> **Tracking Issue:** https://github.com/YumNumm/EQMonitor/issues/1418

**Goal:** Siri・Spotlight・ショートカットから、アプリを開かずに「最新の地震情報」「現在地の地震」をカードUI（Interactive Snippet）で確認でき、結果値をオートメーションに渡せるようにする。

**Architecture:** 新規 App Intents Extension（iOS 26.0、ヘッドレス実行）に Intent 群を配置し、既存 Widget 拡張の Models / Services（`EarthquakeDisplayItem`・`EarthquakeAPIService`・`WidgetRegionResolver`）をターゲットメンバーシップで共有する。UI は新設の `DesignTokens`（アプリの ColorThemeExtension と同値の色・GoogleSans フォント）で実装し、表記ロジックは Flutter 実装を正として修正する。

**Tech Stack:** Swift / AppIntents (SnippetIntent, AppEntity, AppEnum) / SwiftUI / swift-openapi-generator 生成クライアント（EQMonitorAPI）/ Swift Testing / xcodeproj ruby gem（ターゲット追加）

## Global Constraints

- 新規ターゲット `AppIntentsExtension` の deployment target は **iOS 26.0**（Widget 拡張と同じ）。Runner は 16.0 のまま変更しない。
- App Group は `group.net.yumnumm.eqmonitor`。キー名は `isPro` / `currentLocationRegionCode` / `currentLocationRegionName` 等、`WidgetRegionResolver.Key` の定義を厳守（Flutter 側と共有）。
- 表示表記は **Flutter アプリ実装を正** とする: 「M8超」／「yyyy/MM/dd HH:mm頃発生」（arrival フォールバック時「頃検知」）／深さ不明はリスト表示で非表示／震源名なしは「最大震度◯を観測」。
- 震度カラーは既存 `IntensityValue` の eqmonitor スキーム（Flutter と一致確認済み）を変更しない。
- API 震度フィルタは `Components.Schemas.JmaIntensity` の生値（`"1","2","3","4","5-","5+","6-","6+","7"`。`0` と未入電 `!5-`/`!6-` は Intent の選択肢に含めない）。
- 地域指定パラメータは **Pro 限定**。非 Pro が指定した場合は黙ってフォールバックせず、明示エラーを返す。
- ビルド前提: `flutter build ios --config-only --debug` 実行済みであること（Generated.xcconfig 生成のため）。
- コミットは develop から切ったフィーチャーブランチ（例: `feat/app-intents-snippet`）に行う。PR は `--repo YumNumm/EQMonitor`、base `develop`。

**ビルド検証コマンド（全タスク共通、以下「共通ビルド」と呼ぶ）:**

```bash
cd app && flutter build ios --config-only --debug && \
xcodebuild -workspace ios/Runner.xcworkspace -scheme Runner -configuration Debug \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO build 2>&1 | tail -5
# 期待: ** BUILD SUCCEEDED **
```

## 実装前提: 既存シンボルの正確な定義（コード検証済み・厳守）

> 本計画の草案は一部シンボル名を誤っていた。以降のタスクのコード例より、**この表の実名を正とする**。タスク内コードに旧名が残っていたら実名へ読み替えること。

**Xcode ターゲット / プロジェクト（`app/ios/Runner.xcodeproj/project.pbxproj`）**
- 既存ターゲットは 3 つ: `Runner`(16.0) / `WidgetExtension`(26.0) / `FcmServiceExtension`(16.0)。**ウィジェットのターゲット名は `WidgetExtension`**（"Widget" ではない。ソースフォルダ名だけが `Widget/`）。**テストターゲットは存在しない**（Task 2 で新規作成する）。
- `WidgetExtension` の `PRODUCT_BUNDLE_IDENTIFIER = "net.yumnumm.eqmonitor${APP_ID_SUFFIX}.Widget"`、`IPHONEOS_DEPLOYMENT_TARGET = 26.0`。
- ローカル SPM 参照は `XCLocalSwiftPackageReference "Packages/EQMonitorAPI"`（`app/ios/Packages/EQMonitorAPI/`）。プロダクト名 `EQMonitorAPI`。WidgetExtension には既にリンク済み。

**`EarthquakeDisplayItem`（`app/ios/Widget/Models/EarthquakeDisplayItem.swift`）** — `struct ...: Identifiable, Equatable`
- プロパティ: `id: String`（**`eventId` ではない**。値は `partial.event_id`）／`hypocenterName: String`／`magnitude: String`（表示文字列）／`magnitudeValue: Double?`／`maxIntensity: IntensityValue?`／`depth: String`／`originTime: Date`／`formattedTime: String`（**`dateText` ではない**）／`latitude`/`longitude: Double?`／`status: TelegramStatus`。
- **`title` プロパティは無い**（震源名は `hypocenterName`、リストのカードタイトルは項目3 `ResolvedWidgetRegion.title` の責務）。
- フォーマットは全て **`private static func`**（internal 化して単体テストするのが Task 2）:
  - `formatTime(_ date: Date) -> String`: `"MM/dd HH:mm"` + `ja_JP` + `Asia/Tokyo`、末尾に `"頃"` 連結。
  - `formatMagnitude(_ magnitude: Components.Schemas.Magnitude?) -> String`: `.NORMAL`→`"M%.1f"`／`.UNKNOWN`→`"M不明"`／`.OVER_M8`→**現状 `"M8以上"`**（Task 2 で `"M8超"` に変更）。
  - `formatDepth(_ depth: Components.Schemas.Depth?) -> String`: `.SHALLOW`→`"ごく浅い"`／`.NORMAL`→`"\(Int(value))km"`／`.OVER_700`→`"700km以上"`／`.UNKNOWN`→**現状 `"不明"`**（Task 2 で空文字に変更）。
- 震源名フォールバックは **init 内**（static ではない）: `detailed?.name ?? name ?? "震源地不明"`。

**`EarthquakeAPIService`（`app/ios/Widget/Services/EarthquakeAPIClient.swift`）** — **クラス名は `EarthquakeAPIService`**（`EarthquakeAPIClient` ではない）。共有は `EarthquakeAPIService.shared`。
- `fetchEarthquakes(limit: Int = 10)` → `client.getV2Earthquake(query: .init(limit:))`
- `fetchEarthquakesByRegion(regionCode: String, limit: Int = 10)` → `getV2EarthquakeIntensityRegionByCode(path:query:)`
- `fetchEarthquakesByPrefecture(prefectureCode: String, limit: Int = 10)`
- `fetchEarthquakesByCity(cityCode: String, limit: Int = 10)`
- 各メソッドは現状 `intensityGte` を渡していないが、**生成クライアントの `Input.Query` は `intensityGte: Components.Schemas.JmaIntensity?` を既に保持**（region/pref/city/nationwide すべて）。→ Task 3 は「Service メソッドに引数を足して Query に渡す」だけでよく、生成コード改変は不要。

**`WidgetRegionResolver`（`app/ios/Widget/Services/WidgetRegionResolver.swift`）** — `enum`（static メソッド集）
- `static func resolve(regionType: RegionType) -> ResolvedWidgetRegion`。`ResolvedWidgetRegion { plan: WidgetFetchPlan; title: String; compactTitle: String }`。
- `WidgetFetchPlan`: `.nationwide` / `.region(code: String)` / `.prefecture(code: String)` / `.city(code: String)`。
- App Group suiteName = `"group.net.yumnumm.eqmonitor"`。キー（`private enum Key` の `static let` 文字列）: `isPro` / `widgetRegionSearchType` / `widgetRegionCode` / `widgetRegionName` / `currentLocationRegionCode` / `currentLocationRegionName`。
- `.region(code:)` は `.currentLocation` 分岐でのみ生成。現在地未設定時は全国フォールバックする（Task 8 でこれを「未取得」として明示エラーにする）。

**`IntensityValue`（`app/ios/Widget/Models/IntensityValue.swift`）** — `enum ...: String, Codable, CaseIterable, Comparable`
- ケース: `.zero`..`.four`, `.fiveLowerNoInput`="!5-", `.fiveLower`="5-", `.fiveUpper`="5+", `.sixLowerNoInput`="!6-", `.sixLower`="6-", `.sixUpper`="6+", `.seven`="7"。
- 表示系: `displayString`（**`label` は無い**。"5弱" 等）／`mainNumber`／`subText`／`formattedParts: (main, sub)`。色: `backgroundColor: Color`／`textColor: Color`／`dangerLevel: Int`。変換: `init?(from jmaIntensity: Components.Schemas.JmaIntensity?)`。

**`IntensityBadge`（`app/ios/Widget/Views/EarthquakeWidgetView.swift` 内, internal）**
- メンバ: `let intensity: (main: String, sub: String?)` / `let backgroundColor: Color` / `let textColor: Color` / `var size: CGFloat = 40`。`cornerRatio` 引数は現状無い（Task 7 で追加する場合はここに足す）。

**`DesignSystem.swift`（`extension Color`）** — 色は全て `dynamic(light:dark:)` の**light/dark 2値ペア**。命名は `eq` プレフィックス:
- `eqBg`=`0xF1F4F8`/`0x0F141A`、`eqSurface`=`0xFFFFFF`/`0x171E26`、`eqCard`=`0xEDF1F6`/`0x232D38`、`eqBrand`=`0x2F6FE0`/`0x4D8DFF`、`eqBrandContainer`/`eqOutlineSoft`/`eqTextPrimary`/`eqTextSecondary`/`eqTextTertiary` ほか。`eqGlass(cornerRadius:tint:)` あり。

**`jma_code_table.json`（`app/assets/parameters/`, 約1.6MB）**
- `{ metadata, code_tables }`。`code_tables.area_information_prefecture_earthquake`（**配列**47件, 各 `{code, name:{ja,...多言語}}`）／`area_information_city`（**配列**4361件, 各 `{code, name:{ja}, parent_area_...}` — city は `name.ja` のみ）。

**フォント実ファイル名（`app/assets/fonts/`）**
- `GoogleSansFlex/GoogleSansFlex[GRAD,ROND,opsz,slnt,wdth,wght].ttf`（1個）
- `GoogleSansCode/GoogleSansCode[MONO,wght].ttf` と `GoogleSansCode-Italic[MONO,wght].ttf`

---

### Task 1: AppIntents Extension ターゲットのスキャフォールド（露出スパイク含む）

**Files:**
- Create: `app/ios/scripts/add_appintents_extension.rb`（一時スクリプト。実行後も履歴用に残してよい）
- Create: `app/ios/AppIntentsExtension/Info.plist`
- Create: `app/ios/AppIntentsExtension/AppIntentsExtension.swift`（エントリポイント + ダミー Intent + AppShortcutsProvider）
- Create: `app/ios/AppIntentsExtension/AppIntentsExtension.entitlements`
- Modify: `app/ios/Runner.xcodeproj/project.pbxproj`（スクリプト経由）

**Interfaces:**
- Produces: ターゲット `AppIntentsExtension`（iOS 26.0・App Group 付き・Runner に埋め込み済み）。以降のタスクはこのターゲットにファイルを追加する。

- [ ] **Step 1: xcodeproj gem の確認・導入**

```bash
gem list xcodeproj | grep xcodeproj || gem install --user-install xcodeproj
```

- [ ] **Step 2: エントリポイントと Info.plist を作成**

`app/ios/AppIntentsExtension/AppIntentsExtension.swift`:

```swift
import AppIntents

@main
struct EQMonitorAppIntentsExtension: AppIntentsExtension {}

// スパイク用ダミー（Task 7 で本実装に置き換えて削除）
struct PingIntent: AppIntent {
    static let title: LocalizedStringResource = "EQMonitor 接続確認"
    func perform() async throws -> some IntentResult & ProvidesDialog {
        .result(dialog: "OK")
    }
}

struct EQMonitorShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: PingIntent(),
            phrases: ["\(.applicationName)で接続確認"],
            shortTitle: "接続確認",
            systemImageName: "waveform.path.ecg"
        )
    }
}
```

`app/ios/AppIntentsExtension/Info.plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>EXAppExtensionAttributes</key>
    <dict>
        <key>EXExtensionPointIdentifier</key>
        <string>com.apple.appintents-extension</string>
    </dict>
</dict>
</plist>
```

`app/ios/AppIntentsExtension/AppIntentsExtension.entitlements`（Widget.entitlements と同内容）:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.application-groups</key>
    <array>
        <string>group.net.yumnumm.eqmonitor</string>
    </array>
</dict>
</plist>
```

- [ ] **Step 3: ターゲット追加スクリプトを書く**

`app/ios/scripts/add_appintents_extension.rb`:

```ruby
require 'xcodeproj'

project = Xcodeproj::Project.open(File.expand_path('../Runner.xcodeproj', __dir__))
runner = project.targets.find { |t| t.name == 'Runner' }
widget = project.targets.find { |t| t.name == 'WidgetExtension' } # 実ターゲット名は WidgetExtension

target = project.new_target(:app_extension, 'AppIntentsExtension', :ios, '26.0')

# Widget ターゲットのビルド設定をベースに合わせる
target.build_configurations.each do |config|
  w = widget.build_configurations.find { |c| c.name == config.name }
  config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] =
    w.build_settings['PRODUCT_BUNDLE_IDENTIFIER'].sub(/\.Widget\z/, '.AppIntentsExtension')
  %w[DEVELOPMENT_TEAM CODE_SIGN_STYLE SWIFT_VERSION TARGETED_DEVICE_FAMILY].each do |key|
    config.build_settings[key] = w.build_settings[key] if w.build_settings[key]
  end
  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '26.0'
  config.build_settings['INFOPLIST_FILE'] = 'AppIntentsExtension/Info.plist'
  config.build_settings['GENERATE_INFOPLIST_FILE'] = 'YES'
  config.build_settings['CODE_SIGN_ENTITLEMENTS'] = 'AppIntentsExtension/AppIntentsExtension.entitlements'
  config.build_settings['SWIFT_EMIT_LOC_STRINGS'] = 'YES'
end

# ソースファイル追加
group = project.main_group.new_group('AppIntentsExtension', 'AppIntentsExtension')
src = group.new_file('AppIntentsExtension.swift')
target.add_file_references([src])

# EQMonitorAPI (ローカルSPM) への依存を Widget と同様に付与
pkg = project.root_object.package_references.find { |r| r.display_name.include?('EQMonitorAPI') }
dep = project.new(Xcodeproj::Project::Object::XCSwiftPackageProductDependency)
dep.product_name = 'EQMonitorAPI'
dep.package = pkg
target.package_product_dependencies << dep

# Runner に埋め込み
runner.add_dependency(target)
embed = runner.copy_files_build_phases.find { |p| p.symbol_dst_subfolder_spec == :plug_ins } ||
        runner.new_copy_files_build_phase('Embed Foundation Extensions').tap { |p| p.symbol_dst_subfolder_spec = :plug_ins }
proxy = embed.add_file_reference(target.product_reference)
proxy.settings = { 'ATTRIBUTES' => ['RemoveHeadersOnCopy'] }

project.save
puts 'done'
```

- [ ] **Step 4: スクリプト実行**

```bash
cd app/ios && ruby scripts/add_appintents_extension.rb
# 期待: done
```

- [ ] **Step 5: 共通ビルドで BUILD SUCCEEDED を確認**

失敗した場合は pbxproj の diff を確認し、Widget ターゲットの設定（`INFOPLIST_KEY_*` 等）との差分を埋める。

- [ ] **Step 6: 【スパイク検証】ショートカットアプリへの露出確認**

iOS 26 シミュレータへ `flutter run`（または Xcode から Runner を実行）してアプリを一度起動後、ショートカットアプリを開き「EQMonitor」の下に「接続確認」が表示されることを確認する。

**表示されない場合のフォールバック（このタスク内で対応）:** `EQMonitorShortcuts`（AppShortcutsProvider）だけを Runner ターゲットに移す。その場合、参照する Intent 型のソースを Runner とのターゲットメンバーシップ共有にし、ファイル全体を `@available(iOS 26.0, *)` でガードする（Runner は iOS 16.0 のため）。以降のタスクの AppShortcutsProvider 配置もこれに従う。

- [ ] **Step 7: Commit**

```bash
git add app/ios && git commit -m "feat(ios): App Intents Extension ターゲットを追加"
```

---

### Task 2: 表記ロジックの Flutter 適合修正 + ユニットテスト

**Files:**
- Modify: `app/ios/Widget/Models/EarthquakeDisplayItem.swift`
- Create: `app/ios/WidgetModelsTests/EarthquakeDisplayItemTests.swift`
- Modify: `app/ios/scripts/add_appintents_extension.rb`（テストターゲット追加分を別スクリプト `add_widget_models_tests.rb` として作成）
- Modify: `app/ios/Widget/Views/EarthquakeWidgetView.swift` / `MapEarthquakeWidgetView.swift`（深さ空文字時の非表示対応）

**Interfaces:**
- Consumes: `EarthquakeDisplayItem`（既存）、`Components.Schemas.Magnitude`（`._type: .NORMAL|.UNKNOWN|.OVER_M8`, `.value: Double?`）、`Components.Schemas.Depth`（同様に `._type` + `.value`）、`IntensityValue`（`.displayString` を使う。`label` は無い）
- Produces: 既存の `private static` フォーマット関数を **internal static へ昇格**（シグネチャは実物を維持）:
  - `formatMagnitude(_ magnitude: Components.Schemas.Magnitude?) -> String`（`.OVER_M8` を "M8超" に）
  - `formatTime(origin: Date?, arrival: Date?) -> String`（**新シグネチャ**。現行 `formatTime(_ date: Date)` を置換。"yyyy/MM/dd HH:mm頃発生"／arrival フォールバック時 "頃検知"）
  - `formatDepth(_ depth: Components.Schemas.Depth?) -> String`（`.UNKNOWN`/`value` 無しを空文字に）
  - `resolveTitle(hypocenterName: String?, maxIntensity: IntensityValue?) -> String`（**新規**。現行の init 内フォールバック `"震源地不明"` をこれに置換）

- [ ] **Step 1: テストターゲット追加スクリプトを作成・実行**

`app/ios/scripts/add_widget_models_tests.rb`（`unit_test_bundle` ターゲット `WidgetModelsTests` を新規作成 — 既存テストターゲットは無い。`Widget/Models/*.swift` と `Widget/Services/WidgetRegionResolver.swift` をコンパイル対象に追加し、`EQMonitorAPI` プロダクト依存を付与、`IPHONEOS_DEPLOYMENT_TARGET = 26.0`、`TEST_HOST` は設定しない）。Task 1 のスクリプトを参考に同構造で書く（`widget = ...find { |t| t.name == 'WidgetExtension' }` からビルド設定を借用）。

```bash
cd app/ios && ruby scripts/add_widget_models_tests.rb
```

- [ ] **Step 2: 失敗するテストを書く**

`app/ios/WidgetModelsTests/EarthquakeDisplayItemTests.swift`:

```swift
import Testing
import EQMonitorAPI
// Widget/Models・Widget/Services のソースを本テストターゲットへ直接コンパイルするため
// アプリ/ウィジェットの import は不要（internal 参照で到達）。

struct FormatTests {
    private func jst(_ iso: String) -> Date { ISO8601DateFormatter().date(from: iso)! }

    @Test func magnitudeOver8() {
        // Components.Schemas.Magnitude のメンバワイズ init のラベルは生成コードで確認して合わせる
        let mag = Components.Schemas.Magnitude(_type: .OVER_M8, value: nil)
        #expect(EarthquakeDisplayItem.formatMagnitude(mag) == "M8超")
    }
    @Test func magnitudeNormal() {
        let mag = Components.Schemas.Magnitude(_type: .NORMAL, value: 8.0)
        #expect(EarthquakeDisplayItem.formatMagnitude(mag) == "M8.0")
    }
    @Test func dateWithOriginTime() {
        #expect(EarthquakeDisplayItem.formatTime(origin: jst("2026-07-03T10:15:00+09:00"), arrival: nil)
                == "2026/07/03 10:15頃発生")
    }
    @Test func dateFallsBackToArrival() {
        #expect(EarthquakeDisplayItem.formatTime(origin: nil, arrival: jst("2026-07-03T10:15:00+09:00"))
                == "2026/07/03 10:15頃検知")
    }
    @Test func unknownDepthIsEmpty() {
        #expect(EarthquakeDisplayItem.formatDepth(Components.Schemas.Depth(_type: .UNKNOWN, value: nil)) == "")
    }
    @Test func hypocenterFallbackUsesIntensity() {
        #expect(EarthquakeDisplayItem.resolveTitle(hypocenterName: nil, maxIntensity: .fiveLower)
                == "最大震度5弱を観測")
    }
}
```

※ `Components.Schemas.Magnitude`/`Depth` のメンバワイズ init の引数ラベル（`_type:value:` 等）は生成 `Types.swift` で確認して合わせる（TDD の最初のコンパイルで判明する）。日時テストは `Asia/Tokyo` 固定前提。`resolveTitle` は `maxIntensity.displayString`（"5弱" 等）を使う。

- [ ] **Step 3: テスト実行で失敗を確認**

```bash
cd app/ios && xcodebuild test -workspace Runner.xcworkspace -scheme WidgetModelsTests \
  -destination 'platform=iOS Simulator,name=iPhone 17' 2>&1 | tail -20
# 期待: コンパイルエラーまたはテスト失敗（"M8以上" != "M8超" 等）
```

（スキームが自動生成されない場合は `xcodebuild -list` で確認し、shared scheme を追加する）

- [ ] **Step 4: 実装修正**

`EarthquakeDisplayItem.swift` の既存 `private static` 関数を internal 化して修正:

```swift
// 1. M8超（現: .OVER_M8 -> "M8以上"）。他ケースは現状維持
static func formatMagnitude(_ magnitude: Components.Schemas.Magnitude?) -> String {
    guard let mag = magnitude else { return "M不明" }
    switch mag._type {
    case .NORMAL:  return mag.value.map { String(format: "M%.1f", $0) } ?? "M不明"
    case .UNKNOWN: return "M不明"
    case .OVER_M8: return "M8超"   // ← 変更点
    }
}

// 2. yyyy/MM/dd HH:mm頃発生 ／ 頃検知（現: formatTime(_ date: Date) -> "MM/dd HH:mm頃"）
static func formatTime(origin: Date?, arrival: Date?) -> String {
    let f = DateFormatter()
    f.dateFormat = "yyyy/MM/dd HH:mm"
    f.locale = Locale(identifier: "ja_JP")
    f.timeZone = TimeZone(identifier: "Asia/Tokyo")
    if let origin  { return f.string(from: origin)  + "頃発生" }
    if let arrival { return f.string(from: arrival) + "頃検知" }
    return ""
}

// 3. 深さ不明/未取得は空文字（現: "不明"）。View 側は depth.isEmpty で行ごと非表示
static func formatDepth(_ depth: Components.Schemas.Depth?) -> String {
    guard let d = depth else { return "" }
    switch d._type {
    case .SHALLOW:  return "ごく浅い"
    case .NORMAL:   return d.value.map { "\(Int($0))km" } ?? ""   // ← 変更点
    case .OVER_700: return "700km以上"
    case .UNKNOWN:  return ""                                     // ← 変更点
    }
}

// 4. 震源名フォールバック（現: init 内で "震源地不明"）
static func resolveTitle(hypocenterName: String?, maxIntensity: IntensityValue?) -> String {
    if let name = hypocenterName, !name.isEmpty { return name }
    if let maxIntensity { return "最大震度\(maxIntensity.displayString)を観測" }
    return ""
}
```

`init(from:)` 群を更新: (a) `originTime` に加え **arrival 相当のフィールドを partial から取得**（API スキーマで `arrival_time` 等の実フィールド名を確認。現行モデルは origin のみ保持のため、必要なら `formattedTime` を `formatTime(origin:arrival:)` 経由で組み立てる）。(b) `hypocenterName` が `"震源地不明"` になっていた箇所を `resolveTitle(hypocenterName:maxIntensity:)` 経由に置換。(c) `EarthquakeWidgetView` / `MapEarthquakeWidgetView` で `depth.isEmpty` のとき「深さ」表示行を出さない。

- [ ] **Step 5: テストが通ることを確認（Step 3 と同コマンド、期待: TEST SUCCEEDED）**

- [ ] **Step 6: 共通ビルドで既存 Widget も壊れていないことを確認**

- [ ] **Step 7: Commit**

```bash
git add app/ios && git commit -m "fix(ios/widget): 表記ロジックをアプリ実装に適合（M8超・日時・深さ不明・震源名フォールバック）"
```

---

### Task 3: EarthquakeAPIService に震度フィルタ（intensityGte）を追加

**Files:**
- Modify: `app/ios/Widget/Services/EarthquakeAPIClient.swift`（型名は **`EarthquakeAPIService`**、ファイル名は `EarthquakeAPIClient.swift`）

**Interfaces:**
- Produces: `EarthquakeAPIService` の各 fetch メソッドに `minIntensity: Components.Schemas.JmaIntensity? = nil` を追加した新シグネチャ。
  - `fetchEarthquakes(limit:minIntensity:)`
  - `fetchEarthquakesByRegion(regionCode:limit:minIntensity:)`
  - `fetchEarthquakesByPrefecture(prefectureCode:limit:minIntensity:)`
  - `fetchEarthquakesByCity(cityCode:limit:minIntensity:)`
- 前提: 生成クライアントの `Input.Query` は **既に `intensityGte: Components.Schemas.JmaIntensity?` を保持**（nationwide/region/pref/city すべて）。生成コード改変は不要。Service メソッドに引数を足して Query に渡すだけ。

- [ ] **Step 1: 4メソッドに引数を追加し、query に `intensityGte: minIntensity` を渡す**

```swift
func fetchEarthquakes(
    limit: Int = 10,
    minIntensity: Components.Schemas.JmaIntensity? = nil
) async throws -> [EarthquakeDisplayItem] {
    let response = try await client.getV2Earthquake(
        query: .init(limit: String(limit), intensityGte: minIntensity)
    )
    ...  // 既存の switch はそのまま
}
```

（region/pref/city も同様に各 `query: .init(...)` に `intensityGte: minIntensity` を追記。ラベル名は生成定義どおり `intensityGte`）

- [ ] **Step 2: 共通ビルドで BUILD SUCCEEDED を確認**

- [ ] **Step 3: Commit**

```bash
git add app/ios/Widget/Services/EarthquakeAPIClient.swift
git commit -m "feat(ios/widget): EarthquakeAPIService に最小震度フィルタを追加"
```

---

### Task 4: DesignTokens 新設（色のアプリ同値化 + GoogleSans フォント登録）

**Files:**
- Create: `app/ios/Widget/DesignTokens.swift`（Widget / AppIntentsExtension 両ターゲットメンバーシップ）
- Modify: `app/ios/Widget/DesignSystem.swift`（色定数を DesignTokens 参照に置換。レイアウト系は Phase 3 まで現状維持）
- Resources: `app/assets/fonts/GoogleSansFlex/GoogleSansFlex[GRAD,ROND,opsz,slnt,wdth,wght].ttf` と `app/assets/fonts/GoogleSansCode/GoogleSansCode[MONO,wght].ttf` への file reference を AppIntentsExtension のリソースに追加（コピーせず参照。ruby スクリプトまたは pbxproj 直編集）

**Interfaces:**
- Produces:
  - `enum DesignTokens` — `static let bg/surface/card/brand/textPrimary/textSecondary/textTertiary: Color`（light/dark 対応）、`static let radiusCard: CGFloat = 24` / `radiusMd = 16` / `radiusSm = 12` / `radiusXs = 8`
  - `enum AppFonts` — `static func registerIfNeeded()`、`static func flex(size: CGFloat, weight: Font.Weight) -> Font`、`static func code(size: CGFloat, weight: Font.Weight) -> Font`

- [ ] **Step 1: フォントのファミリー名を確認**

```bash
pip3 install --user fonttools -q
python3 - <<'EOF'
from fontTools.ttLib import TTFont
for p in ["app/assets/fonts/GoogleSansFlex/GoogleSansFlex[GRAD,ROND,opsz,slnt,wdth,wght].ttf",
          "app/assets/fonts/GoogleSansCode/GoogleSansCode[MONO,wght].ttf"]:
    f = TTFont(p)
    print(p, "->", f["name"].getDebugName(1), "/", f["name"].getDebugName(6))
EOF
# 出力されたファミリー名を Step 2 の Font.custom に使う
```

- [ ] **Step 2: DesignTokens.swift を実装**

```swift
import SwiftUI
import CoreText

enum DesignTokens {
    // アプリ ColorThemeExtension (app/lib/core/theme/) と同値。変更時は両方直すこと
    static let bg = adaptive(light: 0xF5F8FC, dark: 0x0F141A)
    static let surface = adaptive(light: 0xFFFFFF, dark: 0x171E26)
    static let card = adaptive(light: 0xEAF0F7, dark: 0x232D38)
    static let brand = adaptive(light: 0x2F6FE0, dark: 0x4D8DFF)

    static let radiusCard: CGFloat = 24
    static let radiusMd: CGFloat = 16
    static let radiusSm: CGFloat = 12
    static let radiusXs: CGFloat = 8

    private static func adaptive(light: UInt32, dark: UInt32) -> Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor(rgb: dark) : UIColor(rgb: light)
        })
    }
}

enum AppFonts {
    private static var registered = false
    static func registerIfNeeded() {
        guard !registered else { return }
        registered = true
        for name in ["GoogleSansFlex[GRAD,ROND,opsz,slnt,wdth,wght]", "GoogleSansCode[MONO,wght]"] {
            if let url = Bundle.main.url(forResource: name, withExtension: "ttf") {
                CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
            }
        }
    }
    static func flex(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom("Google Sans Flex", size: size).weight(weight) // Step 1 の実ファミリー名に合わせる
    }
    static func code(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom("Google Sans Code", size: size).weight(weight) // 同上
    }
}
```

日本語グリフはヒラギノに自動フォールバックされる（NotoSansJP はバンドルしない。サイズ削減のため）。

- [ ] **Step 3: `DesignSystem.swift` の既存色定数を DesignTokens 参照に置換**

実名は `eqBg`(現 `0xF1F4F8`/`0x0F141A`) / `eqSurface` / `eqCard`(現 `0xEDF1F6`/`0x232D38`) / `eqBrand` など（`eq` プレフィックスの light/dark 2値ペア）。アプリ同値化に伴い bg→`0xF5F8FC`、card→`0xEAF0F7` 等へ更新する場合は **light/dark 両値を DesignTokens 側で定義**し、`extension Color` の各定数を `DesignTokens.*` へ委譲する（`eqGlass` / `eqSurfaceGradient` などレイアウト・質感系は Phase 3 まで現状維持）。変更する light 値がアプリの `ColorThemeExtension`（`app/lib/core/theme/`）と一致することを実装時に確認。

- [ ] **Step 4: 共通ビルド + 既存ウィジェットのスクリーンショットで色ズレ解消を目視確認**

- [ ] **Step 5: Commit**

```bash
git add app/ios && git commit -m "feat(ios): DesignTokens 新設 — アプリ同値カラーと GoogleSans フォント登録"
```

---

### Task 5: JMA コードテーブルローダと RegionEntity（AppEntity）

**Files:**
- Create: `app/ios/AppIntentsExtension/JmaCodeTable.swift`
- Create: `app/ios/AppIntentsExtension/RegionEntity.swift`
- Resources: `app/assets/parameters/jma_code_table.json` への file reference を AppIntentsExtension のリソースに追加（Flutter アセットは拡張から読めないため個別バンドルが必要。コピーではなく参照追加）

**Interfaces:**
- Produces:
  - `struct JmaCodeTable` — `static let shared: JmaCodeTable`、`let prefectures: [JmaArea]`（47件）、`let cities: [JmaArea]`（4361件）。`struct JmaArea { let code: String; let nameJa: String; let kind: Kind }`（`Kind = .prefecture | .city`）
  - `struct RegionEntity: AppEntity` — `id: String`（`"prefecture:01"` / `"city:0123500"` 形式）、`name: String`、`kind`。`defaultQuery = RegionQuery()`
  - `RegionEntity.fetchPlan` — `WidgetFetchPlan` への変換（`.prefecture(code:)` / `.city(code:)`）

- [ ] **Step 1: JSON デコーダを実装**

```swift
import Foundation

struct JmaCodeTable {
    struct JmaArea: Hashable {
        enum Kind: String { case prefecture, city }
        let code: String
        let nameJa: String
        let kind: Kind
    }

    let prefectures: [JmaArea]
    let cities: [JmaArea]

    static let shared: JmaCodeTable = load()

    private static func load() -> JmaCodeTable {
        struct Root: Decodable { let code_tables: Tables }
        struct Tables: Decodable {
            let area_information_prefecture_earthquake: [Entry]
            let area_information_city: [Entry]
        }
        struct Entry: Decodable {
            let code: String
            let name: Name
            struct Name: Decodable { let ja: String }
        }
        guard let url = Bundle.main.url(forResource: "jma_code_table", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let root = try? JSONDecoder().decode(Root.self, from: data)
        else { return JmaCodeTable(prefectures: [], cities: []) }
        return JmaCodeTable(
            prefectures: root.code_tables.area_information_prefecture_earthquake
                .map { .init(code: $0.code, nameJa: $0.name.ja, kind: .prefecture) },
            cities: root.code_tables.area_information_city
                .map { .init(code: $0.code, nameJa: $0.name.ja, kind: .city) }
        )
    }
}
```

- [ ] **Step 2: RegionEntity + EntityStringQuery を実装**

```swift
import AppIntents

struct RegionEntity: AppEntity {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "地域"
    static let defaultQuery = RegionQuery()

    let id: String            // "prefecture:01" / "city:0123500"
    let name: String
    let kind: JmaCodeTable.JmaArea.Kind

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(name)",
            subtitle: kind == .prefecture ? "都道府県" : "市区町村"
        )
    }

    init(area: JmaCodeTable.JmaArea) {
        self.id = "\(area.kind.rawValue):\(area.code)"
        self.name = area.nameJa
        self.kind = area.kind
    }

    var fetchPlan: WidgetFetchPlan {
        let code = String(id.split(separator: ":")[1])
        return kind == .prefecture ? .prefecture(code: code) : .city(code: code)
    }
}

struct RegionQuery: EntityStringQuery {
    func entities(for identifiers: [String]) async throws -> [RegionEntity] {
        let all = JmaCodeTable.shared.prefectures + JmaCodeTable.shared.cities
        return all.filter { identifiers.contains("\($0.kind.rawValue):\($0.code)") }
            .map(RegionEntity.init)
    }
    func entities(matching string: String) async throws -> [RegionEntity] {
        let all = JmaCodeTable.shared.prefectures + JmaCodeTable.shared.cities
        return all.filter { $0.nameJa.contains(string) }.prefix(30).map(RegionEntity.init)
    }
    func suggestedEntities() async throws -> [RegionEntity] {
        JmaCodeTable.shared.prefectures.map(RegionEntity.init)
    }
}
```

- [ ] **Step 3: 共通ビルドで BUILD SUCCEEDED を確認**

- [ ] **Step 4: Commit**

```bash
git add app/ios && git commit -m "feat(ios/intents): JMAコードテーブルと RegionEntity を追加"
```

---

### Task 6: 最小震度 AppEnum

**Files:**
- Create: `app/ios/AppIntentsExtension/MinIntensityOption.swift`

**Interfaces:**
- Produces: `enum MinIntensityOption: String, AppEnum` — `var apiValue: Components.Schemas.JmaIntensity`

- [ ] **Step 1: 実装**

```swift
import AppIntents
import EQMonitorAPI

enum MinIntensityOption: String, AppEnum {
    case int1 = "1", int2 = "2", int3 = "3", int4 = "4"
    case int5Lower = "5-", int5Upper = "5+"
    case int6Lower = "6-", int6Upper = "6+", int7 = "7"

    static let typeDisplayRepresentation: TypeDisplayRepresentation = "最小震度"
    static let caseDisplayRepresentations: [MinIntensityOption: DisplayRepresentation] = [
        .int1: "震度1以上", .int2: "震度2以上", .int3: "震度3以上", .int4: "震度4以上",
        .int5Lower: "震度5弱以上", .int5Upper: "震度5強以上",
        .int6Lower: "震度6弱以上", .int6Upper: "震度6強以上", .int7: "震度7",
    ]

    var apiValue: Components.Schemas.JmaIntensity {
        Components.Schemas.JmaIntensity(rawValue: rawValue)!
    }
}
```

- [ ] **Step 2: 共通ビルド確認 → Commit**

```bash
git add app/ios && git commit -m "feat(ios/intents): 最小震度 AppEnum を追加"
```

---

### Task 7: GetLatestEarthquakesIntent + Interactive Snippet + 新デザイン SnippetView

**Files:**
- Create: `app/ios/AppIntentsExtension/EarthquakeEntity.swift`
- Create: `app/ios/AppIntentsExtension/GetLatestEarthquakesIntent.swift`
- Create: `app/ios/AppIntentsExtension/EarthquakeSnippetView.swift`
- Modify: `app/ios/AppIntentsExtension/AppIntentsExtension.swift`（PingIntent 削除）

**Interfaces:**
- Consumes: `EarthquakeAPIService.fetch*(…minIntensity:)`（Task 3）、`RegionEntity`（Task 5）、`MinIntensityOption`（Task 6）、`DesignTokens`/`AppFonts`（Task 4）、`EarthquakeDisplayItem`（Task 2）
- Produces:
  - `struct EarthquakeEntity: AppEntity`（id=eventId、hypocenterName・magnitude・depth・maxIntensity・occurredAt の `@Property` 群）— オートメーションの後続アクションで参照可能
  - `struct GetLatestEarthquakesIntent: AppIntent` — `perform() -> ReturnsValue<[EarthquakeEntity]> & ShowsSnippetIntent`
  - `struct EarthquakeSnippetIntent: SnippetIntent` — カード描画本体（Task 8 でも再利用）
  - `struct EarthquakeSnippetView: View` — items / タイトル / 空状態を受けて新デザインで描画

- [ ] **Step 1: EarthquakeEntity を実装**

```swift
import AppIntents

struct EarthquakeEntity: AppEntity, Identifiable {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "地震情報"
    static let defaultQuery = EarthquakeEntityQuery()

    let id: String                     // eventId
    @Property(title: "震源") var hypocenterName: String
    @Property(title: "マグニチュード") var magnitude: String
    @Property(title: "深さ") var depth: String
    @Property(title: "最大震度") var maxIntensity: String
    @Property(title: "発生時刻") var occurredAt: String

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(hypocenterName)", subtitle: "\(maxIntensity) \(magnitude)")
    }

    init(item: EarthquakeDisplayItem) {
        self.id = item.id                               // ← EarthquakeDisplayItem.id（eventId ではない）
        self.hypocenterName = item.hypocenterName
        self.magnitude = item.magnitude
        self.depth = item.depth
        self.maxIntensity = item.maxIntensity?.displayString ?? "不明"  // ← displayString（label は無い）
        self.occurredAt = item.formattedTime            // ← formattedTime（dateText ではない）
    }
}

struct EarthquakeEntityQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [EarthquakeEntity] { [] } // 履歴参照は非対応
    func suggestedEntities() async throws -> [EarthquakeEntity] { [] }
}
```

（`EarthquakeDisplayItem` の実プロパティ: `id` / `hypocenterName` / `magnitude` / `depth` / `maxIntensity: IntensityValue?` / `formattedTime`。`title` プロパティは無い — 表示タイトルは `hypocenterName`（Task 2 の `resolveTitle` 適用済み）を使う）

- [ ] **Step 2: メイン Intent とスニペット Intent を実装**

```swift
import AppIntents
import EQMonitorAPI

struct GetLatestEarthquakesIntent: AppIntent {
    static let title: LocalizedStringResource = "最新の地震情報を確認"
    static let description = IntentDescription(
        "最新の地震情報をカードで表示します。地域指定は EQMonitor Pro の機能です。")

    @Parameter(title: "対象地域", description: "未指定の場合は全国")
    var region: RegionEntity?

    @Parameter(title: "最小震度")
    var minIntensity: MinIntensityOption?

    @Parameter(title: "表示件数", default: 3, controlStyle: .stepper, inclusiveRange: (1, 10))
    var limit: Int

    func perform() async throws
        -> some ReturnsValue<[EarthquakeEntity]> & ShowsSnippetIntent {
        let store = UserDefaults(suiteName: "group.net.yumnumm.eqmonitor")
        if region != nil, store?.bool(forKey: "isPro") != true {
            throw IntentError.proRequired
        }
        let items = try await EarthquakeFetcher.fetch(
            plan: region?.fetchPlan ?? .nationwide,
            limit: limit,
            minIntensity: minIntensity?.apiValue
        )
        return .result(
            value: items.map(EarthquakeEntity.init),
            snippetIntent: EarthquakeSnippetIntent(
                regionID: region?.id, minIntensity: minIntensity, limit: limit)
        )
    }
}

struct EarthquakeSnippetIntent: SnippetIntent {
    static let title: LocalizedStringResource = "地震情報カード"

    @Parameter var regionID: String?
    @Parameter var minIntensity: MinIntensityOption?
    @Parameter var limit: Int

    init() {}
    init(regionID: String?, minIntensity: MinIntensityOption?, limit: Int) {
        self.regionID = regionID
        self.minIntensity = minIntensity
        self.limit = limit
    }

    func perform() async throws -> some IntentResult & ShowsSnippetView {
        let plan = regionID.flatMap(Self.plan(fromRegionID:)) ?? .nationwide
        let items = try await EarthquakeFetcher.fetch(
            plan: plan, limit: limit, minIntensity: minIntensity?.apiValue)
        return .result(view: EarthquakeSnippetView(
            title: Self.snippetTitle(regionID: regionID, minIntensity: minIntensity),
            items: items))
    }
}

enum IntentError: Error, CustomLocalizedStringResourceConvertible {
    case proRequired
    case locationUnavailable

    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .proRequired: "地域指定は EQMonitor Pro の機能です。アプリからご登録ください。"
        case .locationUnavailable: "現在地が未取得です。EQMonitor アプリを起動して位置情報を有効にしてください。"
        }
    }
}
```

補助: `EarthquakeFetcher.fetch(plan:limit:minIntensity:)` は `WidgetFetchPlan` に応じて `EarthquakeAPIService.shared` の4メソッド（`fetchEarthquakes` / `fetchEarthquakesByRegion` / `fetchEarthquakesByPrefecture` / `fetchEarthquakesByCity`）へ分岐する薄い static 関数として `AppIntentsExtension/EarthquakeFetcher.swift` に実装（Widget 側 Provider にある分岐ロジックを流用）。0件時はエラーにせず空配列を返す。`EarthquakeAPIService`/`WidgetFetchPlan`/`EarthquakeDisplayItem`/`IntensityValue` を AppIntentsExtension から参照するため、これらのソースを **AppIntentsExtension のターゲットメンバーシップにも追加**する（Task 1 スクリプトまたは追補スクリプトで file reference をターゲットに追加。EQMonitorAPI 依存は Task 1 で付与済み）。

- [ ] **Step 3: SnippetView を新デザインで実装**

```swift
import SwiftUI

struct EarthquakeSnippetView: View {
    let title: String
    let items: [EarthquakeDisplayItem]

    init(title: String, items: [EarthquakeDisplayItem]) {
        self.title = title
        self.items = items
        AppFonts.registerIfNeeded()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(AppFonts.flex(size: 15, weight: .bold))
            if items.isEmpty {
                Text("条件に合う地震はありません")
                    .font(AppFonts.flex(size: 13))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, minHeight: 60)
            } else {
                ForEach(items, id: \.id) { item in   // ← EarthquakeDisplayItem.id
                    EarthquakeSnippetRow(item: item)
                }
            }
            Button(intent: EarthquakeSnippetIntent /* 同一パラメータで再実行 */) {
                Label("更新", systemImage: "arrow.clockwise")
            }
        }
        .padding(14)
    }
}

// 行: アプリの earthquake_history_list_tile と同構造
// [震度バッジ(角丸size/4, bold)] [震源名(bold flex) / 日時+深さ(code)] [M値(code)]
// 行背景: 最大震度色 alpha 0.4・角丸 DesignTokens.radiusSm
struct EarthquakeSnippetRow: View {
    let item: EarthquakeDisplayItem

    var body: some View {
        HStack(spacing: 10) {
            // 既存 IntensityBadge のメンバ: intensity:(main,sub) / backgroundColor / textColor / size(+今回 cornerRatio 追加)
            IntensityBadge(
                intensity: item.maxIntensity?.formattedParts ?? ("—", nil),
                backgroundColor: item.maxIntensity?.backgroundColor ?? .gray,
                textColor: item.maxIntensity?.textColor ?? .white,
                size: 40,
                cornerRatio: 0.25
            )
            VStack(alignment: .leading, spacing: 2) {
                Text(item.hypocenterName).font(AppFonts.flex(size: 14, weight: .bold)) // title プロパティは無い
                Text([item.formattedTime, item.depth.isEmpty ? nil : "深さ \(item.depth)"]
                    .compactMap { $0 }.joined(separator: " "))
                    .font(AppFonts.code(size: 11))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(item.magnitude).font(AppFonts.code(size: 16, weight: .bold))
        }
        .padding(.horizontal, 10).padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: DesignTokens.radiusSm)
                .fill((item.maxIntensity?.backgroundColor ?? .gray).opacity(0.4))
        )
    }
}
```

（`IntensityBadge` は既存 `EarthquakeWidgetView.swift` 内の internal 定義を共有ファイルへ移動し、`var cornerRatio: CGFloat = 0.0` を追加して角丸を `size * cornerRatio` で算出するよう修正。既存呼び出し2箇所＋Map版は引数省略でデフォルト維持）

- [ ] **Step 4: PingIntent を削除し、共通ビルドで BUILD SUCCEEDED を確認**

- [ ] **Step 5: シミュレータでショートカットアプリから実行し、カード表示・Pro ゲート・0件表示を手動確認**

確認項目: ①全国/件数3でカードが出る ②非Pro状態（App Group `isPro` false）で地域指定 → エラーダイアログ ③最小震度7指定 → 「条件に合う地震はありません」 ④「更新」ボタンでその場更新

- [ ] **Step 6: Commit**

```bash
git add app/ios && git commit -m "feat(ios/intents): 最新地震情報の Interactive Snippet を追加"
```

---

### Task 8: GetEarthquakesNearMeIntent（現在地版）

**Files:**
- Create: `app/ios/AppIntentsExtension/GetEarthquakesNearMeIntent.swift`

**Interfaces:**
- Consumes: `WidgetRegionResolver.resolve(regionType: .currentLocation)`（既存）、`EarthquakeSnippetIntent`（Task 7）
- Produces: `struct GetEarthquakesNearMeIntent: AppIntent` — パラメータは minIntensity / limit のみ

- [ ] **Step 1: 実装**

```swift
import AppIntents

struct GetEarthquakesNearMeIntent: AppIntent {
    static let title: LocalizedStringResource = "現在地の地震情報を確認"
    static let description = IntentDescription("現在地周辺の最新の地震情報をカードで表示します。")

    @Parameter(title: "最小震度")
    var minIntensity: MinIntensityOption?

    @Parameter(title: "表示件数", default: 3, controlStyle: .stepper, inclusiveRange: (1, 10))
    var limit: Int

    func perform() async throws
        -> some ReturnsValue<[EarthquakeEntity]> & ShowsSnippetIntent {
        let resolved = WidgetRegionResolver.resolve(regionType: .currentLocation)
        guard case .region(let code) = resolved.plan else {
            throw IntentError.locationUnavailable  // 全国フォールバックは誤情報になるため明示エラー
        }
        let items = try await EarthquakeFetcher.fetch(
            plan: .region(code: code), limit: limit, minIntensity: minIntensity?.apiValue)
        return .result(
            value: items.map(EarthquakeEntity.init),
            snippetIntent: EarthquakeSnippetIntent(
                regionID: "region:\(code)", minIntensity: minIntensity, limit: limit))
    }
}
```

※ `WidgetRegionResolver.resolve(.currentLocation)` は現在地未設定時に全国へフォールバックする仕様のため、`resolved.plan == .nationwide` の場合を「未取得」とみなしてエラーにする。`EarthquakeSnippetIntent.plan(fromRegionID:)` に `"region:"` プレフィックス対応を追加（Task 7 の関数を拡張）。

- [ ] **Step 2: 共通ビルド → シミュレータで手動確認（現在地未設定エラーと、App Group に地域コードを書いた状態での表示）**

- [ ] **Step 3: Commit**

```bash
git add app/ios && git commit -m "feat(ios/intents): 現在地の地震情報 Intent を追加"
```

---

### Task 9: AppShortcutsProvider 本実装 + 総合検証

**Files:**
- Modify: `app/ios/AppIntentsExtension/AppIntentsExtension.swift`（Task 1 のスパイク結果次第で Runner 側）

**Interfaces:**
- Consumes: `GetLatestEarthquakesIntent`（Task 7）、`GetEarthquakesNearMeIntent`（Task 8）

- [ ] **Step 1: App Shortcuts を定義**

```swift
struct EQMonitorShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: GetLatestEarthquakesIntent(),
            phrases: [
                "\(.applicationName)で最新の地震を確認",
                "\(.applicationName)で地震情報を見る",
            ],
            shortTitle: "最新の地震",
            systemImageName: "waveform.path.ecg"
        )
        AppShortcut(
            intent: GetEarthquakesNearMeIntent(),
            phrases: [
                "\(.applicationName)で現在地の地震を確認",
                "\(.applicationName)で近くの地震を見る",
            ],
            shortTitle: "現在地の地震",
            systemImageName: "location"
        )
    }
}
```

- [ ] **Step 2: 総合手動検証（iOS 26 シミュレータ/実機）**

チェックリスト:
- ショートカットアプリに2つの App Shortcut が表示される
- Spotlight 検索「最新の地震」でヒットし、実行するとスニペットが出る
- ショートカット編集画面で 対象地域（検索可）・最小震度・件数 が設定できる
- オートメーションで「最新の地震情報を確認」→「テキストを取得」等に地震エンティティのプロパティ（震源・最大震度…）が渡せる
- ライト/ダークモード両方でスニペットの配色がアプリと調和している

- [ ] **Step 3: ユニットテスト・共通ビルドの最終確認**

```bash
cd app/ios && xcodebuild test -workspace Runner.xcworkspace -scheme WidgetModelsTests \
  -destination 'platform=iOS Simulator,name=iPhone 17' 2>&1 | tail -5
# 期待: TEST SUCCEEDED
```

- [ ] **Step 4: Commit → PR 作成**

```bash
git add app/ios && git commit -m "feat(ios/intents): App Shortcuts を定義"
gh pr create --repo YumNumm/EQMonitor --base develop \
  --title "feat(ios): App Intents対応 Phase 1 — Interactive Snippetで地震情報カード" \
  --body "(設計・検証結果を記載)"
```

---

## Phase 2 / Phase 3（別計画・概要のみ）

**Phase 2: コントロールセンター（別計画を作成すること）**
- `FlutterDeepLinkingEnabled` を `true` にし、go_router で `deeplink.eqmonitor.app://earthquake-history-details/:eventId` 等の着信を処理（`false` になっている経緯と Google Sign-In コールバック非干渉を実装前に確認）
- Widget 拡張に `ControlWidgetButton` ×2: ①地震履歴を開く（`OpenURLIntent`）②`GetLatestEarthquakesIntent` を実行してスニペット表示（コントロールからのスニペット表示可否を冒頭でスパイク検証。不可なら「アプリを開く」動作に切替）
- スニペットの「アプリで開く」ボタン（詳細画面ディープリンク）もこの Phase で追加

**Phase 3: 既存ホーム画面 Widget のデザイン刷新（別計画を作成すること）**
- `EarthquakeWidgetView` / `MapEarthquakeWidgetView` を DesignTokens / AppFonts / 共有 IntensityBadge に載せ替え
- 震度バッジ角丸 25%・weight bold・数字スケーリング拡大、リスト行のアプリ同構造化
- Liquid Glass は維持
