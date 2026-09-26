# RevenueCat #1831 実装準備

調査日: 2026-09-26。対象: origin/develop `81386a797`。
状態: 調査・設計案。アプリ実装、外部設定変更、実購入検証は未実施。
親Issue: https://github.com/YumNumm/EQMonitor/issues/1831

## 現行コードで確認したこと

- `app/lib/feature/subscription/data/repository/revenue_cat_configurator.dart` は匿名configureのみ。`isConfigured` の確認とconfigureの間に排他がない。
- 同ディレクトリの `subscription_repository.dart` はdevice登録・identity変更に依存しない。購入・復元ともSDKの `pro` のみで成功を判定する。
- 商品ID一致packageがなければ `current.monthly` を購入するため、設定ミスを隠す。
- `app/lib/feature/subscription/data/provider/subscription_product_id_provider.dart` のiOS定数は `net.yumnumm.eqmonitor.pro.monthly`。
- #1839の9/24のASC確認記録は `net.yumnumm.eqmontior.pro.monthly`。今回ストア実設定は再確認していない。
- `app/lib/feature/subscription/ui/page/paywall_page.dart` は価格 `¥300` 固定。表示時と購入時のpackageを共有していない。
- `app/lib/core/provider/device_id.dart` は既存JWTからdevice IDを取得する。これだけをawaitしても登録処理の完了待ちにはならない。
- `device_provisioning_notifier.dart` のbuildは登録要否を返す。実登録は `provision()`。購入側から別の登録処理を重複起動しない。
- `subscription_notifier.dart` はkeepAlive。更新listener・復帰時更新・期限再評価・旧identity結果の破棄がない。
- `packages/eqmonitor_api/lib/src/clients/subscription_api_client.dart` はGET `/v2/subscription/me` のみ。アプリからの利用も見つからない。
- `notification_settings_page.dart` は `planConstraints.free` 固定。`is_pro_provider.dart` のSDK由来状態は広告とWidget/App Groupへ伝播する。
- 既存subscriptionテストはfake repositoryによるNotifierとisPro判定。SDK連携・所有者移行・Webhookは検証していない。

## 実装前に確定する契約（#1837 / #1840）

- **ユーザー決定（2026-09-26）: 同じストアアカウントの複数端末でProを同時利用可能にする。復元で旧端末の権限を解除しない。**
- したがって #1837/#1838 とbackend #1291の「device ID = 購入所有者」という前提は再設計する。購入所有者と利用deviceを分け、検証済み購入への端末紐付けを管理する案を優先する。
- RevenueCatの安定した共通App User IDを何から発行するか、アプリログインを必要とするか、ストア復元から安全に同一購入へ紐付ける手順は未決。SDKはストアアカウント識別子を取得できると仮定しない。
- aliases全員への権限付与、クライアント申告の取引IDだけでの共有、標準TRANSFER後も無条件に旧権限を残す方式で代用しない。backendで購入とdevice本人性を確認する契約が必要。
- RevenueCat project `proj26b6a297` の本番restore behaviorとSandbox overrideを読み取り確認する。標準値を実設定とみなさない。
- サーバー再同期API: 認証されたdeviceからRevenueCatへ照会し、検証済みの購読状態を返す契約をbackend #1291と定義する。URL・応答・レート制限は未決。
- SDKのPro申告やGETのpollingだけで欠落イベントの復旧を済ませない。サーバー照会用の秘密APIキーはアプリへ渡さない。
- aliasesが複数deviceへ解決される場合、未知ID、TRANSFER前後の到着順、削除済みdeviceの扱いをbackendと一致させる。

## 提案する最小構成（未承認）

既存Repository/Notifier/Mutation、device ID provider、生成済みAPIクライアントを利用する。汎用課金基盤や新しい依存は追加しない。

1. **#1839 + #1842: 商品取得と表示**
   - 実商品ID・platform・月額packageを検証し、不一致時の別商品フォールバックを撤去する。
   - 選択した同じpackageのローカライズ価格・期間を表示し、そのpackageを購入へ渡す。再取得で対象が変われば表示も更新する。
   - 商品未設定/取得中/失敗では購入不可とし、再取得を提供する。所有者契約と独立して着手可能。
2. **#1838: identityと購入操作の順序保証（共有所有者契約の確定後）**
   - 登録完了 → device ID取得 → 共有所有者契約に従うRC identity解決 → 一度だけconfigure → 必要なlogIn → identity一致確認 → 購入/復元。device IDを直接RC identityにする案は確定しない。
   - 既存匿名顧客を維持してlogInし、merge可否を確認する。device切替時の無条件logOut・restoreは行わない。
   - SDKのidentity変更と購入/復元を共通の直列処理へまとめ、失敗後に再試行可能にする。
   - 開始時のdevice ID/世代と結果適用時の値を照合する。削除・再登録中は購入を止め、旧結果を新deviceへ反映しない。
   - `paywall_flow.dart` と購読設定画面にも登録/連携失敗の回復導線を通す。
3. **backend #1291/#1292/#799 → #1840: 権限同期**
   - SDK購入状態・backend確認済み権限・同期状態を分ける。購入成立後の同期失敗を購入失敗扱いにして再購入させない。
   - 購入/復元/匿名移行後に認証済み再同期を要求する。処理中/同期失敗/認証要復旧を表示し、再同期のみ再試行できるようにする。
   - 通知等サーバー機能の正本はbackend。広告/Widgetは同一identityの期限内SDK確認値を使う案とし、offline有効範囲を承認時に確定する。
   - CustomerInfo更新・アプリ復帰・有効期限で再評価。初回未確認はProを付与せず、offline/401を失効確定と混同しない。
4. **#1841 + #1843: 利用制限・申告**
   - backend確認済み権限とstart APIからFree/Pro制限を選ぶ。失効時の超過地域は削除しない。配信・編集可否の契約を揃える。
   - device IDと購入情報の対応、削除/保持方針を `docs/beta/privacy-store-declarations.md` に反映する。Console反映は別途記録する。
5. **#1844: リリース検証**
   - backend配備・Webhook接続・ストアメタデータ・feature flagを確認してから署名実機で検証する。
   - 既存 `Main` entitlement・商品・紐付けを保持し、影響を確認する。

## 回帰テストと受け入れ条件

- identity: 登録未完了、configure競合、購入/復元同時実行、logIn失敗→再試行、処理中のdevice変更/削除。
- 商品: 正しい商品、別商品/platform、packageなし、取得失敗、JPY/別通貨、表示と購入の同一性。
- 同期: Webhook遅延、移行後のイベント欠落、offline、401、再同期失敗→回復、旧identityの遅延応答。
- 権限: 通常解約は期限までACTIVE/willRenew=false。猶予・返金・失効を区別し、有効な本番購入をSandbox失効で解除しない。
- UI: Free→Pro→Free、反映待ち、通知地域上限、非破壊の超過地域、広告/Widgetへの反映。
- 実機: 新規購入、更新、自動更新停止、失効、復元、匿名移行、再インストール、複数端末。端末Bで復元後もA/B双方でProが有効であること、返金/失効が双方へ反映されることを確認する。build/commit/API環境とRC/API/DB/通知の照合結果を残す。
- 実装時は `app/` で `mise exec -- flutter test test/feature/subscription`、関連device/通知テスト、`mise exec -- flutter analyze` を実行する。
- 生成が必要なら `mise exec -- dart run build_runner build --delete-conflicting-outputs`。APIクライアントは生成元契約を直して再生成する。
- 今回は準備文書のみ。Flutterテスト・解析・実機検証は未実施で、実装の正常性は主張しない。
- 準備文書のcommit時、必要mise `2026.09.12` に対して導入済み `2026.8.16` のためhkフックが起動前に停止した。
- Markdown対象のhk util `check-merge-conflict` / `check-symlinks` / `detect-private-key` と `gitleaks git --staged --baseline-path .gitleaks.baseline.json` を導入済み実体から実行して通過確認後、この文書commitのみ `HK=0 git commit` で保存する。実装時はmiseの版を解決し、通常フックを使用する。

## 外部情報と確認境界

- backend #1291の9/24コメントは「作業ツリー実装済み・未commit/未配備」。現在の配備済み状態の根拠にはしない。
- ASC商品状態、Webhook接続、restore behavior、Sandbox override、実購入成功は今回未確認。
- 既存TODO: `docs/todo/900_auth_subscription_and_ads.md` の089/090/088/150と本記録を併読する。
- [所有者契約 #1837](https://github.com/YumNumm/EQMonitor/issues/1837)、[backend #1291](https://github.com/YumNumm/eqmonitor-backend/issues/1291)。
- [公式identity仕様](https://www.revenuecat.com/docs/customers/identifying-customers): 匿名→新custom ID等はmergeするが、匿名aliasを持つ既存IDやcustom ID間のlogInは購入移管しない。
- [公式restore仕様](https://www.revenuecat.com/docs/projects/restore-behavior): 標準の移管方式は復元先へ権限を移す。共有方式はlegacyであり、新規の同時利用設計の前提にしない。
