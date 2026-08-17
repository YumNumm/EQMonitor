// ignore_for_file: unreachable_from_main

import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;

import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/worker/estimated_intensity_worker_exception.dart';

typedef EstimatedIntensityHypocenterInput = ({
  double jmaMagnitude,
  int depth,
  double lat,
  double lon,
});

/// 推定震度計算を常駐 Worker Isolate で行うハンドル。
final class EstimatedIntensityIsolate {
  new _({
    required Isolate isolate,
    required ReceivePort mainReceive,
    required SendPort workerSendPort,
    required StreamSubscription<Object?> subscription,
    required Map<int, Completer<List<double>>> pending,
  }) : _isolate = isolate,
       _mainReceive = mainReceive,
       _workerSendPort = workerSendPort,
       _subscription = subscription,
       _pending = pending;

  final Isolate _isolate;
  final ReceivePort _mainReceive;
  final SendPort _workerSendPort;
  final StreamSubscription<Object?> _subscription;
  final Map<int, Completer<List<double>>> _pending;

  var _nextId = 0;

  /// 計算点をキャッシュして解析用 Isolate を起動する。
  static Future<EstimatedIntensityIsolate> spawn({
    required List<CalculationPoint> points,
  }) async {
    final mainReceive = ReceivePort();
    final workerPortCompleter = Completer<SendPort>();
    final initAck = Completer<void>();
    final pending = <int, Completer<List<double>>>{};

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
      if (message is _ComputeResponseMessage) {
        final completer = pending.remove(message.id);
        if (completer == null) {
          return;
        }
        final intensities = message.intensities;
        if (intensities != null) {
          completer.complete(intensities);
        } else {
          final errorStack = message.errorStack;
          final stackTrace = errorStack != null
              ? StackTrace.fromString(errorStack)
              : StackTrace.empty;
          completer.completeError(
            EstimatedIntensityWorkerException(
              message.errorMessage ?? 'unknown',
              stackTrace,
            ),
            stackTrace,
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
        debugName: 'estimated_intensity',
      );

      workerSendPort = await workerPortCompleter.future;
      workerSendPort.send(_InitMessage(points));
      await initAck.future;
    } on Object {
      await subscription.cancel();
      mainReceive.close();
      rethrow;
    }

    return EstimatedIntensityIsolate._(
      isolate: isolate,
      mainReceive: mainReceive,
      workerSendPort: workerSendPort,
      subscription: subscription,
      pending: pending,
    );
  }

  /// 単一震源の推定震度を計算する。
  Future<List<double>> computeSingle({
    required double jmaMagnitude,
    required int depth,
    required double lat,
    required double lon,
  }) {
    final id = _nextId++;
    final completer = Completer<List<double>>();
    _pending[id] = completer;
    _workerSendPort.send(
      _ComputeSingleMessage(
        id: id,
        jmaMagnitude: jmaMagnitude,
        depth: depth,
        lat: lat,
        lon: lon,
      ),
    );
    return completer.future;
  }

  /// 複数震源の推定震度を計算し、観測点ごとの最大値を返す。
  Future<List<double>> computeMax({
    required List<EstimatedIntensityHypocenterInput> eews,
  }) {
    final id = _nextId++;
    final completer = Completer<List<double>>();
    _pending[id] = completer;
    _workerSendPort.send(_ComputeMaxMessage(id: id, eews: eews));
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
  const new(this.points);

  final List<CalculationPoint> points;
}

final class _InitAck {
  const new();
}

final class _ComputeSingleMessage {
  const new({
    required this.id,
    required this.jmaMagnitude,
    required this.depth,
    required this.lat,
    required this.lon,
  });

  final int id;
  final double jmaMagnitude;
  final int depth;
  final double lat;
  final double lon;
}

final class _ComputeMaxMessage {
  const new({required this.id, required this.eews});

  final int id;
  final List<EstimatedIntensityHypocenterInput> eews;
}

final class _ShutdownMessage {
  const new();
}

final class _ComputeResponseMessage {
  const new({
    required this.id,
    this.intensities,
    this.errorMessage,
    this.errorStack,
  });

  final int id;
  final List<double>? intensities;
  final String? errorMessage;
  final String? errorStack;
}

@pragma('vm:entry-point')
void _workerEntryPoint(SendPort mainSendPort) {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);

  var calculationPoints = <CalculationPoint>[];
  final calculator = EstimatedIntensityDataSource();
  var chain = Future<void>.value();

  receivePort.listen((message) {
    if (message is _InitMessage) {
      calculationPoints = message.points;
      mainSendPort.send(const _InitAck());
      return;
    }
    if (message is _ShutdownMessage) {
      receivePort.close();
      return;
    }
    if (message is _ComputeSingleMessage) {
      chain = chain.then(
        (_) => EstimatedIntensityWorkerRunner.runComputeSingle(
          mainSendPort,
          calculator,
          calculationPoints,
          message,
        ),
      );
      return;
    }
    if (message is _ComputeMaxMessage) {
      chain = chain.then(
        (_) => EstimatedIntensityWorkerRunner.runComputeMax(
          mainSendPort,
          calculator,
          calculationPoints,
          message,
        ),
      );
    }
  });
}

/// Worker Isolate 内で推定震度計算を実行し、結果をメイン Isolate へ送り返す。
///
/// [_workerEntryPoint] の spawn 先 Isolate 内で呼ばれるため、
/// インスタンス状態をキャプチャしない static method として定義する。
class EstimatedIntensityWorkerRunner {
  const new _();

  static Future<void> runComputeSingle(
    SendPort mainSendPort,
    EstimatedIntensityDataSource calculator,
    List<CalculationPoint> calculationPoints,
    _ComputeSingleMessage message,
  ) async {
    try {
      final intensities = calculator
          .getEstimatedIntensity(
            points: calculationPoints,
            jmaMagnitude: message.jmaMagnitude,
            depth: message.depth,
            hypocenter: (lat: message.lat, lon: message.lon),
          )
          .toList();
      mainSendPort.send(
        _ComputeResponseMessage(id: message.id, intensities: intensities),
      );
    } on Object catch (error, stackTrace) {
      mainSendPort.send(
        _ComputeResponseMessage(
          id: message.id,
          errorMessage: error.toString(),
          errorStack: stackTrace.toString(),
        ),
      );
    }
  }

  static Future<void> runComputeMax(
    SendPort mainSendPort,
    EstimatedIntensityDataSource calculator,
    List<CalculationPoint> calculationPoints,
    _ComputeMaxMessage message,
  ) async {
    try {
      final results = <List<double>>[];
      for (final eew in message.eews) {
        final result = calculator
            .getEstimatedIntensity(
              points: calculationPoints,
              jmaMagnitude: eew.jmaMagnitude,
              depth: eew.depth,
              hypocenter: (lat: eew.lat, lon: eew.lon),
            )
            .toList();
        results.add(result);
      }

      final intensities = results.isEmpty
          ? <double>[]
          : [
              for (var i = 0; i < results.first.length; i++)
                results.map((result) => result[i]).reduce(math.max),
            ];

      mainSendPort.send(
        _ComputeResponseMessage(id: message.id, intensities: intensities),
      );
    } on Object catch (error, stackTrace) {
      mainSendPort.send(
        _ComputeResponseMessage(
          id: message.id,
          errorMessage: error.toString(),
          errorStack: stackTrace.toString(),
        ),
      );
    }
  }
}
