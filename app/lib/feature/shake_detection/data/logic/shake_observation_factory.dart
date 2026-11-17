import 'package:eqmonitor/feature/parameter/data/model/kyoshin/kyoshin_observation_points_parameter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shake_detection_engine/shake_detection_engine.dart';
import 'package:shake_eew_correlator/shake_eew_correlator.dart';

part 'shake_observation_factory.g.dart';

@riverpod
ShakeObservationFactory shakeObservationFactory(Ref ref) =>
    const ShakeObservationFactory();

class const ShakeObservationFactory() {
  /// EEW との結合判定に渡す観測値を組み立てる。
  ///
  /// 観測点はイベントの終了まで残るため、収まった観測点が判定を崩さないよう、
  /// 最新値ではなくイベント中の最大震度を使う。
  /// [stations] は検知エンジンに渡した観測点と同じ並びであること。
  ShakeObservation create({
    required ShakeEventSnapshot snapshot,
    required List<KyoshinObservationPoint> stations,
  }) => ShakeObservation(
    eventId: snapshot.id,
    isBootstrap: snapshot.isBootstrap,
    points: [
      for (final point in snapshot.points)
        if (stations.elementAtOrNull(point.stationIndex) case final station?)
          ShakeObservationPoint(
            latitude: station.location.lat,
            longitude: station.location.lon,
            detectedAt: point.detectedAt,
            intensity: point.peakIntensity ?? point.intensity,
            arv: station.arv400,
          ),
    ],
  );
}
