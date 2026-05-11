import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'background_location_service.g.dart';

/// エンジン稼働中（フォアグラウンド/バックグラウンド）での位置更新と、
/// killed状態でheadless runnerが永続化した位置情報の両方をEEW設定に反映する。
///
/// 起動時に1度だけ pending 位置を取り出し、続けて live ストリームを listen する。
/// `keepAlive: true` のため、boot 時に `ref.read` で1度だけ起動する想定。
@Riverpod(keepAlive: true)
Stream<void> backgroundLocationService(Ref ref) async* {
  // killed状態で永続化された位置を最優先で反映する。
  await _applyPendingLocation(ref);
  yield null;

  // 現在地リージョンが既に登録されているなら毎回 startMonitoring を再宣言し、
  // 端末再起動などで監視が落ちていても復帰させる。
  await _ensureMonitoring(ref);

  await for (final update in BackgroundLocationTracker.locationStream) {
    await _applyLocation(ref, update.latitude, update.longitude);
    yield null;
  }
}

Future<void> _ensureMonitoring(Ref ref) async {
  try {
    final settings = await ref.read(eewSettingsProvider.future);
    if (!settings.regions.any((r) => r.isCurrentLocation)) {
      return;
    }
    await BackgroundLocationTracker.startMonitoring();
  } on Object {
    // バックグラウンドサービスのエラーはサイレントに無視する
  }
}

Future<void> _applyPendingLocation(Ref ref) async {
  try {
    await ref.read(eewSettingsProvider.future);
    final pending = await BackgroundLocationTracker.consumePendingLocation();
    if (pending == null) {
      return;
    }
    await _applyLocation(ref, pending.latitude, pending.longitude);
  } on Object {
    // バックグラウンドサービスのエラーはサイレントに無視する
  }
}

Future<void> _applyLocation(Ref ref, double latitude, double longitude) async {
  try {
    await ref.read(eewSettingsProvider.future);
    final resolver = await ref.read(jmaRegionResolverProvider.future);
    final code = resolver.resolveRegionCode(latitude, longitude);
    if (code == null) {
      return;
    }
    final name = resolver.resolveRegionName(latitude, longitude);
    await ref
        .read(eewSettingsProvider.notifier)
        .updateCurrentLocationRegion(regionCode: code, regionName: name);
  } on Object {
    // バックグラウンドサービスのエラーはサイレントに無視する
  }
}
