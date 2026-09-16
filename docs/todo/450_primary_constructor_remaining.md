# Primary Constructor へ変換できていないクラス

`const new(...)` から primary constructor への一括変換を行った際、以下は言語機能の
制約または情報の欠落を避けるため変換せずに残した。Widget / State のサブクラスは
対象外（方針として `const new()` のまま）。

`eqmonitor_lints_plugin` の `prefer_primary_constructor` は `extends` を持つ class・
初期化子リスト・本体あり・複数コンストラクタを除外するため、以下はどれも
lint 違反として報告されない（`dart analyze app packages` は 0 件）。

## 1. コンストラクタに initializer list / body がある

primary constructor は initializer list を持てない。named 引数は `_` 始まりに
できないため、`{required Dio dio} : _dio = dio` 形式は positional へ変える以外に
表現できず、呼び出し側の API が変わる。assert / super 呼び出しも同様。

- `packages/lat_lng/lib/src/lat_lng.dart` — `LatLng`（`: super(lat, lon)`）
- `packages/kyoshin_monitor_image_parser/lib/src/exception/kyoshin_monitor_image_exception.dart`
  — `KyoshinImageParseInvalidGifException`, `KyoshinImageParseInvalidImageSizeException`
- `packages/eqmonitor_map/lib/src/tile/base_map_tile_decoder.dart` — `BaseMapLayerSpec`
- `packages/eqmonitor_map/lib/src/tile/base_map_tile_cache.dart` — `BaseMapTileFallbackChildren`
- `packages/eqmonitor_map/lib/src/tile/scheduler/map_tile_scheduler.dart` — `MapTileScheduler`
- `packages/eqmonitor_map/lib/src/tile/earthquake_area_tile_geometry.dart` — `EarthquakeAreaTileLayerGeometry`
- `app/lib/core/provider/chuck_build_mode_policy.dart` — `ChuckBuildModePolicy`
- `app/lib/feature/auth/data/repository/better_auth_api_client.dart`
  — `_BetterAuthPasskeyClient`, `_BetterAuthSessionEstablishmentFactory`
- `app/lib/feature/auth/data/repository/passkey_repository.dart`
  — `PasskeyRequestParser`, `PasskeyOptionsSchemaValidator`
- `app/lib/feature/auth/data/repository/user_api_client.dart` — `UserApiClient`
- `app/lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart`
  — `LatestEarthquakeOverlayData`
- `app/lib/feature/earthquake_history/data/repository/earthquake_activity_repository.dart`
  — `EarthquakeActivityRepository`
- `app/lib/feature/eew/data/service/eew_warning_overlay_scheduler.dart`
  — `TimerEewWarningOverlayScheduledTask`
- `app/lib/feature/eew/data/service/eew_warning_overlay_vibration_service.dart`
  — `EewWarningOverlayVibrationService`
- `app/lib/feature/intensity_history/data/repository/city_max_intensity_repository.dart`
  — `CityMaxIntensityRepository`
- `app/lib/feature/parameter/data/data_source/parameter_asset_data_source.dart`
  — `ParameterAssetDataSource`
- `app/lib/feature/parameter/data/repository/parameter_repository.dart` — `ParameterRepository`
- `app/lib/feature/seismicity/data/data_source/hypocenter_archive_probe.dart` — `HypocenterArchiveProbe`
- `app/lib/feature/seismicity/data/logic/hypocenter_analysis_loader.dart` — `HypocenterAnalysisLoader`
- `app/lib/feature/seismicity/data/repository/hypocenter_analysis_repository.dart`
  — `HypocenterAnalysisRepository`
- `app/lib/feature/seismicity/data/repository/hypocenter_manifest_repository.dart`
  — `HypocenterManifestRepository`
- `app/lib/feature/settings/children/config/debug/hinet_seismicity/data/repository/hinet_seismicity_repository.dart`
  — `HinetSeismicityRepository`
- `app/lib/feature/shake_detection/data/repository/shake_detection_repository.dart`
  — `ApiShakeDetectionRepository`
- `app/lib/feature/subscription/data/repository/subscription_repository.dart` — `SubscriptionRepository`

対応方針: private フィールドへの代入が目的なら、DI 引数を positional の
`final Dio _dio` にできるか呼び出し側ごとに判断する。assert のみなら
primary constructor body へ移せるか検討する。

## 2. 生成的な名前付きコンストラクタを持つ

primary constructor を持つクラスでは、他の生成的コンストラクタは primary へ
リダイレクトする必要がある。`factory` は共存できるため変換済み。

- `packages/eqmonitor_map/lib/src/geo/tile_id.dart` — `CanonicalTileId`
- `packages/eqmonitor_map/lib/src/tile/earthquake_area_tile_geometry.dart` — `EarthquakeAreaTileGeometry`
- `app/lib/core/component/web_view/app_web_view_navigation_state.dart` — `AppWebViewNavigationState`
- `app/lib/core/designsystem/extensions/design_system_theme_extension.dart` — `DesignSystemThemeExtension`
- `app/lib/core/designsystem/extensions/typography_theme_extension.dart` — `TypographyThemeExtension`
- `app/lib/feature/auth/data/model/debug_auth_state.dart` — `DebugAuthState`
- `app/lib/feature/seismicity/data/data_source/seismicity_cached_dataset.dart` — `SeismicityCachedDataset`

## 3. フィールド宣言が `final` 形式でない

- `app/lib/feature/kyoshin_monitor/ui/components/kyoshin_monitor_scale.dart`
  — `_KyoshinMonitorScalePainter` の `colorStops`
