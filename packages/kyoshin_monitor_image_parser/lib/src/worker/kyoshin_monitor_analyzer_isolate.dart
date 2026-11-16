// ignore_for_file: unreachable_from_main

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:kyoshin_monitor_image_parser/src/exception/kyoshin_monitor_image_exception.dart';
import 'package:kyoshin_monitor_image_parser/src/exception/kyoshin_monitor_worker_exception.dart';
import 'package:kyoshin_monitor_image_parser/src/model/kyoshin_monitor_observation_point.dart';
import 'package:kyoshin_monitor_image_parser/src/parser/kyoshin_monitor_image_parser.dart';
import 'package:kyoshin_monitor_image_parser/src/worker/shake_detection_worker.dart';
import 'package:shake_detection_engine/shake_detection_engine.dart';

final class const AnalyzeResult({
  required final String geoJson,
  required final int featureCount,
  final int? parseMicros,
  final int? geoJsonBuildMicros,

  /// 揺れ検知を要求した場合の検知結果。`points` の `stationIndex` は
  /// spawn に渡した観測点の並びに対応する。
  final List<ShakeEventSnapshot>? shakeEvents,
});

/// 解析した震度画像での揺れ検知の要求。
final class const ShakeDetectionRequest({
  required final DateTime observedAt,

  /// 平常値の算出に使う過去フレーム。`null` でない場合は履歴を破棄して
  /// 検知をやり直す。空の場合は [fallbackBaseline] を平常値とする。
  final List<Uint8List>? baselineGifs,
  final double fallbackBaseline = 1,
  final ShakeDetectionParameters parameters = const ShakeDetectionParameters(),
});

final class const ShakeBackfillFrame({
  required final DateTime observedAt,
  required final Uint8List gif,
});

/// コールドスタート直前のフレームで検知の履歴を作り直す要求。
final class const ShakeBackfillRequest({
  /// 対象のコールドスタートで [ShakeDetectionRequest.observedAt] に渡した時刻。
  required final DateTime coldStartAt,
  required final List<ShakeBackfillFrame> frames,
});

final class KyoshinMonitorAnalyzerIsolate._({
  required final Isolate _isolate,
  required final ReceivePort _mainReceive,
  required final SendPort _workerSendPort,
  required final StreamSubscription<Object?> _subscription,
  required final Map<int, Completer<AnalyzeResult>> _pending,
  required final Map<int, Completer<List<ShakeEventSnapshot>?>>
  _pendingBackfills,
  required final Completer<void> _exited,
}) {
  var _nextId = 0;

  /// [points] をキャッシュして解析用 Isolate を起動する。
  static Future<KyoshinMonitorAnalyzerIsolate> spawn({
    required List<NamedObservationPoint> points,
  }) async {
    final mainReceive = ReceivePort();
    final workerPortCompleter = Completer<SendPort>();
    final initAck = Completer<void>();
    final pending = <int, Completer<AnalyzeResult>>{};
    final pendingBackfills = <int, Completer<List<ShakeEventSnapshot>?>>{};
    final exited = Completer<void>();

    late final StreamSubscription<Object?> subscription;
    subscription = mainReceive.listen((message) {
      // onExit 通知。worker が異常終了した場合に応答待ちが永久に残らないよう、
      // 待機中のすべての要求を失敗させる。
      if (message == null) {
        if (!exited.isCompleted) {
          exited.complete();
        }
        const error = KyoshinMonitorWorkerExitedException();
        if (!workerPortCompleter.isCompleted) {
          workerPortCompleter.completeError(error);
        }
        if (!initAck.isCompleted) {
          initAck.completeError(error);
        }
        final waiting = pending.values.toList();
        pending.clear();
        for (final c in waiting) {
          c.completeError(error);
        }
        final waitingBackfills = pendingBackfills.values.toList();
        pendingBackfills.clear();
        for (final c in waitingBackfills) {
          c.completeError(error);
        }
        return;
      }
      if (message is SendPort) {
        if (!workerPortCompleter.isCompleted) {
          workerPortCompleter.complete(message);
        }
        return;
      }
      if (message is _InitAck) {
        if (!initAck.isCompleted) {
          initAck.complete();
        }
        return;
      }
      if (message is _BackfillResponseMessage) {
        final c = pendingBackfills.remove(message.id);
        if (c == null) {
          return;
        }
        final errorMessage = message.errorMessage;
        if (errorMessage == null) {
          c.complete(message.events);
        } else {
          c.completeError(
            KyoshinMonitorWorkerException(
              errorMessage,
              StackTrace.fromString(message.errorStack ?? ''),
            ),
          );
        }
        return;
      }
      if (message is _AnalyzeResponseMessage) {
        final c = pending.remove(message.id);
        if (c == null) {
          return;
        }
        final result = message.result;
        if (result == null) {
          c.completeError(
            KyoshinMonitorWorkerException(
              message.errorMessage ?? 'unknown',
              StackTrace.fromString(message.errorStack ?? ''),
            ),
          );
        } else {
          c.complete(result);
        }
      }
    });

    late final Isolate isolate;
    late final SendPort workerSendPort;
    try {
      isolate = await Isolate.spawn(
        _workerEntryPoint,
        mainReceive.sendPort,
        debugName: 'kyoshin_monitor_analyzer',
        onExit: mainReceive.sendPort,
      );

      workerSendPort = await workerPortCompleter.future;
      workerSendPort.send(_InitMessage(points: points));
      await initAck.future;
    } on Object {
      await subscription.cancel();
      mainReceive.close();
      rethrow;
    }

    return KyoshinMonitorAnalyzerIsolate._(
      isolate: isolate,
      mainReceive: mainReceive,
      workerSendPort: workerSendPort,
      subscription: subscription,
      pending: pending,
      pendingBackfills: pendingBackfills,
      exited: exited,
    );
  }

  /// GIF バイト列を解析し GeoJSON 文字列を返す。
  ///
  /// 震度以外の画像では [isShindo] を false にして、震度への換算を行わない。
  /// [shakeDetection] は地上の震度画像に対してのみ指定する。
  Future<AnalyzeResult> analyze(
    Uint8List gifBytes, {
    bool isShindo = true,
    ShakeDetectionRequest? shakeDetection,
  }) {
    if (_exited.isCompleted) {
      return Future.error(const KyoshinMonitorWorkerExitedException());
    }
    final id = _nextId++;
    final completer = Completer<AnalyzeResult>();
    _pending[id] = completer;
    _workerSendPort.send(
      _AnalyzeMessage(
        id: id,
        gifBytes: gifBytes,
        isShindo: isShindo,
        shakeDetection: shakeDetection,
      ),
    );
    return completer.future;
  }

  /// コールドスタート直前のフレームで揺れ検知の履歴を作り直す。
  ///
  /// 対象のコールドスタートが既に無効な場合や、使えるフレームが無い場合は
  /// `null` を返す。
  Future<List<ShakeEventSnapshot>?> backfillShakeDetection(
    ShakeBackfillRequest request,
  ) {
    if (_exited.isCompleted) {
      return Future.error(const KyoshinMonitorWorkerExitedException());
    }
    final id = _nextId++;
    final completer = Completer<List<ShakeEventSnapshot>?>();
    _pendingBackfills[id] = completer;
    _workerSendPort.send(_BackfillMessage(id: id, request: request));
    return completer.future;
  }

  Future<void> dispose() async {
    _workerSendPort.send(const _ShutdownMessage());
    await _subscription.cancel();
    _mainReceive.close();
    _isolate.kill(priority: Isolate.immediate);
  }
}

final class const _InitMessage({
  required final List<NamedObservationPoint> points,
});

final class const _InitAck();

final class const _AnalyzeMessage({
  required final int id,
  required final Uint8List gifBytes,
  required final bool isShindo,
  required final ShakeDetectionRequest? shakeDetection,
});

final class const _ShutdownMessage();

final class const _BackfillMessage({
  required final int id,
  required final ShakeBackfillRequest request,
});

final class const _BackfillResponseMessage({
  required final int id,
  final List<ShakeEventSnapshot>? events,
  final String? errorMessage,
  final String? errorStack,
});

final class const _AnalyzeResponseMessage({
  required final int id,
  final AnalyzeResult? result,
  final String? errorMessage,
  final String? errorStack,
});

@pragma('vm:entry-point')
void _workerEntryPoint(SendPort mainSendPort) {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);

  var namedPoints = <NamedObservationPoint>[];
  var parsePoints = <KyoshinMonitorObservationPoint>[];
  final parser = KyoshinMonitorImageParser();
  ShakeDetectionWorker? shakeDetection;
  var chain = Future<void>.value();

  receivePort.listen((message) {
    if (message is _InitMessage) {
      namedPoints = message.points;
      parsePoints = namedPoints
          .map(
            (e) => KyoshinMonitorObservationPoint(code: e.code, x: e.x, y: e.y),
          )
          .toList();
      shakeDetection = null;
      mainSendPort.send(const _InitAck());
      return;
    }
    if (message is _ShutdownMessage) {
      receivePort.close();
      return;
    }
    if (message is _BackfillMessage) {
      final detector = shakeDetection;
      chain = chain.then((_) async {
        try {
          mainSendPort.send(
            _BackfillResponseMessage(
              id: message.id,
              events: await detector?.backfill(message.request),
            ),
          );
        } on Object catch (e, st) {
          mainSendPort.send(
            _BackfillResponseMessage(
              id: message.id,
              errorMessage: e.toString(),
              errorStack: st.toString(),
            ),
          );
        }
      });
      return;
    }
    if (message is _AnalyzeMessage) {
      final detector = message.shakeDetection == null
          ? null
          : shakeDetection ??= ShakeDetectionWorker(
              parser: parser,
              points: namedPoints,
              parsePoints: parsePoints,
            );
      chain = chain.then(
        (_) => _runAnalyze(
          mainSendPort,
          parser,
          namedPoints,
          parsePoints,
          detector,
          message,
        ),
      );
    }
  });
}

Future<void> _runAnalyze(
  SendPort mainSendPort,
  KyoshinMonitorImageParser parser,
  List<NamedObservationPoint> namedPoints,
  List<KyoshinMonitorObservationPoint> parsePoints,
  ShakeDetectionWorker? shakeDetection,
  _AnalyzeMessage message,
) async {
  try {
    final sw = Stopwatch()..start();
    final image = img.decodeGif(message.gifBytes);
    if (image == null) {
      throw const KyoshinImageParseInvalidGifException();
    }
    final results = await parser.parse(image: image, points: parsePoints);
    sw.stop();
    final parseMicros = sw.elapsedMicroseconds;

    final sw2 = Stopwatch()..start();
    final built = _buildGeoJsonString(
      results,
      namedPoints,
      isShindo: message.isShindo,
    );
    sw2.stop();
    final geoMicros = sw2.elapsedMicroseconds;

    final request = message.shakeDetection;
    final shakeEvents = shakeDetection == null || request == null
        ? null
        : await shakeDetection.detect(results: results, request: request);

    mainSendPort.send(
      _AnalyzeResponseMessage(
        id: message.id,
        result: AnalyzeResult(
          geoJson: built.$1,
          featureCount: built.$2,
          parseMicros: parseMicros,
          geoJsonBuildMicros: geoMicros,
          shakeEvents: shakeEvents,
        ),
      ),
    );
  } on Object catch (e, st) {
    mainSendPort.send(
      _AnalyzeResponseMessage(
        id: message.id,
        errorMessage: e.toString(),
        errorStack: st.toString(),
      ),
    );
  }
}

(String, int) _buildGeoJsonString(
  List<KyoshinMonitorImageParseObservationResult> parseResults,
  List<NamedObservationPoint> namedPoints, {
  required bool isShindo,
}) {
  final sb = StringBuffer('{"type":"FeatureCollection","features":[');
  var first = true;
  var count = 0;
  for (var i = 0; i < parseResults.length; i++) {
    final r = parseResults[i];
    if (r is! KyoshinMonitorImageParseObservationSuccess) {
      continue;
    }
    final named = namedPoints[i];
    final obs = r.point;
    if (!first) {
      sb.write(',');
    }
    first = false;
    count++;
    final colorHex =
        '#${obs.r.toRadixString(16).padLeft(2, '0')}'
                '${obs.g.toRadixString(16).padLeft(2, '0')}'
                '${obs.b.toRadixString(16).padLeft(2, '0')}'
            .toUpperCase();
    sb
      ..write('{"type":"Feature","geometry":{"type":"Point","coordinates":[')
      ..write(named.longitude.toStringAsFixed(6))
      ..write(',')
      ..write(named.latitude.toStringAsFixed(6))
      ..write(']},"properties":{"color":"')
      ..write(colorHex)
      ..write('"');
    if (isShindo) {
      sb
        ..write(',"intensity":')
        ..write(obs.scaleToIntensity);
    }
    sb
      ..write(',"name":')
      ..write(jsonEncode(named.name))
      ..write('}}');
  }
  sb.write(']}');
  return (sb.toString(), count);
}
