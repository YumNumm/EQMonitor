import 'package:image/image.dart' as img;
import 'package:kyoshin_monitor_image_parser/src/model/kyoshin_monitor_observation_point.dart';
import 'package:kyoshin_monitor_image_parser/src/parser/kyoshin_monitor_image_parser.dart';
import 'package:kyoshin_monitor_image_parser/src/worker/kyoshin_monitor_analyzer_isolate.dart';
import 'package:shake_detection_engine/shake_detection_engine.dart';

/// 解析用 Isolate の中で揺れ検知エンジンの状態を保持する。
final class ShakeDetectionWorker {
  new({
    required this.parser,
    required List<NamedObservationPoint> points,
    required this.parsePoints,
  }) : _engine = ShakeDetectionEngine(
         stations: [
           for (final point in points)
             ShakeStationLocation(
               latitude: point.latitude,
               longitude: point.longitude,
             ),
         ],
       );

  final KyoshinMonitorImageParser parser;
  final List<KyoshinMonitorObservationPoint> parsePoints;
  final ShakeDetectionEngine _engine;

  Future<List<ShakeEventSnapshot>> detect({
    required List<KyoshinMonitorImageParseObservationResult> results,
    required ShakeDetectionRequest request,
  }) async {
    final baselineGifs = request.baselineGifs;
    if (baselineGifs != null || _engine.requiresColdStart(request.observedAt)) {
      final frames = <List<double?>>[];
      for (final gif in baselineGifs ?? const []) {
        final image = img.decodeGif(gif);
        if (image == null || image.width != 352 || image.height != 400) {
          continue;
        }
        frames.add(
          toIntensities(await parser.parse(image: image, points: parsePoints)),
        );
      }
      _engine
        ..reset()
        ..seedBaseline(
          frames.isEmpty
              ? ShakeBaseline.constant(
                  stationCount: _engine.stationCount,
                  value: request.fallbackBaseline,
                )
              : ShakeBaseline.fromFrames(frames),
        );
    }
    return _engine.process(
      time: request.observedAt,
      intensities: toIntensities(results),
    );
  }

  List<double?> toIntensities(
    List<KyoshinMonitorImageParseObservationResult> results,
  ) => [
    for (final result in results)
      switch (result) {
        KyoshinMonitorImageParseObservationSuccess(:final point) =>
          point.scaleToIntensity,
        KyoshinMonitorImageParseObservationFailure() => null,
      },
  ];
}
