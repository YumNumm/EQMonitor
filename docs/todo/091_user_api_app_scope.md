# User API のアプリ側スコープ整理

**作成日**: 2026-06-05
**対象ブランチ**: develop
**ステータス**: 方針整理 / 実装未着手

---

## 背景

`/v2/user/*` は OpenAPI と生成クライアントに存在するが、現時点の Flutter アプリ側では画面・Repository から利用していない。

今回の OpenAPI / アプリ整合対応では、device API は device 登録・通知設定・token 同期の責務に閉じ、user API へ依存させない。ユーザー管理機能は将来のアカウント機能として別タスクで設計する。

---

## 現時点の判断

- device API と user API はアプリ側で結合しない。
- device 登録・通知設定・FCM/APNs token 同期は、引き続き device feature の責務として扱う。
- `/v2/user/me/devices` は「アカウントに紐づくデバイス一覧」用途であり、通常の device 登録フローの前提にしない。
- User API のアプリ UI / Repository 実装は今回のリリーススコープ外とする。

---

## 判断が必要なこと

- ユーザープロフィール表示・編集をアプリに出すか。
- デバイス一覧とセッション一覧を設定画面に出すか。
- アカウント削除導線を提供するか。
- User API を使う前提となる認証状態・セッション管理をどの feature が所有するか。

---

## 注意点

`PATCH /v2/user/me` は現 OpenAPI 上で requestBody が見当たらない。プロフィール更新をアプリで実装する前に、backend schema と生成クライアントの interface を確認する。

User API を実装する場合も、device API の登録・通知 token 同期と混ぜず、アカウント管理 feature として分離して設計する。
