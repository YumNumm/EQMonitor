# デバイスの Admin ロール判定と、デバッグ機能のゲート方法

**作成日**: 2026-08-14
**更新日**: 2026-08-18（backend が `role` を返すようになったため改訂）

## 結論

`GET /v2/device/me` が `role`（`ADMIN` / `USER`）を返す。
Admin 限定のデバッグ機能は、判定が取れないケースを「権限なし」として扱い、
UI に理由を表示する前提で設計する。

## backend の権限の構造

ロールは 2 系統あり、**別物**として扱う。

| 系統 | 取得経路 | 判定に使う場所 |
| --- | --- | --- |
| デバイスのロール | `GET /v2/device/me` の `role`（デバイス JWT で取得） | アプリ内の Admin 限定 UI のゲート |
| ユーザーのロール | better-auth の `user.role`（Cookie セッション / better-auth JWT） | backend 側の管理者認可（`/v2/admin/*`、`/v2/feeds/admin` 等） |

- デバイスのロールは backend の環境変数 `ADMIN_DEVICE_IDS`（デバイス ID の
  カンマ区切り）による許可リストで決まる。列挙されたデバイスのみ `ADMIN`、
  それ以外は `USER`。未設定なら全デバイスが `USER`。
- **`role: ADMIN` は認可の根拠にならない。** デバイス JWT は `POST /v2/device` で
  匿名の誰でも取得できるため、backend 側の管理者認可は従来どおり
  better-auth セッションの `user.role === 'admin'` で行う。
  デバイスの `role` は「クライアントに開発者向け UI を出してよいか」を
  伝えるためだけに使う。
- アプリにはアカウントログインが無く better-auth セッションを保持していないため、
  `/v2/user/me` からユーザーのロールを取ることはできない。

## 実装上の指針

- ロール取得は `DeviceRepository.getDeviceRole()`（`GET /v2/device/me`）に集約し、
  生成モデル `DeviceMeResponse.role` から読む。
- デバイス未登録・通信失敗・未知の値（生成 enum のデコード失敗）はすべて
  `null`（= 非 Admin）として扱う。
  生命に関わる情報を扱うアプリなので、権限を推測するフォールバックは書かない。
- ゲートは「設定値」と「操作できるか」を別 provider に分ける。
  - `isHomeEewEstimationDebugAvailableProvider`: Admin かつデバッグモード有効
  - `isHomeEewEstimationVisibleProvider`: 上記 かつ 設定が ON
  - こうすると、権限を失ったときに保存済み設定が残っていても表示されない。
- デバッグ画面のトグルは `onChanged: null` で非活性にし、
  サブタイトルに「デバッグモード無効」「ロール取得中」「Admin 以外」などの理由を出す。

## 運用

Admin 扱いにするデバイスは、backend の Helm values
（`deploy/k8s/values/tokyo/{develop,production}.yaml` の
`eqmonitorApi.adminDeviceIds`）へ UUID をカンマ区切りで追加する。
デバイス ID はデバッグ画面のデバイス情報から確認できる。
