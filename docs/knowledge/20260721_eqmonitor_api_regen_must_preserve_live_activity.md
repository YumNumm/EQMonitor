# eqmonitor_api 再生成で Live Activity 契約が消える問題

## 事象

`develop` の Deploy App（Android）が次のコンパイルエラーで失敗した。

- `LiveActivityStartTrigger` / `LiveActivityContentState` / `Alert` が見つからない
- `DeviceApiClient.postV2DeviceMeLiveActivityTest*` が定義されていない

原因は、揺れ検知 snapshot（`/v2/shake-detection/active`）導入時の OpenAPI 再生成で、既存の Live Activity 関連生成物が消えたこと。

## 背景

- `packages/eqmonitor_api` は `backend/api/api/openapi.json` から `dart run bin/generate.dart` で全消し再生成する
- backend submodule 側の不良マージで `live-activity` / `live-activity/test` が OpenAPI・実装から欠落していた
- その状態でクライアントを再生成すると、アプリ側のデバッグ Live Activity 画面がコンパイル不能になる
- swagger_parser は別名スキーマを別ファイルに出すが、同名・衝突しやすい短い名前（例: `Event` ↔ `ChangeReasons`、`LiveActivityStartTrigger` ↔ `Level`）が上書き・欠落しやすい

## 対処（今回）

- 直前の健全コミットから Live Activity 関連モデルと `DeviceApiClient` メソッドを復元
- 揺れ検知用 `ShakeDetectionApiClient` は維持
- `Event`（update/end）と `LiveActivityStartTrigger` は揺れ検知用の `ChangeReasons` / `Level` と別ファイルとして共存させる

## 再発防止

OpenAPI / `eqmonitor_api` を再生成したら、最低限次を確認する。

```bash
rg -n "live-activity/test|shake-detection/active" backend/api/api/openapi.json
rg -n "postV2DeviceMeLiveActivityTest|getV2ShakeDetectionActive|LiveActivityStartTrigger" \
  packages/eqmonitor_api/lib/src
cd app && mise exec -- dart analyze lib/feature/settings/children/config/debug/live_activity
```

両方の契約が OpenAPI と生成クライアントに残っていることを確認してからコミットする。

## 関連 TODO

backend 側で欠落した Live Activity ルートの復元は別途対応（`docs/todo/` 参照）。
