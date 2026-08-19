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

Admin 扱いにするデバイス ID は **SealedSecret で管理する**。values に平文で
書くと ArgoCD のレンダリング結果と git 履歴の両方に端末識別子が残るため。

- 値の実体: SealedSecret `eqmonitor-secrets` の `ADMIN_DEVICE_IDS`
  （`deploy/k8s/charts/eqmonitor/templates/sealed-eqmonitor-secrets.yaml`）。
  カンマ区切りの UUID 一覧。cluster-wide スコープなので develop / production で
  同じ値が復号される。
- 注入の ON/OFF: `deploy/k8s/values/tokyo/{develop,production}.yaml` の
  `eqmonitorApi.adminDeviceIds.enabled`。**両方を true にする。**
  片方だけだと、その環境へ繋いだアプリが常に `role: USER` になる。
- デバイス ID はアプリのデバッグ画面のデバイス情報から確認できる。

デバイスを追加するときは、既存の値へ追記した上で再シールする:

```bash
kubectl create secret generic eqmonitor-secrets \
  --namespace eqmonitor-tokyo-production \
  --from-literal=ADMIN_DEVICE_IDS='<既存の一覧>,<追加する UUID>' \
  --dry-run=client -o json \
  | kubeseal --scope cluster-wide --format yaml \
      --controller-namespace kube-system --controller-name sealed-secrets-controller
```

出力の `ADMIN_DEVICE_IDS:` 行だけを `sealed-eqmonitor-secrets.yaml` の
`encryptedData` へ差し替える（キーは個別に暗号化されるため他の行は触らない）。
検証は `kubeseal --validate`、レンダリングの回帰は
`deploy/k8s/charts/eqmonitor/test/api-admin-device-ids.sh` で確認する。
