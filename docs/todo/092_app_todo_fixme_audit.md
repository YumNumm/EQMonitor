# アプリ側 TODO / FIXME / 未実装マーカー監査

- 作成日: 2026-06-30
- 対象範囲: `app/` と Flutter / Dart 側の `packages/`
- 対象外: `backend/`, `docs/`, `tools/`, `utils/`, `terraform/`, `supabase/`
- 検出件数: `app/` 23 行、`packages/` 20 行
- `FIXME` の検出件数: 0 件

使用した検索コマンド:

```sh
rg -n --hidden -S "\b(TODO|FIXME|XXX|HACK)\b|未実装|後で実装|あとで実装" app
rg -n --hidden -S "throw UnimplementedError|UnimplementedError\(|FlutterMethodNotImplemented|throw UnsupportedError|UnsupportedError\(" app
rg -n --hidden -S "\b(TODO|FIXME|XXX|HACK)\b|未実装|後で実装|あとで実装" packages
rg -n --hidden -S "throw UnimplementedError|UnimplementedError\(|FlutterMethodNotImplemented|throw UnsupportedError|UnsupportedError\(" packages
```

## 優先して確認したい項目

| 場所 | マーカー | 内容 |
| --- | --- | --- |
| `app/ios/Widget/Widget.swift:52` | `TODO(YumNumm)` | Widget の現在地モードで、コメント上は `UserDefaults` から位置情報を取得する予定だが、実装は地域コード `"350"` の固定値を返している。地域別の地震情報に影響するため、実データ参照へ置き換えるか、実装完了まで現在地モードを無効化する必要がある。 |
| `packages/eqmonitor_api/lib/src/models/get_v2_subscription_me_response_union.dart:33` | `TODO: No discriminator...` | 生成された `fromJson` に、サブスクリプション状態 union の手動実装 TODO が残っている。 |
| `packages/eqmonitor_api/lib/src/models/get_v2_subscription_me_response_union.dart:45` | `throw UnimplementedError()` | 同じサブスクリプション union のパーサーが、`GetV2SubscriptionMeResponseUnion.fromJson` 利用時に実行時例外になる。既存の union 後処理と同様に `packages/eqmonitor_api/bin/generate.dart` へパッチを追加し、再生成するのがよい。 |

## アプリ側のコメント

| 場所 | マーカー | 内容 |
| --- | --- | --- |
| `app/ios/scripts/patch_purchases_paywall_color.sh:6` | `TODO` | RevenueCat の一時的な回避策。`purchases-hybrid-common` が `purchases-ios-spm >= 5.78.0` を固定するようになったら削除する。 |
| `app/ios/Widget/Widget.swift:52` | `TODO(YumNumm)` | Widget の現在地地域取得が未実装で、現状は `"350"` にフォールバックしている。 |
| `app/lib/feature/fnet_catalog/ui/components/fnet_catalog_list_tile.dart:23` | `後で実装` | コメントでは詳細画面への遷移が今後実装となっているが、タップ時にはすでに `_showDetails(context)` でモーダルを開いている。期待する UX がモーダルなのか詳細ページ遷移なのかを確認し、コメント更新または実装差し替えを行う。 |
| `app/ios/Widget/LiveActivity/Eew/EewLiveActivityView.swift:57` | `XXX` | `"XXXで地震"` という表示例のコメントであり、対応が必要な TODO ではなさそう。 |

## アプリ側の UnimplementedError / UnsupportedError

### Provider 注入前提のプレースホルダー

以下の Provider は、`main.dart` で override されるまで例外を投げる設計になっている。現状では `app/lib/main.dart:226` から `app/lib/main.dart:242` で、起動時に取得できたプラットフォーム情報が注入されている。

| 場所 | マーカー | 内容 |
| --- | --- | --- |
| `app/lib/core/provider/device_info.dart:7` | `throw UnimplementedError()` | `AndroidDeviceInfo` のベース Provider。Android では起動時に override される。 |
| `app/lib/core/provider/device_info.dart:10` | `throw UnimplementedError()` | `IosDeviceInfo` のベース Provider。iOS では起動時に override される。 |
| `app/lib/core/provider/application_documents_directory.dart:8` | `throw UnimplementedError()` | アプリのドキュメントディレクトリ用ベース Provider。取得できた場合は起動時に override される。 |
| `app/lib/core/provider/package_info.dart:7` | `throw UnimplementedError()` | パッケージ情報用ベース Provider。起動時に override される。 |
| `app/lib/core/provider/shared_preferences.dart:32` | `throw UnimplementedError(...)` | 互換ラッパー用ベース Provider。メッセージ上も `main` での override が必須と明記されている。 |
| `app/lib/feature/kyoshin_monitor/data/provider/kyoshin_color_map.dart:10` | `throw UnimplementedError()` | 強震モニタ色マップ用ベース Provider。Web 以外では起動時に override される。 |
| `app/lib/feature/telemetry/data/provider/telemetry_database_provider.dart:31` | `throw UnimplementedError(...)` | telemetry DB パス用ベース Provider。Web 以外では解決済みパスで起動時に override される。 |

### 実行時ガード / プラットフォームガード

| 場所 | マーカー | 内容 |
| --- | --- | --- |
| `app/lib/firebase_options.dart:30` | `throw UnsupportedError(...)` | Windows 用 Firebase 設定が未構成であることを示す FlutterFire 生成コードのガード。 |
| `app/lib/firebase_options.dart:35` | `throw UnsupportedError(...)` | Linux 用 Firebase 設定が未構成であることを示す FlutterFire 生成コードのガード。 |
| `app/lib/firebase_options.dart:40` | `throw UnsupportedError(...)` | Fuchsia 非対応を示す FlutterFire 生成コードのガード。 |
| `app/lib/core/router/router.g.dart:1664` | `throw UnsupportedError(...)` | go_router 生成コードの bool 変換ガード。無効な route query 値に対して投げる。 |
| `app/lib/feature/live_activity/data/provider/eqm_live_activity_util.dart:12` | `throw UnsupportedError(...)` | Live Activity utility は iOS / macOS のみ対応というプラットフォームガード。 |
| `app/lib/feature/settings/data/contact/contact_action.dart:32` | `throw UnsupportedError(...)` | 問い合わせ URL 生成は Android / iOS のみ対応。デスクトップや Web を想定するならユーザー向け挙動を検討する。 |
| `app/ios/Runner/AppGroupMethodChannel.swift:43` | `FlutterMethodNotImplemented` | Native MethodChannel の default 分岐。未知の method 名に対する標準応答。 |

### 地図データ形状のガード

| 場所 | マーカー | 内容 |
| --- | --- | --- |
| `app/lib/core/provider/map/jma_map_utility.dart:51` | `throw UnimplementedError(...)` | 津波予報区の検索は line 系 geometry を前提にしており、polygon 系が来ると例外になる。アセット生成で津波データが line 系に保証されている場合のみ妥当。 |
| `app/lib/core/provider/map/jma_map_utility.dart:79` | `throw UnimplementedError(...)` | 津波以外の検索は polygon 系 geometry を前提にしており、line 系が来ると例外になる。アセットのデータ形状保証に依存している。 |
| `app/lib/core/provider/map/jma_map_provider.dart:41` | `throw UnimplementedError()` | 未知の生成 `JmaMapType` に対する enum 変換ガード。今後 map type が増える可能性があるなら、明示的なエラー内容を持つ `ArgumentError` なども検討する。 |
| `app/lib/feature/settings/features/display_settings/ui/display_settings.dart:85` | `throw UnimplementedError()` | light / dark のみを受けるテーマ選択 switch のガード。呼び出し側が `ThemeMode.light` と `ThemeMode.dark` だけを渡しているため、現状は到達しない。 |
| `app/lib/feature/settings/features/display_settings/ui/display_settings.dart:93` | `throw UnimplementedError()` | 同じテーマ選択ラベル用 switch のガード。 |

### テスト専用のガード

| 場所 | マーカー | 内容 |
| --- | --- | --- |
| `app/test/feature/location/background_location_update_notifier_test.dart:107` | `throw UnimplementedError(...)` | テスト用 interceptor の未処理 method / path 検出ガード。想定外リクエストを即座に失敗させる意図的な実装。 |
| `app/test/feature/settings/features/notification_settings/notification_slot_repository_test.dart:165` | `throw UnimplementedError(...)` | テスト用 interceptor の未処理 method / path 検出ガード。想定外リクエストを即座に失敗させる意図的な実装。 |

## パッケージ側の TODO / README プレースホルダー

| 場所 | マーカー | 内容 |
| --- | --- | --- |
| `packages/extensions/README.md:14` | `TODO` | Dart package テンプレートの説明文が残っている。 |
| `packages/extensions/README.md:19` | `TODO` | Dart package テンプレートの機能説明が残っている。 |
| `packages/extensions/README.md:23` | `TODO` | Dart package テンプレートの導入手順が残っている。 |
| `packages/extensions/README.md:28` | `TODO` | Dart package テンプレートの使用例が残っている。 |
| `packages/extensions/README.md:37` | `TODO` | Dart package テンプレートの追加情報が残っている。 |
| `packages/lat_lng/README.md:14` | `TODO` | Dart package テンプレートの説明文が残っている。 |
| `packages/lat_lng/README.md:19` | `TODO` | Dart package テンプレートの機能説明が残っている。 |
| `packages/lat_lng/README.md:23` | `TODO` | Dart package テンプレートの導入手順が残っている。 |
| `packages/lat_lng/README.md:28` | `TODO` | Dart package テンプレートの使用例が残っている。 |
| `packages/lat_lng/README.md:37` | `TODO` | Dart package テンプレートの追加情報が残っている。 |
| `packages/eqmonitor_api/bin/generate.dart:562` | `UnimplementedError` への言及 | `swagger_parser` が union stub を生成することを説明する generator コメント。単体では対応不要。 |
| `packages/eqmonitor_api/bin/generate.dart:568` | `TODO` への言及 | generator コメント内の例示。単体では対応不要。 |
| `packages/eqmonitor_api/bin/generate.dart:569` | `UnimplementedError` への言及 | generator コメント内の例示。単体では対応不要。 |
| `packages/eqmonitor_api/bin/generate.dart:586` | `UnimplementedError` への言及 | generator patcher の正規表現。単体では対応不要。 |

## パッケージ側の UnimplementedError / UnsupportedError

| 場所 | マーカー | 内容 |
| --- | --- | --- |
| `packages/eqmonitor_api/lib/src/models/get_v2_subscription_me_response_union.dart:45` | `throw UnimplementedError()` | 実際に残っている生成 model の stub。優先確認項目を参照。 |
| `packages/jma_map/bin/jma_map.dart:177` | `throw UnimplementedError(...)` | アセット生成器が未対応 geometry type で投げるガード。アプリ実行時コードではない。 |
| `packages/jma_map/bin/jma_map.dart:193` | `throw UnimplementedError()` | アセット生成器が未知の `JmaMapType` で投げるガード。将来のデバッグに使うなら、より具体的なエラー内容にする余地がある。 |
| `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/BackgroundLocationPlugin.swift:51` | `FlutterMethodNotImplemented` | Native plugin の MethodChannel default 分岐。未知の method 名に対する標準応答。 |
| `packages/live_activity_util/hook/build.dart:25` | `throw UnsupportedError(...)` | build hook が static linking を拒否している。ログも明確で、意図的なガードに見える。 |

## 推奨する対応順

1. `app/ios/Widget/Widget.swift:52` の Widget 現在地モード固定地域フォールバックを置き換える、または削除する。
2. `GetV2SubscriptionMeResponseUnion.fromJson` の生成後パッチを追加し、`packages/eqmonitor_api` を再生成する。
3. `FnetCatalogListTile` の詳細表示をモーダルのままにするか詳細ページ遷移にするか決め、古いコメントを更新する。
4. RevenueCat の依存バージョンが十分に上がった段階で、一時パッチスクリプトを削除する。
5. `packages/extensions` と `packages/lat_lng` の README テンプレート TODO を埋める。公開予定がない内部 package なら、その扱いを明記する。
