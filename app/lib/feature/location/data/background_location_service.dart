import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'background_location_service.g.dart';

/// Path A: エンジン稼働中（フォアグラウンド/バックグラウンド）での
/// バックグラウンド位置更新をEEW設定に反映するサービス。
@Riverpod(keepAlive: true)
Stream<void> backgroundLocationService(Ref ref) async* {
  await for (final update in BackgroundLocationTracker.locationStream) {
    try {
      final resolver = await ref.read(jmaRegionResolverProvider.future);
      final code =
          resolver.resolveRegionCode(update.latitude, update.longitude);
      if (code != null) {
        final name =
            resolver.resolveRegionName(update.latitude, update.longitude);
        await ref
            .read(eewSettingsProvider.notifier)
            .updateCurrentLocationRegion(regionCode: code, regionName: name);
      }
    } on Object {
      // バックグラウンドサービスのエラーはサイレントに無視する
    }
    yield null;
  }
}
