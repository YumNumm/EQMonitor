import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:kyoshin_monitor_image_parser/src/model/kyoshin_monitor_observation_point.dart';
import 'package:kyoshin_monitor_image_parser/src/parser/kyoshin_monitor_image_parser.dart';
import 'package:kyoshin_monitor_image_parser/src/worker/kyoshin_monitor_analyzer_isolate.dart';
import 'package:shake_detection_engine/shake_detection_engine.dart';

/// 解析用 Isolate の中で揺れ検知エンジンの状態を保持する。
final class ShakeDetectionWorker({
  required final KyoshinMonitorImageParser parser,
  required List<NamedObservationPoint> points,
  required final List<KyoshinMonitorObservationPoint> parsePoints,
}) {
  /// 過去フレームの取得を待つ間に保持する、コールドスタート以降のフレーム数の上限。
  static const maxPendingFrames = 30;

  final List<ShakeStationLocation> _stations = [
    for (final point in points)
      ShakeStationLocation(
        latitude: point.latitude,
        longitude: point.longitude,
      ),
  ];

  ShakeDetectionEngine? _engine;
  DateTime? _coldStartAt;
  ShakeBaseline? _coldStartBaseline;
  var _baselineFrameCount = 0;
  List<({DateTime time, List<double?> intensities})>? _framesSinceColdStart;

  Future<List<ShakeEventSnapshot>> detect({
    required List<KyoshinMonitorImageParseObservationResult> results,
    required ShakeDetectionRequest request,
  }) async {
    var engine = _engine;
    // 近傍の重みはパラメータに依存するため、変更時はエンジンを作り直す。
    if (engine == null || engine.parameters != request.parameters) {
      engine = _engine = ShakeDetectionEngine(
        stations: _stations,
        parameters: request.parameters,
      );
    }

    final baselineGifs = request.baselineGifs;
    if (baselineGifs != null || engine.requiresColdStart(request.observedAt)) {
      final frames = <List<double?>>[];
      for (final gif in baselineGifs ?? const <Uint8List>[]) {
        final intensities = await decode(gif);
        if (intensities != null) {
          frames.add(intensities);
        }
      }
      final baseline = frames.isEmpty
          ? ShakeBaseline.constant(
              stationCount: engine.stationCount,
              value: request.fallbackBaseline,
            )
          : ShakeBaseline.fromFrames(frames);
      engine
        ..reset()
        ..seedBaseline(baseline);
      _coldStartAt = request.observedAt;
      _coldStartBaseline = baseline;
      _baselineFrameCount = frames.length;
      _framesSinceColdStart = [];
    }

    final intensities = toIntensities(results);
    final pending = _framesSinceColdStart;
    if (pending != null) {
      if (pending.length >= maxPendingFrames) {
        _framesSinceColdStart = null;
      } else {
        pending.add((time: request.observedAt, intensities: intensities));
      }
    }
    return engine.process(time: request.observedAt, intensities: intensities);
  }

  List<ShakeStationStatus>? get stationStatuses => _engine?.stationStatuses;

  ShakeDetectionStatus? get status {
    final coldStartAt = _coldStartAt;
    if (coldStartAt == null) {
      return null;
    }
    return ShakeDetectionStatus(
      coldStartAt: coldStartAt,
      baselineFrameCount: _baselineFrameCount,
    );
  }

  /// コールドスタート直前のフレームから履歴を作り直す。
  ///
  /// 平常値の投入から始めて [ShakeBackfillRequest.frames] とコールドスタート
  /// 以降のフレームを流し直すため、連続して動いていた場合に近い状態になる。
  /// 対象のコールドスタートが既に無効な場合は `null` を返す。
  Future<List<ShakeEventSnapshot>?> backfill(
    ShakeBackfillRequest request,
  ) async {
    final engine = _engine;
    final baseline = _coldStartBaseline;
    final pending = _framesSinceColdStart;
    if (engine == null ||
        baseline == null ||
        pending == null ||
        _coldStartAt != request.coldStartAt) {
      return null;
    }
    _framesSinceColdStart = null;

    final history = <({DateTime time, List<double?> intensities})>[];
    for (final frame in request.frames) {
      if (!frame.observedAt.isBefore(request.coldStartAt)) {
        continue;
      }
      final intensities = await decode(frame.gif);
      if (intensities != null) {
        history.add((time: frame.observedAt, intensities: intensities));
      }
    }
    if (history.isEmpty) {
      return null;
    }
    history.sort((a, b) => a.time.compareTo(b.time));

    final previous = engine.events;
    engine
      ..reset()
      ..seedBaseline(baseline);
    for (final frame in [...history, ...pending]) {
      engine.process(time: frame.time, intensities: frame.intensities);
    }
    engine.adoptEventIds(previous);
    return engine.events;
  }

  Future<List<double?>?> decode(Uint8List gif) async {
    final image = img.decodeGif(gif);
    if (image == null || image.width != 352 || image.height != 400) {
      return null;
    }
    return toIntensities(await parser.parse(image: image, points: parsePoints));
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
