# 通知スロット設定の不変条件

- 現在地スロットでも、緊急地震速報（予報）と地震情報の最小震度を変更できる。初期値は予報が震度4、地震情報が震度1。
- EEW と地震情報のグローバル `enabled` は常に `true` とし、通知の有効・無効は各スロットで管理する。
- Live Activity は「通知しない」以外のプリセットで常に有効化する。custom の復元でも過去の無効値を引き継がず `true` に寄せる。
- 緊急地震速報（警報）の設定はスロット詳細へ統合する。現在地は `warningEnabled`、全国は `target`、地域別警報は非対応。
- 全国警報は Free / Pro 共通で設定・配信できる。クライアントのロック、設定 API の 402、配信 SQL の `is_pro` 条件を追加しない。
- 警報通知はバックエンドで `critical` の重大な通知として配信する。画面上もこの性質を簡潔に説明する。

関連テスト:

```shell
mise exec -- flutter test app/test/feature/settings/features/notification_settings/
```
