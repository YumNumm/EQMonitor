# 統合 Live Activity iOS Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** EEW・揺れ検知・地震情報の完全 snapshot を一つの Live Activity で表示し、旧形式を維持しながら全端末切り替えを可能にする。
**Architecture:** 新契約の Codable モデルは Runner / Widget / Preview / Tests で共有する。表示は受信した `primary` に従い、EEW の既存表示規則を再利用する。Activity の開始・結合・終了判断は backend に置く。
**Tech Stack:** Swift / ActivityKit / WidgetKit / SwiftUI、Flutter / Dart / Riverpod、既存 MethodChannel、XCTest / flutter_test。
**Spec:** [EQMonitor Issue #1800](https://github.com/YumNumm/EQMonitor/issues/1800)、以下の固定 revision の schema と検証仕様。

## Global Constraints

- `attributes-type` は `EarthquakeLiveActivityAttributes`、静的 Attributes は `{id: string}` のみ。ID を UUID に変換しない。
- `schemaVersion: 2`。Start / Update は完全 snapshot。各ブロックと location の null、nullable と optional の差を維持する。
- `primary` は `shake_detection` / `eew` / `earthquake`。指定ブロック必須。クライアントで優先順位や通知条件を再計算しない。
- 最終報・取消・到達時刻を Activity 終了とみなさない。120 / 180 / 300 秒の独立終了タイマーを実装しない。
- 旧 EEW / 揺れ検知の型名・Widget 登録・Update / End を移行期間中は維持する。
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

PR #1203 は確認時点で Go Build / Format が失敗し、他の CI は実行中だった。PR 記載のローカル成功件数を全 CI 成功とは扱わない。migration 適用済みは backend の記録によるもので、この調査では DB・稼働サービス・APNs 配信を再検証していない。Helm 既定値は有効化 `false`、retention `null`。この retention は終了済みデータの保存処理であり、iOS の受信圧縮 codec を追加する意味ではない。

## 方針の比較と採用案

1. **共有 wire モデル＋新 Widget＋既存 EEW 表示への adapter（採用）**: 新形式の定義ずれを防ぎ、既存の表示・旧 Activity を保護できる。
2. Runner / Widget に新モデルをそれぞれ複製: 変更量は少ないが、現在すでにある必須性や location フィールドの不一致を増やす。
3. 旧モデルを全面的に統合型へ置換: 移行前 Activity の decode / 更新を壊すため採用しない。

## 現状との差分と作業順序

| 現状 | 必要な変更 | Task |
| --- | --- | --- |
| 旧 Attributes は UUID と静的 eventId | String id の新共有型・3ブロックを追加 | 1 |
| 表示は EEW / 揺れ検知の2系統 | `primary` 選択・地震情報・終了済みピーク表示 | 2–3 |
| Runner の新規開始は eventId 必須 | 新形式の id と OS activityId を分離、一覧復元 | 4 |
| Dart は2種別・無型 JSON の生成中心 | 統合 DTO / preset / codec / session を追加 | 5 |
| APNs environment は production 固定 | sandbox 検証用の署名一致設定を用意 | 6 |
| Swift は iOS 26.1 未満を除外、Dart は18以上 | 対応判定を揃える前提修正と境界テスト | 6 |
| PR Flutter CI に WidgetModelsTests がない | Swift の検証を明示して実機受け入れへ進む | 7 |

依存順は `1 → 2 → 3 → 4 → 5 → 7`。Task 6 は端末配信検証の前提として Task 7 より前に完了する。モデル・UI・debug/配信前提をレビュー単位として分割できるが、新型 Widget を含むアプリが利用可能になるまで本番有効化しない。

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

- [ ] schema の全フィールドを写す。震度は既存 `IntensityValue`（`!5-` / `!6-` を含む）、長周期は既存 `LpgmIntensityValue` を再利用する。揺れレベル enum は既存定義を共有場所へ移し、SwiftUI 色拡張は Widget 側に残す。重複 enum を追加しない。
- [ ] 必須 nullable は `decode(T?.self, forKey:)`、optional はキー不在を許可する。optional の非 null 型に明示 null が届く場合は不正として扱う。`eew.location.isPlum` は不在または true、serialNo は0以上の整数、数値は有限、ID は非空、primary のブロック存在を検証する。
- [ ] `schemaVersion != 2`、未知 enum、不正日時、primary 欠損を decode エラーにする。デバッグ UI は入力エラーを示し、数値やブロックを補完しない。一般ブロックの未知キーは既存 Codable 同様に無視し、strict な Attributes / Magnitude は正典どおり検証する。
- [ ] 共有モデルと必要な既存型を Runner / WidgetExtension / EQMonitorPreviewWidget / WidgetModelsTests の各対象へ一度ずつ登録する。旧 Runner 定義はこの時点では変更しない。
- [ ] 下記 Task 7 の Swift テストを実行し、canonical / SHA ID / 日時の round-trip と不正入力拒否を確認する。コミット例: `feat: 統合Live Activityの共有受信モデルを追加`。
