import 'package:eqmonitor/feature/parameter/data/model/kyoshin/kyoshin_observation_points_parameter.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shake_detection_engine/shake_detection_engine.dart';
import 'package:shake_eew_correlator/shake_eew_correlator.dart';

part 'shake_detection_event_assembler.g.dart';

@riverpod
ShakeDetectionEventAssembler shakeDetectionEventAssembler(Ref ref) =>
    const ShakeDetectionEventAssembler();

class const ShakeDetectionEventAssembler() {
  /// 確定した検知イベントに観測点の情報と EEW との結合結果を付ける。
  ///
  /// [stations] は検知エンジンに渡した観測点と同じ並びであること。
  /// [correlator] が `null`（走時表が未読込）の場合は結合せずに返す。
  List<ShakeDetectionEvent> assemble({
    required List<ShakeEventSnapshot> snapshots,
    required List<KyoshinObservationPoint> stations,
    required ShakeEewCorrelator? correlator,
    required List<CorrelationEew> eews,
    required DateTime now,
  }) => [
    for (final snapshot in snapshots)
      if (snapshot.isConfirmed)
        ShakeDetectionEvent(
          eventId: snapshot.id,
          createdAt: snapshot.createdAt,
          updatedAt: snapshot.updatedAt,
          expiresAt: snapshot.expiresAt,
          level: switch (snapshot.level) {
            .weaker => ShakeDetectionLevel.weaker,
            .weak => ShakeDetectionLevel.weak,
            .medium => ShakeDetectionLevel.medium,
            .strong => ShakeDetectionLevel.strong,
            .stronger => ShakeDetectionLevel.stronger,
          },
          pointCount: snapshot.points.length,
          minLat: snapshot.minLatitude,
          maxLat: snapshot.maxLatitude,
          minLng: snapshot.minLongitude,
          maxLng: snapshot.maxLongitude,
          correlatedEewEventId: correlator
              ?.correlate(
                eews: eews,
                shake: ShakeObservation(
                  eventId: snapshot.id,
                  createdAt: snapshot.createdAt,
                  isBootstrap: snapshot.isBootstrap,
                  points: [
                    for (final point in snapshot.points)
                      if (stations.elementAtOrNull(point.stationIndex)
                          case final station?)
                        ShakeObservationPoint(
                          latitude: station.location.lat,
                          longitude: station.location.lon,
                          intensity: point.intensity,
                          arv: station.arv400,
                        ),
                  ],
                ),
                now: now,
              )
              ?.eewEventId,
          points: [
            for (final point in snapshot.points)
              if (stations.elementAtOrNull(point.stationIndex)
                  case final station?)
                ShakeDetectionPoint(
                  code: station.code,
                  name: station.name,
                  latitude: station.location.lat,
                  longitude: station.location.lon,
                  intensity: point.intensity,
                  intensityDiff: point.intensityDiff,
                  prefectureCode: station.prefectureCode,
                  regionCode: station.regionCode,
                ),
          ],
        ),
  ];
}
