---
alwaysApply: false
globs: app/lib/feature/settings/children/config/debug/live_activity/**,app/ios/Runner/LiveActivityDebugMethodChannel.swift
---

# 統合 Live Activity のローカルデバッグ

設定のデバッグ画面から、統合 `EarthquakeLiveActivityAttributes` を ActivityKit で
ローカル開始・更新・終了できる。Push-to-Start とは別経路であり、端末上の表示確認に使う。

## ID を区別する

- `logicalId`: backend が管理する不透明な Live Activity ID。ContentState の `id` と同一。
- `activityId`: `Activity.id` として iOS が払い出す OS 側 ID。
- `eventId`: EEW / 地震情報のイベント ID。揺れ検知だけの snapshot には存在しない。

更新中はプリセットを切り替えても `logicalId` を維持する。新しい系列を明示的に作るとき
だけ debug 用 ID を払い出す。実行中一覧は ActivityKit を正とし、Preferences へ保存しない。

## MethodChannel 契約

channel は `net.yumnumm.eqmonitor/live_activity_debug`。

- `isSupported()` → `bool`
- `start({attributes: {id}, contentState: JSON文字列})`
  → `{activityId, logicalId, eventId?}`
- `update({activityId, contentState: JSON文字列})` → `void`
- `end({activityId, contentState?: JSON文字列})` → `void`
- `list()` → `[{activityId, logicalId, eventId?}]`

`kind` と top-level `eventId` は送らない。start / update は毎回完全な unified snapshot を
渡し、部分更新として merge しない。最終報・取消・揺れ検知 ended は update 用 snapshot
であり、それ自体を ActivityKit の end 操作へ変換しない。

Dart の MethodChannel が受け取る map は StandardMessageCodec 上
`Map<Object?, Object?>` になることがある。`Map<String, dynamic>` へ直接 generic cast
せず、一度 JSON として正規化してから typed session を検証する。

## JSON 境界

編集欄の JSON は `UnifiedLiveActivityContentState.fromJson` で検証してから native へ渡す。
直接 constructor で作った DTO も同じ境界で再検証する。required nullable のキーは null
でも省略せず、EEW location の optional non-null キーは値がない場合に省略する。

日時は Z / offset / 小数秒を含む ISO 8601 を受け付ける。Dart の `DateTime.parse` が
存在しない暦日を繰り上げるため、日付要素を検証してから parse する。秒の小数部は任意桁を
受け付けるが、Dart の `DateTime` と再エンコードではマイクロ秒精度まで保持される。

## 対応 OS と確認

ローカル開始は iOS 16.1 以上、Push-to-Start token は iOS 18 以上で別判定する。
モデル・MethodChannel の Dart 検証は次を使う。

```sh
cd app
mise exec -- flutter test --no-pub test/feature/live_activity/unified_live_activity_contract_test.dart test/feature/settings/children/config/debug/live_activity
mise exec -- flutter analyze --no-pub lib/feature/live_activity/data/model lib/feature/settings/children/config/debug/live_activity test/feature/live_activity/unified_live_activity_contract_test.dart test/feature/settings/children/config/debug/live_activity
```

Dart テストと解析は、iOS build・Simulator 表示・実機 Live Activity 表示の証明とは分けて
記録する。
