# HTTPキャッシュは明示的にオプトインする

HTTPキャッシュは、Home画面や個別ページを開いたときの初期表示を高速化するために使う。
新しいGETはキャッシュなしを既定とし、対象を暗黙に広げない。

## クライアントの使い分け

- 通常の `apiClientProvider` / `dioProvider` はHTTPキャッシュを持たない。
- cache-first表示が必要な非paging GETだけを `CachedNotifier` から
  `httpCachedApiClientProvider` へ接続する。
- キャッシュ無効時やDBを利用できない場合は、固定値へフォールバックせず通常通信へ
  縮退する。
- 地震活動GeoJSONは外部ホストへ接続するため、アプリAPIとは分離した
  `seismicityGeoJsonDioProvider` に `HttpCacheInterceptor` を1個だけ設定する。

## キャッシュを許可するGET

- `/v1/start`
- `/v1/changelog`
- パラメータのmanifestと本体
- 全都道府県の過去最大震度
- 指定都道府県の市区町村別過去最大震度
- 地震詳細 `/v2/earthquake/{eventId}`
- 電文詳細 `/v2/telegram/eventId/{eventId}/details`
- Feed個別詳細 `/v2/feeds/source/{telegramHash}`
- 地震活動GeoJSON

## キャッシュしないGET

- Feed一覧や地震履歴一覧などのpaging API
- cursor、page、またはpaging目的のlimitを使うAPI
- 条件検索や地域別検索
- 端末情報、通知設定、購読状態などのユーザー固有情報
- Realtime ticketや最新EEWなどの短命なRealtime情報
- キャッシュ利用を明示していない新しいGET

## 対象を追加するとき

1. `docs/superpowers/specs/2026-07-27-http-cache-opt-in-scope-design.md` の許可一覧を更新する。
2. 対象providerを `CachedNotifier` と `httpCachedApiClientProvider` に明示的に接続する。
3. cache-first表示、背景再検証、最新値への更新をproviderテストで確認する。
4. `app/test/core/provider/http_cache_scope_test.dart` を更新し、対象外GETが保存されない
   境界を維持する。

Flutter / Dartの検証は必ず `mise exec --` 経由で実行する。

```bash
cd app
mise exec -- flutter test \
  test/core/provider/http_cache_scope_test.dart \
  test/feature/seismicity/data/provider/seismicity_repository_provider_test.dart
mise exec -- flutter analyze --no-pub lib/core/provider test/core/provider
```
