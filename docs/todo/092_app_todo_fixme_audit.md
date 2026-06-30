# App TODO/FIXME and Unimplemented Marker Audit

- Date: 2026-06-30
- Scope: `app/` and Flutter/Dart-side `packages/`
- Out of scope: `backend/`, `docs/`, `tools/`, `utils/`, `terraform/`, `supabase/`
- Raw hits: `app/` 23 lines, `packages/` 20 lines
- `FIXME` hits: 0

Search commands used:

```sh
rg -n --hidden -S "\b(TODO|FIXME|XXX|HACK)\b|未実装|後で実装|あとで実装" app
rg -n --hidden -S "throw UnimplementedError|UnimplementedError\(|FlutterMethodNotImplemented|throw UnsupportedError|UnsupportedError\(" app
rg -n --hidden -S "\b(TODO|FIXME|XXX|HACK)\b|未実装|後で実装|あとで実装" packages
rg -n --hidden -S "throw UnimplementedError|UnimplementedError\(|FlutterMethodNotImplemented|throw UnsupportedError|UnsupportedError\(" packages
```

## High-priority follow-up candidates

| Location | Marker | Note |
| --- | --- | --- |
| `app/ios/Widget/Widget.swift:52` | `TODO(YumNumm)` | Current-location widget mode still returns hard-coded region code `"350"` while the comment says location should be read from `UserDefaults`. Because this can affect location-specific earthquake information, replace the fixed value or disable current-location mode until real data is available. |
| `packages/eqmonitor_api/lib/src/models/get_v2_subscription_me_response_union.dart:33` | `TODO: No discriminator...` | Generated `fromJson` still contains the manual-implementation TODO for subscription status union parsing. |
| `packages/eqmonitor_api/lib/src/models/get_v2_subscription_me_response_union.dart:45` | `throw UnimplementedError()` | Same subscription union parser will throw at runtime if `GetV2SubscriptionMeResponseUnion.fromJson` is used. Add a generator patch similar to the existing union patches in `packages/eqmonitor_api/bin/generate.dart`, then regenerate. |

## App-side comments

| Location | Marker | Note |
| --- | --- | --- |
| `app/ios/scripts/patch_purchases_paywall_color.sh:6` | `TODO` | Temporary RevenueCat workaround. Remove after `purchases-hybrid-common` pins `purchases-ios-spm >= 5.78.0`. |
| `app/ios/Widget/Widget.swift:52` | `TODO(YumNumm)` | Current-location widget region lookup is not implemented and currently falls back to `"350"`. |
| `app/lib/feature/fnet_catalog/ui/components/fnet_catalog_list_tile.dart:23` | `後で実装` | Comment says navigation to a details page is future work, but the tap handler already opens `_showDetails(context)` as a modal sheet. Confirm intended UX and either update the comment or replace the modal with real navigation. |
| `app/ios/Widget/LiveActivity/Eew/EewLiveActivityView.swift:57` | `XXX` | Appears to be example placeholder text in a comment (`"XXXで地震"`), not an actionable TODO. |

## App-side UnimplementedError and UnsupportedError

### Provider injection placeholders

These providers intentionally throw until `main.dart` supplies overrides. `app/lib/main.dart:226` through `app/lib/main.dart:242` currently override all of them during startup when their platform data is available.

| Location | Marker | Note |
| --- | --- | --- |
| `app/lib/core/provider/device_info.dart:7` | `throw UnimplementedError()` | Base provider for `AndroidDeviceInfo`; overridden from startup on Android. |
| `app/lib/core/provider/device_info.dart:10` | `throw UnimplementedError()` | Base provider for `IosDeviceInfo`; overridden from startup on iOS. |
| `app/lib/core/provider/application_documents_directory.dart:8` | `throw UnimplementedError()` | Base provider for app document directory; overridden from startup when available. |
| `app/lib/core/provider/package_info.dart:7` | `throw UnimplementedError()` | Base provider for package info; overridden from startup. |
| `app/lib/core/provider/shared_preferences.dart:32` | `throw UnimplementedError(...)` | Base provider for compatibility wrapper; message explicitly says it must be overridden in `main`. |
| `app/lib/feature/kyoshin_monitor/data/provider/kyoshin_color_map.dart:10` | `throw UnimplementedError()` | Base provider for Kyoshin color map; overridden from startup when not web. |
| `app/lib/feature/telemetry/data/provider/telemetry_database_provider.dart:31` | `throw UnimplementedError(...)` | Base provider for telemetry DB path; overridden from startup with resolved path when not web. |

### Runtime guards and platform guards

| Location | Marker | Note |
| --- | --- | --- |
| `app/lib/firebase_options.dart:30` | `throw UnsupportedError(...)` | Generated FlutterFire guard for unconfigured Windows Firebase options. |
| `app/lib/firebase_options.dart:35` | `throw UnsupportedError(...)` | Generated FlutterFire guard for unconfigured Linux Firebase options. |
| `app/lib/firebase_options.dart:40` | `throw UnsupportedError(...)` | Generated FlutterFire guard for unsupported Fuchsia Firebase options. |
| `app/lib/core/router/router.g.dart:1664` | `throw UnsupportedError(...)` | Generated go_router bool converter guard for invalid route query values. |
| `app/lib/feature/live_activity/data/provider/eqm_live_activity_util.dart:12` | `throw UnsupportedError(...)` | Platform guard: live activity utility only supports iOS and macOS. |
| `app/lib/feature/settings/data/contact/contact_action.dart:32` | `throw UnsupportedError(...)` | Contact URL builder supports Android and iOS only. Consider user-facing behavior for desktop/web if those builds are expected. |
| `app/ios/Runner/AppGroupMethodChannel.swift:43` | `FlutterMethodNotImplemented` | Native MethodChannel default branch. This is the standard response for unknown method names. |

### Map/data shape guards

| Location | Marker | Note |
| --- | --- | --- |
| `app/lib/core/provider/map/jma_map_utility.dart:51` | `throw UnimplementedError(...)` | Tsunami map lookup supports line geometries and throws if polygon data appears. This is acceptable only if asset generation guarantees tsunami data is line-based. |
| `app/lib/core/provider/map/jma_map_utility.dart:79` | `throw UnimplementedError(...)` | Non-tsunami lookup supports polygon geometries and throws if line data appears. This relies on asset data shape guarantees. |
| `app/lib/core/provider/map/jma_map_provider.dart:41` | `throw UnimplementedError()` | Enum conversion guard for unknown generated `JmaMapType`. Prefer `ArgumentError` or explicit handling if new map types are expected. |
| `app/lib/feature/settings/features/display_settings/ui/display_settings.dart:85` | `throw UnimplementedError()` | Guard in a light/dark-only theme choice switch. Currently unreachable because callers pass only `ThemeMode.light` and `ThemeMode.dark`. |
| `app/lib/feature/settings/features/display_settings/ui/display_settings.dart:93` | `throw UnimplementedError()` | Same light/dark-only theme label guard. |

### Test-only guards

| Location | Marker | Note |
| --- | --- | --- |
| `app/test/feature/location/background_location_update_notifier_test.dart:107` | `throw UnimplementedError(...)` | Test interceptor guard for unhandled method/path. Intentional fail-fast behavior. |
| `app/test/feature/settings/features/notification_settings/notification_slot_repository_test.dart:165` | `throw UnimplementedError(...)` | Test interceptor guard for unhandled method/path. Intentional fail-fast behavior. |

## Package-side TODO and README placeholders

| Location | Marker | Note |
| --- | --- | --- |
| `packages/extensions/README.md:14` | `TODO` | Dart package template description remains. |
| `packages/extensions/README.md:19` | `TODO` | Dart package template features section remains. |
| `packages/extensions/README.md:23` | `TODO` | Dart package template getting-started section remains. |
| `packages/extensions/README.md:28` | `TODO` | Dart package template usage section remains. |
| `packages/extensions/README.md:37` | `TODO` | Dart package template additional-information section remains. |
| `packages/lat_lng/README.md:14` | `TODO` | Dart package template description remains. |
| `packages/lat_lng/README.md:19` | `TODO` | Dart package template features section remains. |
| `packages/lat_lng/README.md:23` | `TODO` | Dart package template getting-started section remains. |
| `packages/lat_lng/README.md:28` | `TODO` | Dart package template usage section remains. |
| `packages/lat_lng/README.md:37` | `TODO` | Dart package template additional-information section remains. |
| `packages/eqmonitor_api/bin/generate.dart:562` | `UnimplementedError` mention | Generator comment explains that `swagger_parser` emits union stubs. Not actionable by itself. |
| `packages/eqmonitor_api/bin/generate.dart:568` | `TODO` mention | Example pattern in generator comment. Not actionable by itself. |
| `packages/eqmonitor_api/bin/generate.dart:569` | `UnimplementedError` mention | Example pattern in generator comment. Not actionable by itself. |
| `packages/eqmonitor_api/bin/generate.dart:586` | `UnimplementedError` mention | Regex used by the generator patcher. Not actionable by itself. |

## Package-side UnimplementedError and UnsupportedError

| Location | Marker | Note |
| --- | --- | --- |
| `packages/eqmonitor_api/lib/src/models/get_v2_subscription_me_response_union.dart:45` | `throw UnimplementedError()` | Real generated model stub. See high-priority follow-up section. |
| `packages/jma_map/bin/jma_map.dart:177` | `throw UnimplementedError(...)` | Asset generator throws for unsupported geometry types. This is a generator guard, not app runtime code. |
| `packages/jma_map/bin/jma_map.dart:193` | `throw UnimplementedError()` | Asset generator throws for unknown `JmaMapType`. Prefer explicit error detail if this branch is expected to help future debugging. |
| `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/BackgroundLocationPlugin.swift:51` | `FlutterMethodNotImplemented` | Native plugin MethodChannel default branch. Standard response for unknown method names. |
| `packages/live_activity_util/hook/build.dart:25` | `throw UnsupportedError(...)` | Build hook rejects static linking. This appears intentional and includes a clear log message. |

## Suggested cleanup order

1. Replace or remove the hard-coded widget current-location region fallback at `app/ios/Widget/Widget.swift:52`.
2. Patch `GetV2SubscriptionMeResponseUnion.fromJson` generation and regenerate `packages/eqmonitor_api`.
3. Decide whether `FnetCatalogListTile` should keep the modal detail sheet or navigate to a details page, then update the stale comment.
4. Remove the RevenueCat patch script once the dependency floor makes it unnecessary.
5. Replace template README TODOs for `packages/extensions` and `packages/lat_lng`, or mark those packages private/internal if README polish is intentionally deferred.
