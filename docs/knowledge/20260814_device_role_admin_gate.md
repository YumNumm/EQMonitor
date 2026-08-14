# デバイスの Admin ロール判定と、デバッグ機能のゲート方法

**作成日**: 2026-08-14

## 結論

アプリから「このデバイスは Admin か」を判定する経路は、現状 **存在しない**。
Admin 限定のデバッグ機能を追加する場合は、判定が取れないケースを
「権限なし」として扱い、UI に理由を表示する前提で設計する。

## backend の認証・権限の構造

| 認証方式 | 使う場所 | role を取れるか |
| --- | --- | --- |
| デバイス JWT（`POST /v2/device` 発行、HS256） | `/v2/device/me/*`、`/v2/subscription/*` | 取れない（クレームに role なし） |
| better-auth セッション / JWT | `/v2/user/me*`、`/v2/admin/*`、`/v2/feeds/admin` | 取れる（`user.role === 'admin'`） |

- ロールは better-auth の `admin()` プラグインが持つ `user.role`。
- `GET /v2/device/me`（`DeviceMeResponse`）は `role` を返さない。
- アプリにはアカウントログインが無く、better-auth セッションを保持していない。
  そのため `/v2/user/me` は 401 になる。

## 実装上の指針

- ロール取得は `DeviceRepository.getDeviceRole()`（`GET /v2/device/me`）に集約する。
  backend が `role` を返し始めたら、生 JSON 読み取りから生成モデル経由へ移す。
- 未提供・未知の値・通信失敗はすべて `null`（= 非 Admin）として扱う。
  生命に関わる情報を扱うアプリなので、権限を推測するフォールバックは書かない。
- ゲートは「設定値」と「操作できるか」を別 provider に分ける。
  - `isHomeEewEstimationDebugAvailableProvider`: Admin かつデバッグモード有効
  - `isHomeEewEstimationVisibleProvider`: 上記 かつ 設定が ON
  - こうすると、権限を失ったときに保存済み設定が残っていても表示されない。
- デバッグ画面のトグルは `onChanged: null` で非活性にし、
  サブタイトルに「デバッグモード無効」「ロール取得中」「Admin 以外」などの理由を出す。

## 残課題

`docs/todo/300_device_role_api_field.md` に backend 側の対応内容を記載した。
