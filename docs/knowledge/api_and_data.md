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
- 旧 ID は `SharedPreferencesKey.legacyDeviceId` 経由で取得し、取得できた場合だけ durable workflow を実行する。
- `ensureDeviceAbsent` → 必要な場合の登録 → `migrateLegacySettings` → `markLocalComplete` を同一 instance ID で永続化し、中断後は完了 step の次から再開する。
- 登録・移行は `DeviceRepository` の現行 API/認証契約を使う。409 の冪等処理も Repository に集約されている。
- 旧 ID なしの場合の onboarding は現在の provisioning flow と照合する。過去の「未実装」を現行 TODO として復活させない。

変更時は `app/` で関連する cache・device provisioning・Validator の既存テストと解析を実行する。
