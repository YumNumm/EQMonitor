# API・キャッシュ・データ変換

確認日: 2026-09-21。生成手順は [コード生成](code_generation.md)、アーキテクチャ規約は `.cursor/rules/data-layer-architecture-rules.mdc` を参照する。

## HTTP cache は明示的に選ぶ

- 通常の `apiClientProvider` / `dioProvider` に HTTP cache は付けない。cache-first が必要な非 paging GET だけ `CachedNotifier` と `httpCachedApiClientProvider` を使用する。
- 対象は start/changelog、parameter manifest/本体、県/市区町村の過去最大震度、地震・電文・Feed の個別詳細、地震活動 GeoJSON。外部ホストの GeoJSON は専用 Dio に interceptor を一つだけ付ける。
- paging・cursor・検索、端末/通知/購読情報、Realtime ticket・最新 EEW、新規 GET は既定で対象外。cache 無効・DB 不可時は通常通信へ縮退し、架空の値で埋めない。
- 許可対象の追加時は [cache の設計](../superpowers/specs/2026-07-27-http-cache-opt-in-scope-design.md) と `app/test/core/provider/http_cache_scope_test.dart` を更新する。
- provider test で cache-first、背景再検証、最新値への更新を確認し、対象外 GET が保存されない境界も維持する。

## 外部 JSON の解析と値検証

- 構造・型・必須 field は Freezed / json_serializable、SemVer・digest・固定 path・順序などの値制約は `*Validator` に分離する。Repository は Validator の `parse` を呼ぶ。
- `app/build.yaml` の `field_rename: snake` を前提に、camelCase の入力だけ明示的な `JsonKey` を使う。
- `checked: true` の構造不正は `CheckedFromJsonException`。呼び出し側が `FormatException` を契約にしているなら Validator 境界で変換する。
- Freezed の生成クラスはモデルを `implements` するため、モデル本体へ実装済みメソッドを増やさず extension に置く。
- `localizations: {ja, en}` など必須の固定キーは専用モデルにする。欠落を UI の fallback まで持ち越さない。

## v2.6 端末の移行

- 現行の所有者は `app/lib/feature/devices/data/workflow/device_migration_workflow.dart` と `DeviceProvisioningRepository`。旧 `feature/migration` の path・device ID 付き endpoint を流用しない。
- v2.6 の旧 ID は Secure Storage の `api_token` の `id` claim にある。v2 は初期化 marker を持たない。`SecureStorageInitializer` が消去前に UUID を回収し、`SharedPreferencesKey.legacyDeviceId` に保存する。書き込み失敗では marker を保存せず token を保持する。
- 旧 JWT はローカルの移行元 ID を読む目的に限定する。署名・期限の認証判断や v3 の Bearer token として利用しない。破損 JWT から ID を補完しない。保存済み旧 ID と JWT の ID が矛盾する場合は停止する。
- `deviceProvisioned` は新端末登録の完了、`deviceLegacyMigrationVerified` は今回の workflow による旧設定移行の確認を表す。旧 `deviceMigratedFromLegacy` flag は互換性のため出力するが、旧版の404/409でも保存されるため完了判定に使わない。旧 ID があり移行未完了なら登録済みでも再試行を要求する。新 JWT があれば既存新端末を取得して再利用する。
- 登録・移行は `DeviceRepository` の現行 API/認証契約を使う。移行元・移行先ごとの `v3-device-migration-v2` workflow で `migrateLegacySettings` → `markLocalComplete` を永続化する。v1 の step は 404/409 でも成功を保存していたため再利用しない。成功をローカルに保存できた場合の再実行は移行を再送しない。
- 404 は旧端末不在、409 は既移行・更新対象 0 行を含み、同じ新端末への成功を証明しない。両方とも未完了を保持し手動再試行できる。通信失敗・5xx は既存の自動再試行を使う。サーバー成功後に応答・ローカル保存を失ったケースの409を自動解決するには、backend に検証可能な移行先記録が必要。
- 移行確認後の次の Secure Storage 初期化で旧 JWT のみを削除する。旧 JWT なし・marker なしでは再インストール時の既存 credentials 消去を維持する。iOS の keychain に旧 JWT が残る再インストールと v2 アップグレードは、現行保存形式だけでは区別できない。
- 旧 JWT と旧 ID が既に失われた端末は推定紐付けしない。通知設定の手動再設定、旧 ID が確認できる保存データからの回復、本人性と移行先を検証できるサーバー救済を区別する。旧IDからの救済を追加するには、現在の通知設定を上書きしない方針と API 契約の検討が必要。

変更時は `app/` で関連する cache・device provisioning・Validator の既存テストと解析を実行する。
