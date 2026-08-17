# Device API に role フィールドを追加する

**作成日**: 2026-08-14
**対象ブランチ**: develop
**ステータス**: backend 対応待ち（アプリ側は先行実装済み）

---

## 背景

ホーム画面のデバッグ用トグル「ホームに推計震度・到達予想時刻を表示」は、
`Device API のロールが Admin` かつ `デバッグモードが有効` の場合のみ操作できる仕様で実装した。

しかし backend の現状は次のとおりで、**アプリからは Admin ロールを判定できない**。

- `GET /v2/device/me`（`DeviceMeResponse`）は `id` / `type` / `locale` /
  `registrationType` / `userId` / `is_pro` / `createdAt` / `updatedAt` のみを返し、
  `role` を含まない（backend: `api/api/src/features/device/routes/device.ts`）。
- ロールは better-auth の `user.role` にあり、`role === 'admin'` の判定は
  `sessionMiddleware`（Cookie セッション / better-auth JWT）配下のルート
  （`/v2/admin/*`、`/v2/user/me` 等）でのみ行われている。
- アプリはデバイス JWT のみを持ち、better-auth セッションを持たない。
  デバイス JWT のクレームにも role は含まれない。

そのため、**backend が対応するまでトグルは常に非活性**（サブタイトルに理由を表示）となる。

---

## 必要な対応

1. backend: `DeviceMeResponse` に `role`（`admin` / `user` などの文字列）を追加する。
   デバイスに紐づく `userId` から better-auth の `user.role` を引く。
   - 未ログインデバイスは `null` を返す設計にする（アプリ側は null を非 Admin として扱う）。
2. OpenAPI を再生成し、`packages/eqmonitor_api` の生成クライアントを更新する。
3. アプリ: `DeviceRepository.getDeviceRole()` の生 JSON 読み取りを、
   生成モデル（`DeviceMeResponse.role`）経由へ置き換える。
   - 対象: `app/lib/feature/devices/data/repository/device_repository.dart`
   - `app/lib/feature/devices/data/model/device_role.dart` の
     `DeviceRole.fromApiValue` はそのまま流用できる。
4. `app/test/feature/devices/device_repository_role_test.dart` を
   生成モデル経由の実装に合わせて更新する。

---

## 現在のアプリ側実装（暫定）

`DeviceRepository.getDeviceRole()` は `GET /v2/device/me` のレスポンス生 JSON から
`role` を読む。フィールドが存在しない現状では常に `null` を返し、
`isHomeEewEstimationDebugAvailableProvider` は false になる。

権限を推測して Admin 扱いにするフォールバックは意図的に入れていない。

---

## 判断が必要なこと

- Admin 判定をデバイス単位で返してよいか（アカウント情報の露出範囲）。
- アプリにアカウントログインを導入し `/v2/user/me` を使う方針にするか
  （`docs/todo/091_user_api_app_scope.md` と合わせて検討する）。
