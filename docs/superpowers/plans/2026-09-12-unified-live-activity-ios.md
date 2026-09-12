# 統合 Live Activity iOS Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** EEW・揺れ検知・地震情報の完全 snapshot を一つの Live Activity で表示し、新形式専用の受信・操作・表示を提供する。
**Architecture:** 新契約の Codable モデルは Runner / Widget / Preview / Tests で共有する。表示は受信した `primary` に従い、3情報のための新しい表示モデルとデザインを直接構築する。Activity の開始・結合・終了判断は backend に置く。
**Tech Stack:** Swift / ActivityKit / WidgetKit / SwiftUI、Flutter / Dart / Riverpod、既存 MethodChannel、Swift Testing / XCTest / flutter_test。
**Spec:** [新デザイン仕様](../specs/2026-09-12-unified-live-activity-ios-design.md)、2026-09-12のユーザー指示「古い形式は維持しなくていい」「Migrationとかも考えないで破壊変更を入れて良い」「デザインも含めて全部新しく」を最優先する。[EQMonitor Issue #1800](https://github.com/YumNumm/EQMonitor/issues/1800)、以下の固定 revision の schema と検証仕様。

## Global Constraints

- `attributes-type` は `EarthquakeLiveActivityAttributes`、静的 Attributes は `{id: string}` のみ。ID を UUID に変換しない。
- `schemaVersion: 2`。Start / Update は完全 snapshot。各ブロックと location の null、nullable と optional の差を維持する。
- `primary` は `shake_detection` / `eew` / `earthquake`。指定ブロック必須。クライアントで優先順位や通知条件を再計算しない。
- 最終報・取消・到達時刻を Activity 終了とみなさない。120 / 180 / 300 秒の独立終了タイマーを実装しない。
- 旧 EEW / 揺れ検知の型・Widget・デバッグ経路を削除する。互換 adapter、旧形式の decode、移行処理・移行試験・普及待ちの有効化条件は設けない。
- APNs トークン同期は `PATCH /v2/device/me/apns/LIVE_ACTIVITY_START` と `{token, environment}` を維持する。
- 個別 Activity update-token、端末別対応バージョン、クライアント Channel 割当 API は追加しない。
- 地域は AreaForecastLocalE の3桁コード。欠損地点・震度・時刻を推測や固定値で補わない。
- Dart の enum / DateTime と Swift の enum / 日時型を使用する。JSON の Map は境界に限定し、生成物は再生成する。
- Flutter / Dart コマンドは `mise exec --`。変更リスクに応じてテストする。文書だけの作成段階ではアプリの実装・配信を実行しない。
- 実装開始時に最新 `develop` を取り込む。PR 作成先は `--repo YumNumm/EQMonitor --base develop`。コミットは原則30〜100行、英語 prefix＋日本語の説明、コミット後に push。

## 調査基準と backend PR の確認結果

確認日時: 2026-09-12 16:15 JST。作業元 HEAD は `3ba2cea33fd5bf98de0a6dd502d9db1bd40df15b`。取得した `origin/develop` は `3f92e9468cb351948759b320db61da1c602b78f8`。対象 Live Activity 実装の差分はなく、device debug 画面に1行の変更のみ。

backend の固定基準は `00f2caf9ffef0861f0b9a52cca675593d9c60409`。

| PR | 確認結果とクライアントへの影響 |
| --- | --- |
| [#1182](https://github.com/YumNumm/eqmonitor-backend/pull/1182) | マージ済み。3ブロック、Magnitude union、informationType 配列の契約を追加。 |
| [#1195](https://github.com/YumNumm/eqmonitor-backend/pull/1195) | マージ済み。投影処理を確認。`contentState.id` と静的 `id` に存続 Lease の `eventId` を使用。 |
| [#1196](https://github.com/YumNumm/eqmonitor-backend/pull/1196) | マージ済み。旧 End と参加端末の新 Start。異なる EEW eventId 同士は結合しない。 |
| [#1197](https://github.com/YumNumm/eqmonitor-backend/pull/1197) | マージ済み。Sender は配信順序・End・復旧を担当。APNs の受信順序や exactly-once は保証しない。 |
| [#1199](https://github.com/YumNumm/eqmonitor-backend/pull/1199) / [#1200](https://github.com/YumNumm/eqmonitor-backend/pull/1200) | マージ済み。入力接続、旧 Start 抑止、検証・有効化条件。 |
| [#1203](https://github.com/YumNumm/eqmonitor-backend/pull/1203) | **2026-09-12 07:12:40 UTC にマージ済み**。Issue 本文の未マージ記述は古い。型名を固定し、Sender 復旧・Helm 設定を追加。 |
| [#1202](https://github.com/YumNumm/eqmonitor-backend/pull/1202) | 確認時点 OPEN。Resolver 0.20.0 / Manager 0.4.0 / Sender 0.9.0。 |

正典: [schema](https://github.com/YumNumm/eqmonitor-backend/blob/00f2caf9ffef0861f0b9a52cca675593d9c60409/packages/notification-common/src/types/unified-live-activity-content-state.ts)、[sample](https://github.com/YumNumm/eqmonitor-backend/blob/00f2caf9ffef0861f0b9a52cca675593d9c60409/docs/examples/unified-live-activity-content-state.json)、[projection](https://github.com/YumNumm/eqmonitor-backend/blob/00f2caf9ffef0861f0b9a52cca675593d9c60409/service/notification-resolver/src/live-activity/unified/payload-policy.ts)、[validation](https://github.com/YumNumm/eqmonitor-backend/blob/00f2caf9ffef0861f0b9a52cca675593d9c60409/docs/unified-live-activity-validation.md)。設計書に残る「設計中」より、固定 schema・投影実装・最新検証仕様を優先する。

PR #1203 は確認時点で Go Build / Format が失敗し、他の CI は実行中だった。PR 記載のローカル成功件数を全 CI 成功とは扱わない。この調査では DB・稼働サービス・APNs 配信を再検証していない。Helm 既定値は有効化 `false`、retention `null`。この retention は終了済みデータの保存処理であり、iOS の受信圧縮 codec を追加する意味ではない。

## 採用方針

新形式専用の共有 wire モデル・表示モデル・Widget・デバッグ画面へ全面置換する。旧モデルへの変換も旧デザインの継承も行わない。震度やMagnitudeのドメイン型、日時の安全な処理など、表示と互換性に依存しない基礎部品だけを再利用する。旧形式との互換は今回の要件から除外されている。

## 現状との差分と作業順序

| 現状 | 必要な変更 | Task |
| --- | --- | --- |
| 旧 Attributes は UUID と静的 eventId | String id の新共有型・3ブロックを追加 | 1 |
| 表示は EEW / 揺れ検知の2系統 | 統合専用デザイン・`primary` 選択・情報種別と地域の明示 | 2–3 |
| Runner の新規開始は eventId 必須 | 新形式の id と OS activityId を分離、一覧復元 | 4 |
| Dart は2種別・無型 JSON の生成中心 | 旧種別選択を削除し、統合 DTO / preset / codec / session へ置換 | 5 |
| APNs environment は production 固定 | sandbox 検証用の署名一致設定を用意 | 6 |
| Swift は iOS 26.1 未満を除外、Dart は18以上 | 対応判定を揃える前提修正と境界テスト | 6 |
| PR Flutter CI に WidgetModelsTests がない | Swift の検証を明示して実機受け入れへ進む | 7 |

新デザイン仕様を基準とし、依存順は `1 → 2 → 3 → 4 → 5 → 7`。Task 6 は端末配信検証の前提として Task 7 より前に完了する。モデル・UI・debug/配信前提をレビュー単位として分割する。旧形式の保護を目的にコードやリリースを分岐させない。

## Task 1: 正典 fixture と Swift 共有契約

**Files:** 新規 `app/ios/Shared/LiveActivity/{EarthquakeLiveActivityAttributes,UnifiedLiveActivityContentState,UnifiedShakeDetection,UnifiedEew,UnifiedEarthquake,UnifiedLiveActivityMagnitude,LiveActivityTimestamp}.swift`。新規 `app/ios/WidgetModelsTests/UnifiedLiveActivityContentStateTests.swift`。新規 `app/test/fixtures/live_activity/unified/{canonical,sha256}.json` と同ディレクトリの `README.md`。変更 `app/ios/Runner.xcodeproj/project.pbxproj`。

**Interfaces:** `EarthquakeLiveActivityAttributes.ContentState = UnifiedLiveActivityContentState`、`id: String`。`UnifiedLiveActivityPrimary: String, Codable`、`UnifiedShakeStatus`、`UnifiedLiveActivityInformationType` は対応するモデルファイルに置く。日時は `LiveActivityTimestamp: Codable, Hashable` の `value: Date` で保持する。

- [ ] 正典 JSON を無改変で canonical fixture に保存し、取得 SHA を README に記載する。sha256 fixture は `id` だけ64桁の16進文字列へ変更する。Xcode の Test Resources にこの同じディレクトリを folder reference で追加し、Dart と二重コピーしない。
- [ ] `JSONDecoder()` の既定設定で fixture を読めるテストを先に用意する。日時 helper は single-value の ISO 8601 文字列を decode / encode し、fractional seconds・Z・offset を受理する。ActivityKit 内部 decoder の dateDecodingStrategy を変更できる前提にしない。

```swift
struct EarthquakeLiveActivityAttributes: ActivityAttributes {
    typealias ContentState = UnifiedLiveActivityContentState
    let id: String
}
enum UnifiedLiveActivityMagnitude: Hashable {
    case normal(Double), unknown, overM8
}
// Codable は type/value によるカスタム実装。Swift の自動 enum JSON 形式を使わない。
```

- [ ] schema の全フィールドを写す。震度は既存 `IntensityValue`（`!5-` / `!6-` を含む）、長周期は既存 `LpgmIntensityValue` を再利用する。揺れレベル enum は既存定義を共有場所へ移し、SwiftUI 色拡張は新しい UnifiedLiveActivityStyle に集約する。重複 enum を追加しない。
- [ ] 必須 nullable は `decode(T?.self, forKey:)`、optional はキー不在を許可する。optional の非 null 型に明示 null が届く場合は不正として扱う。`eew.location.isPlum` は不在または true、serialNo は0以上の整数、数値は有限、ID は非空、primary のブロック存在を検証する。
- [ ] `schemaVersion != 2`、未知 enum、不正日時、primary 欠損を decode エラーにする。デバッグ UI は入力エラーを示し、数値やブロックを補完しない。一般ブロックの未知キーは既存 Codable 同様に無視し、strict な Attributes / Magnitude は正典どおり検証する。
- [ ] 共有モデルと必要な既存型を Runner / WidgetExtension / EQMonitorPreviewWidget / WidgetModelsTests の各対象へ一度ずつ登録する。旧 Runner 定義は Task 4 で削除する。旧型への変換は追加しない。
- [ ] 下記 Task 7 の Swift テストを実行し、canonical / SHA ID / 日時の round-trip と不正入力拒否を確認する。コミット例: `feat: 統合Live Activityの共有受信モデルを追加`。

## Task 2: 表示モデル・遷移・詳細リンク

**Files:** 新規 `app/ios/Shared/LiveActivity/{UnifiedLiveActivityPresentation,UnifiedEewPresentation,UnifiedEarthquakePresentation,UnifiedShakePresentation}.swift`、`app/ios/WidgetModelsTests/UnifiedLiveActivityPresentationTests.swift`。再利用 `app/ios/Shared/{EarthquakeDetailURL,LiveActivityDate}.swift`。Task 1 の揺れ enum 移設先は `app/ios/Shared/LiveActivity/ShakeDetectionLevel.swift`。新色拡張は `app/ios/Widget/LiveActivity/Unified/UnifiedLiveActivityStyle.swift`。

**Interfaces:** `UnifiedLiveActivityPresentation.init(state: UnifiedLiveActivityContentState)` は `primary: UnifiedLiveActivityPrimary`、`detailURL: URL?`、`shakePeak: UnifiedShakeDetection?` を公開。`UnifiedEewPresentation.init(state: UnifiedEew)` は `localIntensity: IntensityValue?`、`maximumIntensity: IntensityValue?`、`arrivalDate: Date?` を公開し、新wire型を直接受ける。Magnitude の `displayText: String` は normal / unknown / overM8 の表示を返し、nil は呼び出し側で非表示にする。

- [ ] `primary` をそのまま選択するテストを作る。3ブロックが存在しても `primary == .eew` の fixture なら EEW を表示し、独自の earthquake 優先への変更をしない。到達時刻の前後で primary が変わらないことも確認する。
- [ ] 表示モデルは新wire型を直接読み、受信した地域名・予想値・時刻・精度情報を加工する。日時を表示層でStringへ往復変換しない。`issuedAt` を `time` に代入しない。
- [ ] 予想震度は提供された0〜7を表示対象とし、旧UIの「予報では4以上のみ」という表示閾値を廃止する。取消時は該当EEWの予想値とカウントダウンを抑止する。地域PLUMでは到達予想を表示しない。通知条件・primaryは変更しない。
- [ ] 地震情報は地域の `location.maxIntensity` と全国の `maxIntensity` を区別し、EEW の予想震度を観測値として流用しない。IXAC41 だけの状態を観測情報と断定せず、種別に応じた「推計震度分布図」/「地震情報」の見出しを使う。Magnitude は normal → `M6.8`、unknown → `M不明`、overM8 → `M8以上の巨大地震`、null → 項目非表示。数値0を欠損にしない。
- [ ] 地震情報取消時は「先ほどの地震情報は取り消されました」とし、古い震度・震源・Mを有効な情報として見せない。別ブロックの取消だけで他ブロックの情報を隠さない。informationType は配列のまま保持し、単一 enum へ縮約しない。
- [ ] 揺れピークは snapshot の全体 `level` と地域 `location.level` を使用する。`ended` でも保持し、「検知終了・最大の揺れ」として区別する。enum から計測震度の数値を逆算しない。
- [ ] 詳細リンクは `state.earthquake?.eventId ?? state.eew?.eventId` を `EarthquakeDetailURL.make(eventId:)` に渡す。揺れのみは nil とし、UUID / backend id を地震詳細へ渡さない。EEW eventId に地震情報がまだ無い場合も既存詳細画面の読み込み・未取得表示を確認する。

```swift
@Test func magnitudeLabels() {
    #expect(UnifiedLiveActivityMagnitude.normal(6.8).displayText == "M6.8")
    #expect(UnifiedLiveActivityMagnitude.unknown.displayText == "M不明")
    #expect(UnifiedLiveActivityMagnitude.overM8.displayText == "M8以上の巨大地震")
}
```

- [ ] Task 7 の Swift tests で上記の選択・取消・null・リンクと、新表示モデルの全震度・取消・PLUMのテストと LiveActivityDateTests を通す。旧 EewDisplayTests は新判定テストに置き換える。コミット例: `feat: 統合Live Activityの主表示と地域情報を定義`。

## Task 3: Widget と Preview

**Files:** 新規 `app/ios/Widget/LiveActivity/Unified/{EarthquakeLiveActivityWidget,UnifiedLockScreenView,UnifiedDynamicIslandViews,UnifiedEarthquakeView,UnifiedShakeView,UnifiedShakePeakView}.swift`。変更 `app/ios/Widget/WidgetBundle.swift`、`app/ios/EQMonitorPreviewWidget/EQMonitorPreviewWidgetBundle.swift`、`app/ios/Runner.xcodeproj/project.pbxproj`。

**Interfaces:** `EarthquakeLiveActivityWidget: Widget`。`UnifiedLockScreenView(state:)`、`UnifiedEarthquakeView(state:)`、`UnifiedShakeView(state:)`、`UnifiedShakePeakView(state:)` はそれぞれ Task 1 の統合 / 地震 / 揺れ型を受ける。`UnifiedDynamicIslandViews.swift` に `UnifiedIslandLeadingView` / `UnifiedIslandTrailingView` / `UnifiedIslandBottomView` / `UnifiedCompactLeadingView` / `UnifiedCompactTrailingView` / `UnifiedMinimalView` を定義し、いずれも `state: UnifiedLiveActivityContentState` を受ける。

| 主表示 | Lock Screen / Expanded | Compact / Minimal |
| --- | --- | --- |
| 揺れ検知 | headline・地域名・地域ピーク・全体ピーク・検知時刻・active/ended | 地域ピークを優先し、地域欠損なら全体ピークを最大と区別して表示 |
| EEW | 新しい地域指標パネル＋予想震度/到達予想＋震源要約＋受信ソース要約 | 「予」付き地域震度＋到達予想、全国値は MAX を明示 |
| 地震情報 | headline・最大震度・地域名/地域震度・震源/M/深さ/時刻・揺れピーク補助行 | 地域震度を優先し、全国値には MAX。EEW予想と区別し、IXAC41単独を観測値と呼ばない |

- [ ] Live Activity の登録を新 Widget 1種類に置き換え、旧2種類を削除する。新 `ActivityConfiguration` の Lock Screen と Dynamic Island の双方へ `widgetURL` を設定する。揺れだけなら地震詳細 URL は設定しない。

```swift
ActivityConfiguration(for: EarthquakeLiveActivityAttributes.self) { context in
    UnifiedLockScreenView(state: context.state)
        .widgetURL(UnifiedLiveActivityPresentation(state: context.state).detailURL)
} dynamicIsland: { context in
    DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
            UnifiedIslandLeadingView(state: context.state)
        }
        DynamicIslandExpandedRegion(.trailing) {
            UnifiedIslandTrailingView(state: context.state)
        }
        DynamicIslandExpandedRegion(.bottom) {
            UnifiedIslandBottomView(state: context.state)
        }
    } compactLeading: {
        UnifiedCompactLeadingView(state: context.state)
    } compactTrailing: {
        UnifiedCompactTrailingView(state: context.state)
    } minimal: {
        UnifiedMinimalView(state: context.state)
    }
    .widgetURL(UnifiedLiveActivityPresentation(state: context.state).detailURL)
}
```

- [ ] レベル・震度・MAX は文字でも区別する。地点が null のとき「地点情報なし」、空の headline は見出し行を省略し、未提供の地域名を補わない。配信地域が任意設定地域の場合に GPS の現在地だと誤認させる文言を増やさない。
- [ ] 情報を全量縦積みせず、主表示＋揺れピーク1行に絞る。Expanded は新レイアウトの標準/省スペース候補を `ViewThatFits` で選び、主情報を残す。終了済みピークは Lock Screen の補助行に必ず残し、狭い Island の全量表示は要求しない。
- [ ] Preview に揺れ単独、EEW単独、地震情報単独のsnapshot、全ブロック、地域欠損、取消、深発、PLUM、Magnitude4形態を追加する。初回 Start が地震情報を主表示する状態でも描画できるようにする。
- [ ] 同一 Activity の揺れ→レベル上昇→EEW→地震情報を Preview の連続状態で確認する。日時は Preview に注入した `now` から作る。受信データの不足を実装側の `Date()` で補わない。
- [ ] 旧 `app/ios/Widget/LiveActivity/Eew/` と `ShakeDetection/`、`EQMonitorLiveActivityWidget.swift`、旧専用 `Common/LocationInfo.swift` を削除する。`Common/SharedComponents.swift` の汎用日時表示だけ必要に応じて新UIに独立移設し、旧見た目の部品は削除する。
- [ ] 旧 `app/ios/Shared/EewDisplay.swift` と `app/ios/WidgetModelsTests/EewDisplayTests.swift` を新表示モデル/テストへ置換する。旧Preview、target membership、参照を削除する。通常WidgetやFlutterの地震情報画面は削除対象にしない。
- [ ] 新規 `UnifiedLiveActivityStyle.swift` と `UnifiedEewView.swift` に新デザインのtokensとEEW専用Viewを実装する。[新デザイン仕様](../specs/2026-09-12-unified-live-activity-ios-design.md)の指標、地域/全国の区別、ソース要約、Compact/Minimalを満たす。
- [ ] Preview target の membershipExceptions に新 Widget 配下ファイルを追加する。新 Shared ファイルの各 target の Sources も確認する。
- [ ] Task 7 の Widget / Runner / Preview build と Canvas 確認を行う。Light / Dark、長い地名・headline、Dynamic Type、VoiceOver、カメラ脇の切り取りを検証する。コミット例: `feat: 統合Live Activityをロック画面とIslandに表示`。

## Task 4: Runner ローカルデバッグと一覧

**Files:** 変更 `app/ios/Runner/LiveActivityDebugMethodChannel.swift`。新規 `app/ios/Runner/LiveActivityDebug/UnifiedLiveActivityDebugHandler.swift`、`app/ios/WidgetModelsTests/UnifiedLiveActivityDebugContractTests.swift`。target 登録は `app/ios/Runner.xcodeproj/project.pbxproj`。

**Interfaces:** MethodChannel は統合専用にし、kind 引数を廃止する。Start は `{attributes: {id}, contentState: JSON文字列}`、Update / End は `{activityId, contentState: JSON文字列?}`、list は引数なし。Start は `{activityId, logicalId, eventId?}`、list はその配列を返す。

- [ ] 旧2種類のswitch分岐、旧Attributes/ContentState/DebugLiveActivityLocationInfo、旧staleDate処理を削除する。Startは共有型でdecodeし、Attributesとstateのid一致を確認する。
- [ ] 統合 handler は `Activity<EarthquakeLiveActivityAttributes>.request` を `pushType: nil`、`staleDate: nil` でローカル実行する。これは画面検証用で、Broadcast 購読済みの証拠にしない。
- [ ] Update はOSのactivityIdで選択し、state.idと静的idが異なる場合は `identity_mismatch`、対象不在は `activity_not_found`。旧形式を受けるfallbackは設けない。
- [ ] Endは任意の最終snapshotをdecodeして `.immediate` で終了する。未指定なら現stateを利用する。`isFinal` / `isCanceled` による自動Endを実装しない。
- [ ] listは `Activity<EarthquakeLiveActivityAttributes>.activities` だけを列挙する。logicalIdはattributes.id、eventIdはearthquake/eewの実値。OS IDと混同しない。
- [ ] Start/Update/Endの引数decode・ID不一致・統合型だけの列挙をテストする。旧kind/eventIdだけのStartが通らないことも確認する。Runner buildを通す。コミット例: `feat: ローカルLive Activity操作を統合形式へ置換`。

## Task 5: Dart の型・preset・JSON編集・セッション復元

**Files:** 新規 `app/lib/feature/live_activity/data/model/{unified_live_activity_content_state,unified_shake_detection,unified_eew,unified_earthquake,unified_live_activity_json_converter}.dart` と生成物。既存 debug ディレクトリは `app/lib/feature/settings/children/config/debug/live_activity/`。その配下の `data/model/debug_live_activity_{preset,session}.dart`、`data/controller/live_activity_local_controller.dart`、`data/repository/debug_live_activity_{content_builder,json_codec}.dart`、`ui/action/debug_live_activity_action.dart`、`ui/page/debug_live_activity_page.dart` を変更。削除 `data/model/debug_live_activity_kind.dart`。テストは同構造の `app/test/feature/settings/children/config/debug/live_activity/` と `app/test/feature/live_activity/unified_live_activity_contract_test.dart`。

**Interfaces:** `UnifiedLiveActivityContentState.fromJson(Map<String, dynamic>)` / `toJson()`。`DebugLiveActivityContentBuilder.unifiedFromPreset({required DebugUnifiedPreset preset, required String id, required DateTime now}) -> UnifiedLiveActivityContentState`。`DebugLiveActivityJsonCodec.parse(String raw) -> Result<UnifiedLiveActivityContentState, FormatException>`。Controllerは `start({required UnifiedLiveActivityContentState state}) -> Future<DebugLiveActivitySession>`、`update({required String activityId, required UnifiedLiveActivityContentState state}) -> Future<void>`、`end({required String activityId, UnifiedLiveActivityContentState? state}) -> Future<void>`、`list() -> Future<List<DebugLiveActivitySession>>` を公開する。

- [ ] Freezed の統合 DTO に `DateTime` と enum を用い、ブロック型は Swift と同じ分割にする。`EarthquakeMagnitude` は既存 `app/lib/feature/earthquake_history/data/model/earthquake_magnitude.dart` を再利用し、union を複製しない。
- [ ] `UnifiedLiveActivityJsonConverter` で wire の `{type: NORMAL, value}` / UNKNOWN / OVER_M8 を既存 EarthquakeMagnitude へ相互変換する。既存 Freezed の `runtimeType` JSON を wire へ直接出さない。normal の value 不在・非有限・不正 type は FormatException。
- [ ] JmaIntensity / JmaLpgmIntensity / ShakeDetectionLevel も既存 enum を使い、明示 converter で wire 値へ変換する。`!5-` / `!6-` はラベルの「5」「6」に潰さない。enum の `.name` を JSON に直接使わない。
- [ ] 必須 nullable はキーを保持して null を出力する。`eew.location` 内の optional は `includeIfNull: false` で省略する。schemaVersion・primary・日時・ID・enum の検証は Swift と同じ fixture で確認する。破棄したフィールドを直前の snapshot から復元しない。

```dart
test('正典をdecodeしてwire形式に戻せる', () {
  final raw = jsonDecode(File('test/fixtures/live_activity/unified/canonical.json')
      .readAsStringSync()) as Map<String, dynamic>;
  final state = UnifiedLiveActivityContentState.fromJson(raw);
  expect(state.id, raw['id']);
  expect(state.primary, UnifiedLiveActivityPrimary.earthquake);
  expect(state.earthquake?.magnitude, const EarthquakeMagnitude.value(value: 6.8));
  expect(state.toJson()['schemaVersion'], 2);
  expect(state.toJson().containsKey('runtimeType'), isFalse);
});
```

- [ ] `DebugLiveActivityKind`、`DebugEewPreset`、`DebugShakePreset`、旧形式builderを削除する。`DebugUnifiedPreset` は shake / shakeEscalated / shakeEnded / eew / earthquake / allBlocks / canceledEew / canceledEarthquake / magnitudeUnknown / magnitudeOverM8 / noLocation を用意する。明示されたデバッグ fixture のみ固定値を使う。
- [ ] Controllerは型付きstateだけを受け、MethodChannel境界でTask 4のJSONへencodeする。全呼び出し元とmockを新しい引数へ変更する。kind、静的eventId、旧Mapを受けるoverloadは削除する。
- [ ] Sessionは `activityId: String`、`logicalId: String`、`eventId: String?` を保持。Start後・画面復帰時・Update/End後にlistを読み、OS IDで選択を復元する。必ず統合形式のlogicalIdを持つ。
- [ ] JSON編集の不正値は `primary に対応する情報がありません`、`id が開始時と一致しません` など短い日本語で表示する。生の Swift 例外や巨大 JSON を SnackBar に出さない。未成功の編集内容と選択 Activity を保持する。
- [ ] preset の切り替えは選択中 Activity の backend id を保持する。別 Activity の作成は明示的な新規開始とする。Start が地震情報主表示の snapshot でも動くよう、揺れからの手順を必須にしない。
- [ ] MethodChannel mockで統合Startの引数、Update/EndのOS ID、list復元、JSON不正時にnativeを呼ばないことを検証する。画面のシナリオ切り替え・入力保持・session選択はWidget testを追加し、旧種別のUIテストは置換する。
- [ ] `mise exec -- dart run build_runner build --delete-conflicting-outputs` を app で実行し、対象 Dart tests と analyze を通す。コミット例: `feat: 統合Live Activityのデバッグシナリオを追加`。

## Task 6: トークン・APNs 環境・OS 対応範囲の前提整備

**Files:** 確認/修正 `packages/live_activity_util/ios/live_activity_util/Sources/live_activity_util/EQMLiveActivityUtil.swift`。変更/追加テスト `app/test/feature/live_activity/live_activity_token_contract_test.dart`、`app/test/feature/devices/{push_token_platform_capabilities,notification_token_stream,device_repository_apns_environment,push_token_sync_worker}_test.dart`。必要な検証用入口は新規 `app/integration_test/unified_live_activity_apns_test.dart`。純粋な OS 判定テストは新規 `app/ios/WidgetModelsTests/LiveActivityPlatformSupportTests.swift`。

**Interfaces:** public な push-to-start token API と `NotificationToken` は維持する。`apnsEnvironmentProvider` の実機テスト用 override は `api.ApnsEnvironment.development` または `.production` を署名結果に合わせて選ぶ。

- [ ] 現在の `isLiveActivitySupported()` の2番目の guard は iOS 26.1 未満で false を返す。Dart の18以上という配信対応範囲と整合させ、Mac / Vision 除外を availability で個別判定する。ローカル Activity の16.1以上と Broadcast 配信の18以上を区別する。

```swift
if ProcessInfo.processInfo.isiOSAppOnMac { return false }
if #available(iOS 26.1, *), ProcessInfo.processInfo.isiOSAppOnVision {
    return false
}
// 上記は既存 iOS 16.1 availability 内。iOS 26.1 未満を一律除外しない。
return true
```

- [ ] 対応判定の入力を OS version / isMac / isVision として同じ Swift ソース内の純粋 policy に分け、17.6 / 18 / 26.0 / 26.1 と Mac / Vision をテストする。policy はこのファイルに置き、1ファイルをコンパイルする現 native hook の入力を不用意に変えない。FFI生成物・XCFrameworkは通常の `mise exec -- flutter build ios --simulator --debug --no-codesign` による hook で再生成し、生成差分をレビューする。
- [ ] push-to-start の初回取得・更新・再登録・失敗後再試行を既存 tests で確認する。個別 Activity の token observer を追加しない。最低対応 OS と実機で token 取得を確認するまで、ソース判定の修正だけを配信成功としない。
- [ ] 現在の production 固定はリポジトリの Runner.entitlements と既存運用に一致するため、dev flavor を理由に development へ変更しない。sandbox 用の署名済み検証ビルドだけ、integration test の ProviderScope で `apnsEnvironmentProvider.overrideWith((ref) => api.ApnsEnvironment.development)` を注入する。通常リリースの provider は現行の production を維持する。
- [ ] 両環境で最終署名を `codesign -d --entitlements :- /absolute/path/to/Runner.app` で確認し、`aps-environment` と登録 request の環境が一致することを記録する。integration test 入口は既存起動処理の依存初期化を使い、mock token は使わない。トークン全文をログ・文書へ残さない。
- [ ] [Apple の APNs entitlement 仕様](https://developer.apple.com/documentation/bundleresources/entitlements/aps-environment)と[ActivityKit 配信仕様](https://developer.apple.com/documentation/ActivityKit/starting-and-updating-live-activities-with-activitykit-push-notifications)に照らし、Broadcast capability・bundle ID・環境を実機試験前に確認する。確認結果は knowledge、解消前の差分は todo に残す。
- [ ] 通知設定/位置同期の送信地域が AreaForecastLocalE の3桁コードであることをテスト payload と backend 登録結果で確認する。都道府県コードや観測点 ID を新しい実装から追加送信しない。コミット例: `fix: Live ActivityのOS対応判定を配信条件に揃える`。

## Task 7: 新契約・新デザイン・実機配信の受け入れ

**Files:** Task 1 / 2 / 4 / 5 / 6 のテスト。新規 `app/test/fixtures/live_activity/unified/matrix.json`、`docs/knowledge/20260912_unified_live_activity_ios_contract.md`。実機結果は実施日の `docs/knowledge/{YYYYMMDD}_unified_live_activity_acceptance.md`。継続課題は `docs/todo/850_unified_live_activity_activation_prerequisites.md`。

**Interfaces:** fixture matrix は `{name, attributes, contentState, valid}` の配列。Swift と Dart の両方が同じファイルを読む。valid の期待値は下表の条件を使い、decoder 実装から生成しない。

| 分類 | 入力ケース | 合格条件 |
| --- | --- | --- |
| 基本契約 | canonical、SHA-256 ID、任意の非空 opaque ID | 既定 Swift decoder と Dart が成功。UUID必須にしない |
| 存在組合せ | 3ブロックの非空7組合せ、存在する各 primary（計12ケース） | 指定された主表示。全null / 指定ブロックnullは失敗 |
| 必須性 | 各 required-nullable に null / キー省略、各 optional の省略 | nullを維持、必須キー不在を拒否、optional不在は成功 |
| 地域 | location null、地域名のみのEEW、optional全項目、`isPlum: true` | 推測なし。`isPlum: false` / optional非null型へのnullは失敗 |
| 列挙・数値 | 全12震度、長周期0〜4、揺れ5段階、serialNo 0 / -1 / 小数 | 正典範囲だけ成功。`!5-` / `!6-` を保持 |
| 地震情報 | Magnitude4形態、数値0、informationType複数/空配列 | unknownとnullを区別。配列をそのまま保持 |
| 不正契約 | schemaVersion違い、空ID、不正日付、未知enum、NORMALのvalue欠落 | decode失敗。デバッグでは短い説明、native操作なし |
| 日時 | Z、+09:00、fractional、到達前/後/ちょうど | 同じ時刻を保持、負のrangeや独自主表示切替なし |
| 遷移 | 揺れ→上昇→ended→EEW→最終→地震情報→End | OS activityId維持、ピーク残存、Endまで自動終了しない |
| 取消 | EEW取消に古い予想値、地震情報取消に古い観測値 | 該当ブロックの値を有効表示しない。ActivityはEnd待ち |
| 完全snapshot | 前状態にあるlocationが次でnull、ブロックが次でnull | 前状態を独自マージして残さない |
| ID | backend IDとOS IDが別、誤ったID/種別、揺れ単独のリンク | 正しい対象のみ操作、架空の地震詳細へ遷移しない |
| 全面置換 | 新Widget登録・新debug契約・旧コード参照の検索 | Live Activityの登録は新型1種類、旧型/互換adapter/旧kind分岐への参照なし |

- [ ] Swift / Dart 契約テストを先に実行して不足機能による失敗を確認し、各 Task 実装後に再実行する。新規表示のみの細部には機械的なテスト追加をせず、契約・表示判定・遷移・通知条件の回帰を自動化する。
- [ ] 以下を実行する。Swift tests は既存 scheme 全体、新規モデル・新表示判定・日時/URLの回帰を含む。`SIMULATOR_UDID` は `xcrun simctl list devices available` で存在を確認した値を設定する。Xcode は現在のアプリが必要とする iOS 27 SDK を使う。

```sh
# app ディレクトリ
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test test/feature/live_activity test/feature/settings/children/config/debug/live_activity test/feature/devices
mise exec -- flutter analyze
# repository root
xcodebuild -version
xcrun --sdk iphoneos --show-sdk-version
xcrun simctl list devices available
xcodebuild test -project app/ios/Runner.xcodeproj -scheme WidgetModelsTests -destination "platform=iOS Simulator,id=$SIMULATOR_UDID" CODE_SIGNING_ALLOWED=NO
xcodebuild build -project app/ios/Runner.xcodeproj -scheme EQMonitorPreview -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO
xcodebuild build -project app/ios/Runner.xcodeproj -scheme Runner -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO
git --no-pager diff --check
```

- [ ] package 解決・Flutter設定生成は既存手順で事前に完了させる。`WidgetModelsTests` を実行しない PR Flutter CI の green だけを Swift の検証としない。build / test のコマンド、SDK、結果をアプリPRに記録する。
- [ ] ローカルデバッグで Task 3 の全表示形態と Task 4 の Start→複数Update→End→list消失を確認する。アプリ再起動後の list 復元と、手動dismiss後の対象不在も確認する。
- [ ] backend の隔離された試験環境とテスト端末で、APNs sandbox / production それぞれ実 token に Start→Broadcast Update→End を送る。production APNs の検証を全利用者への本番切り替えと混同しない。テスト宛先は試験用登録端末に限定する。
- [ ] 揺れ上昇またはEEW続報で初めて通知条件を満たす端末に、完全snapshotでStartが表示されることを確認する。アプリ側で開始条件を再判定しない。地震情報単独でbackendが新規Eventを開始しない点と、受信開始時にearthquake主表示であることは別。
- [ ] 別EEW同時発生、複数揺れの結合、終了対象の統合ActivityへのEndと存続先Startの前後両順序、終了対象側だけに参加した端末を検証する。独自のID書換え・重複排除・他Activity強制終了をせず、最終的に存続先が更新されることを確認する。
- [ ] token更新・再登録、通知/Live Activity無効、アプリ非起動・画面ロック状態、OSの古い/新しい対応版、Dynamic Island有無を検証する。記録には app build / OS / 署名環境 / backend image・設定 / 入力シナリオ / APNs応答 / 端末上の結果を分けて残す。

## 配信検証とリリース

1. 新形式の Task 1–6 と自動検証を完了し、`develop` 向けPRをレビューする。Live Activityは新型1種類を含むarchiveを検証する。
2. backendの固定schemaと実配信バージョンが一致することを確認する。調査時に失敗していたCIは最新結果を再確認し、image公開・配備・実機受信をそれぞれ記録する。
3. 新アプリでTask 7のsandbox / production APNs受信を確認する。地域・署名環境・resolver/Sender prefix・Broadcast設定を検証する。
4. 統合形式を本番で有効化する際は、その配備・配信結果を記録する。旧アプリの普及率待ち、旧Activityの収束待ち、旧形式への復帰手順、migration作業は今回の計画に含めない。

## 完了の定義

- 実装完了: 新契約の全ケース、新デザイン、Dart debug、旧実装削除、Runner/Widget/Preview buildが成功し、Canvas/ローカル操作の結果が記録されている。
- 配信検証完了: sandbox / productionの実tokenとBroadcastによるStart→Update→End、途中参加・同時発生・統合Event間の結合・再登録が実機で成功している。
- デザイン完了: Lock Screen / Expanded / Compact / Minimalとdebug画面が新仕様に揃い、Light/Dark・長文・文字拡大・欠損・取消・全Magnitude形態を確認している。
- 受け入れ条件の根拠: Issue #1800のwire/primary/ピーク/終了制御/配信条件を維持し、旧互換・移行・旧UI継承に関する条件は2026-09-12のユーザー指示で置き換える。
