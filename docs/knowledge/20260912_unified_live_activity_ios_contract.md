# 統合 Live Activity の iOS 契約と移行規則

- 正典は backend `00f2caf9ffef0861f0b9a52cca675593d9c60409` の `packages/notification-common/src/types/unified-live-activity-content-state.ts`。対応 Issue は [#1800](https://github.com/YumNumm/EQMonitor/issues/1800)。
- `EarthquakeLiveActivityAttributes` の静的属性は非空の `id: String` だけ。64桁の SHA-256 を受け、UUID型にしない。
- static id と ContentState.id は存続 Lease のID。OSの Activity.id、EEW/地震情報の eventId、backend 内部の canonical ID を混同しない。
- `primary` に従って完全 snapshot を表示する。到達時刻で主表示を変えず、最終報・取消で独自 End を送らない。
- 揺れは地域/全体のピークを受け、ended でも保持する。enum level から数値の計測震度を捏造しない。
- 地震情報の Magnitude は NORMAL / UNKNOWN / OVER_M8 / null。Dart の既存 EarthquakeMagnitude は再利用できるが、自動生成の runtimeType JSON はこの wire 契約と異なるため converter が必要。
- Date の wire 値は ISO 8601。ActivityKit の既定 decoder で処理できる Codable を使い、Runner の JSONDecoder 設定変更だけで解決したとしない。
- 旧2種類の ActivityAttributes と Widget 登録は、切り替え前 Activity の Update / End を受けるため維持する。
- APNs environment は署名後の entitlement と一致させる。dev flavor と sandbox は同義ではない。現在の provider / entitlements は production。
- `EQMLiveActivityUtil.isLiveActivitySupported()` の iOS 26.1 guard と Dart の18以上判定に差がある。解消状況は [前提条件](../todo/850_unified_live_activity_activation_prerequisites.md)で追跡する。
- 新しい Swift ファイルは Runner / Widget / Preview / Test の target membership を確認する。PR Flutter CI の成功だけでは Swift のビルド・モデルテスト完了にならない。
- backend の retention は終了済みデータの保存圧縮であり、クライアント向け圧縮 payload の導入ではない。
- #1203 は2026-09-12にマージ済み。Release PR #1202は調査時 OPEN。CI / 配備 / APNs応答 / 実機表示は別々に確認する。

確認コマンド:

```sh
gh pr view 1203 --repo YumNumm/eqmonitor-backend --json state,mergedAt,statusCheckRollup
gh pr view 1202 --repo YumNumm/eqmonitor-backend --json state,headRefOid
codesign -d --entitlements :- /absolute/path/to/Runner.app
```

詳細な変更対象・テスト・切り替え条件は [実装計画](../superpowers/plans/2026-09-12-unified-live-activity-ios.md)に記載。これは契約調査の記録であり、実装・配信済みの記録ではない。
