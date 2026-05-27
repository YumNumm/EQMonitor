import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_merge_provider.g.dart';

/// EEW 結合済みフラグを付与した揺れ検知イベント一覧
@Riverpod(keepAlive: true)
List<ShakeDetectionEvent> shakeDetectionMerged(Ref ref) {
  final shakes = ref.watch(shakeDetectionProvider);
  final eews = ref.watch(eewAliveTelegramProvider) ?? [];
  final travelTimeMap = ref.watch(travelTimeDepthMapProvider);
  final now = ref.read(appClockProvider.notifier).now().toUtc();

  return shakes.map((shake) {
    final mergedId = _findMergedEew(shake, eews, travelTimeMap, now);
    return shake.copyWith(mergedEewEventId: mergedId);
  }).toList();
}

/// EEW と結合する場合はその eventId を返す。しない場合は null。
String? _findMergedEew(
  ShakeDetectionEvent shake,
  List<EewTelegramItem> eews,
  TravelTimeDepthMap travelTimeMap,
  DateTime now,
) {
  final centerLat = (shake.minLat + shake.maxLat) / 2;
  final centerLng = (shake.minLng + shake.maxLng) / 2;
  const distance = latlong2.Distance();

  for (final eew in eews) {
    final hypo = eew.hypocenter;
    if (hypo == null || !hypo.hasLatLng) {
      continue;
    }
    final depth = hypo.depth;
    final originTime = eew.originTime;
    if (depth == null || originTime == null) {
      continue;
    }

    final elapsed = now.difference(originTime.toUtc()).inMilliseconds / 1000;
    final tt = travelTimeMap.getTravelTime(depth, elapsed);

    final pDist = tt.pDistance;
    final sDist = tt.sDistance;
    if (pDist == null || pDist <= 0) {
      continue;
    }

    final distKm =
        distance.as(
          latlong2.LengthUnit.Kilometer,
          latlong2.LatLng(hypo.latitude!, hypo.longitude!),
          latlong2.LatLng(centerLat, centerLng),
        );

    final outerBound = pDist + 25.0;
    final innerBound = (sDist != null && sDist > 25.0) ? sDist - 25.0 : 0.0;

    if (distKm >= innerBound && distKm <= outerBound) {
      return eew.eventId;
    }
  }
  return null;
}

/// 未結合（表示対象）の揺れ検知イベントのみを返す
@Riverpod(keepAlive: true)
List<ShakeDetectionEvent> shakeDetectionVisible(Ref ref) =>
    ref
        .watch(shakeDetectionMergedProvider)
        .where((e) => e.mergedEewEventId == null)
        .toList();
