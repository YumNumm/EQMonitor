# API・キャッシュ・データ変換

確認日: 2026-09-21。生成手順は [コード生成](code_generation.md)、アーキテクチャ規約は `.cursor/rules/data-layer-architecture-rules.mdc` を参照する。

## Dio のネイティブ HTTP 通信

- アプリの Dio は `app/lib/core/data/network/native_dio_factory.dart` の `NativeDioFactory` で生成する。API・認証・キャッシュ再取得・強震モニタ・地震活動・headless 通信に共通適用する。
- `native_dio_adapter 1.8.0` の `NativeAdapter` を Dio の `httpClientAdapter` に直接設定する。iOS/macOS は URLSession、Android は HTTP/2 と QUIC を有効にした Cronet を使う。実際の HTTP/2・HTTP/3 使用は接続先・OS・回線の対応で決まる。
- Android は [provider fallback](https://pub.dev/packages/native_dio_adapter#opt-in-cronet-provider-fallback-android) を有効にする。Cronet provider がすべて無効な場合だけ `IOHttpClientAdapter` に切り替え、通常の通信・TLS・タイムアウト・キャンセルエラーはそのまま返す。fallback 中は Dart の HTTP/1.1 通信になる。
- ネイティブ HTTP cache は無効にし、URLSession の Cookie 自動保存・自動付与も無効にする。キャッシュと Cookie の管理は既存の Dio interceptor が担当する。provider 破棄時と一時的な通信の終了時は `dio.close(force: true)` を呼ぶ。headless も完了通知前に同じ方法で閉じる。
- タイムアウト、キャンセル、接続の終了処理は Dio とプラグインに任せる。アプリ独自のリクエスト追跡、ストリームの読み続け、終了待ちやリトライは追加しない。ネイティブアダプターと Dart の標準アダプターではタイムアウト段階の区別が異なるため、設定値の一致だけで端末上の待ち時間やエラー分類の一致を判断しない。
- 端末 ID ヘッダーと認証ヘッダーは、どちらも `DeviceAuthRepository.readToken()` で端末トークンを読む。全リクエストで secure storage（platform channel）を読まないよう、読み取れたトークンを Repository がメモリに保持する。保存・削除は必ず `saveToken` / `clearToken` を通す。secure storage を直接書き換える処理（デバッグ画面など）は `forgetCachedToken()` を呼ぶ。「保存なし」は保持しない。端末のロック中など一時的に読めない状態を、プロセスが終わるまで未登録として扱わないためである。headless Engine は別 isolate で secure storage を直接読むため、この保持の対象外。
- `dioProvider` / `apiClientProvider` は自前 backend 専用。interceptor が端末 ID を全リクエストへ付けるため、絶対 URL で他ホストへ使うと端末 ID が送られる。外部ホスト（強震モニタ、地震活動 GeoJSON、震源アーカイブ、Asset Pack の配布元）は `NativeDioFactory` で専用の Dio を作る。2026-11-17 時点で、`dioProvider` を直接使うのは地震活動 manifest とテレメトリ送信で、どちらも自前 API のパス。
- `dart:io` を直接使う地図・推定震度アーカイブ取得、SDK の内部通信、Dart CLI の Dio はこのアプリ用 factory を通らない。端末での通信規格・認証・fallback・タイムアウト確認は [ビルド・配布の課題](../todo/950_build_and_release.md) に記録する。

## HTTP cache は明示的に選ぶ

- 通常の `apiClientProvider` / `dioProvider` に HTTP cache は付けない。cache-first が必要な非 paging GET だけ `CachedNotifier` と `httpCachedApiClientProvider` を使用する。
- 対象は start/changelog、parameter manifest/本体、県/市区町村の過去最大震度、地震・電文・Feed の個別詳細、地震活動 GeoJSON。外部ホストの GeoJSON は専用 Dio に interceptor を一つだけ付ける。
- paging・cursor・検索、端末/通知/購読情報、Realtime ticket・最新 EEW、新規 GET は既定で対象外。cache 無効・DB 不可時は通常通信へ縮退し、架空の値で埋めない。
- 許可対象の追加時は [cache の設計](../superpowers/specs/2026-07-27-http-cache-opt-in-scope-design.md) と `app/test/core/provider/http_cache_scope_test.dart` を更新する。
- provider test で cache-first、背景再検証、最新値への更新を確認し、対象外 GET が保存されない境界も維持する。

## 端末固有 API の前回値はアプリ側で保存する

- 端末・通知・購読情報は HTTP cache の対象外のまま。起動時に応答を待たせたくない値は、機能ごとの Repository が SharedPreferences へ保存する。`CachedNotifier` は HTTP cache 層に依存するため流用しない。
- 通知スロット（`GET /v2/device/me/settings/slots`）は `NotificationSlotCacheRepository` が前回値を保存する。`NotificationSlotsNotifier` は起動後の最初の構築だけ前回値を返し、裏でサーバーへ確認して差分があれば状態・保存値・位置情報監視へ反映する。確認に失敗した場合は前回値のまま進め、エラー状態にしない。
- 変更後の `invalidateSelf()`・明示的な `ref.invalidate`・端末の再登録後の再構築は、前回値を返さずサーバーの応答を待つ。保存値を返すのはプロセスごとに一度だけ。
- 変更時は書き込みの応答から一覧が確定する操作（現在地・全国・地域の更新、全件置換、現在地の削除）で保存値を更新し、確定しない操作（地域の追加・削除、全国の削除）では保存値を消して再取得の結果を保存する。変更は `_revision` を進め、進行中の確認・取得の古い応答で状態や保存値を上書きしない。新しい変更メソッドを追加するときも同じ手順を踏む。
- 保存値は資格情報の保存・削除時（`deviceAuthRepositoryProvider` の `onCredentialsWillChange`）に消す。端末 ID に紐づく保存値を増やす場合はここへ追加する。デバイスのロールの保存は [Push と認証](push_and_auth.md) を参照する。
- 購読状態を端末へ書き出す処理（iOS の App Group へ書く `appGroupSettingsWriterProvider`）は `confirmedIsProProvider` を使う。`isProProvider` は読み込み中・エラー時に false を返すため、そのまま書くと Pro ユーザーの値が起動のたびに false → true と変わり、Widget のタイムライン再読み込みを 2 回要求する（コードの読解による。実機での計測は未実施）。未確定（null）の間は Pro 状態と任意地域を書き換えず、通信エラーでも前回の値を残す。URL・現在地など Pro に依存しない値は確定を待たずに書く。画面の出し分けは従来どおり `isProProvider` を使う。
- 保存値の読み書き失敗は通常の取得へ縮退させ、例外を外へ出さない。binding を初期化したテストで `SharedPreferences` を mock しないと platform channel の応答が返らず、実物の `NotificationSlotsNotifier` の構築・変更が完了しない。`SharedPreferences.setMockInitialValues({})` を設定する。

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
