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

/// GIF 解析と GeoJSON 文字列生成を Worker Isolate で行う結果。
final class AnalyzeResult {
  const AnalyzeResult({
    required this.geoJson,
    required this.featureCount,
    this.parseMicros,
    this.geoJsonBuildMicros,
  });

  final String geoJson;
  final int featureCount;
  final int? parseMicros;
  final int? geoJsonBuildMicros;
}

/// 常駐 Worker Isolate へのハンドル。
final class KyoshinMonitorAnalyzerIsolate {
  KyoshinMonitorAnalyzerIsolate._({
    required Isolate isolate,
    required ReceivePort mainReceive,
    required SendPort workerSendPort,
    required StreamSubscription<Object?> subscription,
    required Map<int, Completer<AnalyzeResult>> pending,
  }) : _isolate = isolate,
       _mainReceive = mainReceive,
       _workerSendPort = workerSendPort,
       _subscription = subscription,
       _pending = pending;

  final Isolate _isolate;
  final ReceivePort _mainReceive;
  final SendPort _workerSendPort;
  final StreamSubscription<Object?> _subscription;
  final Map<int, Completer<AnalyzeResult>> _pending;

  var _nextId = 0;

  /// [points] をキャッシュして解析用 Isolate を起動する。
  static Future<KyoshinMonitorAnalyzerIsolate> spawn({
    required List<NamedObservationPoint> points,
  }) async {
    final mainReceive = ReceivePort();
    final workerPortCompleter = Completer<SendPort>();
    final initAck = Completer<void>();
    final pending = <int, Completer<AnalyzeResult>>{};

    late final StreamSubscription<Object?> subscription;
    subscription = mainReceive.listen((message) {
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
      if (message is _AnalyzeResponseMessage) {
        final c = pending.remove(message.id);
        if (c == null) {
          return;
        }
        if (message.result != null) {
          c.complete(message.result!);
        } else {
          final st = message.errorStack != null
              ? StackTrace.fromString(message.errorStack!)
              : StackTrace.empty;
          c.completeError(
            KyoshinMonitorWorkerException(
              message.errorMessage ?? 'unknown',
              st,
            ),
            st,
          );
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
      );

      workerSendPort = await workerPortCompleter.future;
      workerSendPort.send(_InitMessage(points));
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
    );
  }

  /// GIF バイト列を解析し GeoJSON 文字列を返す。
  Future<AnalyzeResult> analyze(Uint8List gifBytes) {
    final id = _nextId++;
    final completer = Completer<AnalyzeResult>();
    _pending[id] = completer;
    _workerSendPort.send(_AnalyzeMessage(id, gifBytes));
    return completer.future;
  }

  Future<void> dispose() async {
    _workerSendPort.send(const _ShutdownMessage());
    await _subscription.cancel();
    _mainReceive.close();
    _isolate.kill(priority: Isolate.immediate);
  }
}

final class _InitMessage {
  const _InitMessage(this.points);

  final List<NamedObservationPoint> points;
}

final class _InitAck {
  const _InitAck();
}

final class _AnalyzeMessage {
  const _AnalyzeMessage(this.id, this.gifBytes);

  final int id;
  final Uint8List gifBytes;
}

final class _ShutdownMessage {
  const _ShutdownMessage();
}

final class _AnalyzeResponseMessage {
  const _AnalyzeResponseMessage({
    required this.id,
    this.result,
    this.errorMessage,
    this.errorStack,
  });

  final int id;
  final AnalyzeResult? result;
  final String? errorMessage;
  final String? errorStack;
}

@pragma('vm:entry-point')
void _workerEntryPoint(SendPort mainSendPort) {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);

  var namedPoints = <NamedObservationPoint>[];
  var parsePoints = <KyoshinMonitorObservationPoint>[];
  final parser = KyoshinMonitorImageParser();
  var chain = Future<void>.value();

  receivePort.listen((message) {
    if (message is _InitMessage) {
      namedPoints = message.points;
      parsePoints = namedPoints
          .map(
            (e) => KyoshinMonitorObservationPoint(code: e.code, x: e.x, y: e.y),
          )
          .toList();
      mainSendPort.send(const _InitAck());
      return;
    }
    if (message is _ShutdownMessage) {
      receivePort.close();
      return;
    }
    if (message is _AnalyzeMessage) {
      chain = chain.then(
        (_) => _runAnalyze(
          mainSendPort,
          parser,
          namedPoints,
          parsePoints,
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
    final built = _buildGeoJsonString(results, namedPoints);
    sw2.stop();
    final geoMicros = sw2.elapsedMicroseconds;

    mainSendPort.send(
      _AnalyzeResponseMessage(
        id: message.id,
        result: AnalyzeResult(
          geoJson: built.$1,
          featureCount: built.$2,
          parseMicros: parseMicros,
          geoJsonBuildMicros: geoMicros,
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
  List<NamedObservationPoint> namedPoints,
) {
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
    final intensity = obs.scaleToIntensity;
    final colorHex = _colorHex(obs.r, obs.g, obs.b);
    sb
      ..write('{"type":"Feature","geometry":{"type":"Point","coordinates":[')
      ..write(named.longitude.toStringAsFixed(6))
      ..write(',')
      ..write(named.latitude.toStringAsFixed(6))
      ..write(']},"properties":{"color":"')
      ..write(colorHex)
      ..write('","intensity":')
      ..write(intensity)
      ..write(',"name":')
      ..write(jsonEncode(named.name))
      ..write('}}');
  }
  sb.write(']}');
  return (sb.toString(), count);
}

String _colorHex(int r, int g, int b) =>
    '#${r.toRadixString(16).padLeft(2, '0')}'
            '${g.toRadixString(16).padLeft(2, '0')}'
            '${b.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
