# API・キャッシュ・データ変換

確認日: 2026-09-21。生成手順は [コード生成](code_generation.md)、アーキテクチャ規約は `.cursor/rules/data-layer-architecture-rules.mdc` を参照する。

## Dio のネイティブ HTTP 通信

- アプリの Dio は `app/lib/core/data/network/native_dio_factory.dart` の `NativeDioFactory` で生成する。API・認証・キャッシュ再取得・強震モニタ・Hi-net・地震活動・headless 通信に共通適用し、K-NET のダウンロードと認証確認にも生成済み Dio を渡す。
- `native_dio_adapter 1.8.0` を使用し、iOS/macOS は URLSession、Android は HTTP/2 と QUIC を有効にした Cronet を使う。実際の HTTP/2・HTTP/3 使用は接続先・OS・回線の対応で決まる。
- Android は [provider fallback](https://pub.dev/packages/native_dio_adapter#opt-in-cronet-provider-fallback-android) を有効にする。Cronet provider がすべて無効な場合だけ `IOHttpClientAdapter` に切り替え、通常の通信・TLS・タイムアウト・キャンセルエラーはそのまま返す。fallback 中は Dart の HTTP/1.1 通信になる。
- ネイティブ HTTP cache は無効にし、URLSession の Cookie 自動保存・自動付与も無効にする。キャッシュと Cookie の管理は既存の Dio interceptor が担当する。provider 破棄時はその Dio の通信をキャンセルし、一時的な Dio と headless 通信は `NativeDioFactory.close` の完了を待つ。共通アダプターが native の終了を追跡してから接続を閉じ、headless は実行環境を破棄する完了通知の前に後片付けを終える。
- 共通アダプターは送信準備からレスポンスヘッダー取得までを `connectTimeout + receiveTimeout` の期限で扱う。送信準備には既存の `sendTimeout` も適用し、レスポンス本文の無通信時間は Dio の `receiveTimeout` で扱う。Dart の標準アダプターとタイムアウト段階の区別が異なるため、設定値の一致だけで端末上の待ち時間やエラー分類の一致を判断しない。
- `dart:io` を直接使う地図・推定震度アーカイブ取得、SDK の内部通信、Dart CLI の Dio はこのアプリ用 factory を通らない。端末での通信規格・認証・fallback・タイムアウト確認は [ビルド・配布の課題](../todo/950_build_and_release.md) に記録する。

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
