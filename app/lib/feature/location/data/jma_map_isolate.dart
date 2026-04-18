// ignore_for_file: unreachable_from_main

import 'dart:async';
import 'dart:isolate';

import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/jma_map_utility.dart';
import 'package:eqmonitor/feature/location/data/jma_map_isolate_message.dart';
import 'package:eqmonitor/feature/location/data/model/map_data_item.dart';
import 'package:jma_map/jma_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_map_isolate.g.dart';

// ---------------------------------------------------------------------------
// Worker Isolate エントリポイント
// ---------------------------------------------------------------------------

@pragma('vm:entry-point')
void jmaMapWorkerEntryPoint(SendPort mainSendPort) {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);

  receivePort.listen((message) {
    if (message is JmaMapShutdownMessage) {
      receivePort.close();
      return;
    }
    if (message is JmaMapCalculateMessage) {
      _runCalculate(mainSendPort, message);
    }
  });
}

void _runCalculate(SendPort mainSendPort, JmaMapCalculateMessage message) {
  try {
    final mapData = JmaMap_JmaMapData.fromBuffer(message.mapDataBytes);
    final (:item, :distanceKm) = JmaMapUtility().findNearestItem(
      JmaMap_LatLng(lat: message.lat, lng: message.lng),
      mapData,
    );

    MapDataItem? result;
    if (item != null) {
      result = MapDataItem(
        bounds: item.hasBounds()
            ? MapDataBounds(
                southWest: MapDataLatLng(
                  lat: item.bounds.southWest.lat,
                  lng: item.bounds.southWest.lng,
                ),
                northEast: MapDataLatLng(
                  lat: item.bounds.northEast.lat,
                  lng: item.bounds.northEast.lng,
                ),
              )
            : null,
        property: item.hasProperty()
            ? MapDataProperty(
                code: item.property.code,
                name: item.property.name,
                nameKana: item.property.nameKana,
              )
            : null,
        polylabel: item.hasPolylabel()
            ? MapDataLatLng(
                lat: item.polylabel.lat,
                lng: item.polylabel.lng,
              )
            : null,
        distanceToCoastlineKm: distanceKm,
      );
    }

    mainSendPort.send(JmaMapResponseMessage(id: message.id, result: result));
  } on Object catch (e, st) {
    mainSendPort.send(
      JmaMapResponseMessage(
        id: message.id,
        errorMessage: e.toString(),
        errorStack: st.toString(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// JmaMapIsolate ハンドル
// ---------------------------------------------------------------------------

/// 常駐 Worker Isolate への JMA マップ検索ハンドル。
final class JmaMapIsolate {
  JmaMapIsolate._({
    required Isolate isolate,
    required ReceivePort mainReceive,
    required SendPort workerSendPort,
    required StreamSubscription<Object?> subscription,
    required Map<int, Completer<MapDataItem?>> pending,
    required Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
  })  : _isolate = isolate,
        _mainReceive = mainReceive,
        _workerSendPort = workerSendPort,
        _subscription = subscription,
        _pending = pending,
        _jmaMap = jmaMap;

  final Isolate _isolate;
  final ReceivePort _mainReceive;
  final SendPort _workerSendPort;
  final StreamSubscription<Object?> _subscription;
  final Map<int, Completer<MapDataItem?>> _pending;
  final Map<JmaMapType, JmaMap_JmaMapData> _jmaMap;

  var _nextId = 0;

  /// [jmaMap] を保持した Worker Isolate を起動する。
  static Future<JmaMapIsolate> spawn({
    required Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
  }) async {
    final mainReceive = ReceivePort();
    final workerPortCompleter = Completer<SendPort>();
    final pending = <int, Completer<MapDataItem?>>{};

    late final StreamSubscription<Object?> subscription;
    subscription = mainReceive.listen((message) {
      if (message is SendPort) {
        if (!workerPortCompleter.isCompleted) {
          workerPortCompleter.complete(message);
        }
        return;
      }
      if (message is JmaMapResponseMessage) {
        final completer = pending.remove(message.id);
        if (completer == null) {
          return;
        }
        if (message.errorMessage != null) {
          final st = message.errorStack != null
              ? StackTrace.fromString(message.errorStack!)
              : StackTrace.empty;
          completer.completeError(Exception(message.errorMessage), st);
        } else {
          completer.complete(message.result);
        }
      }
    });

    late final Isolate isolate;
    late final SendPort workerSendPort;
    try {
      isolate = await Isolate.spawn(
        jmaMapWorkerEntryPoint,
        mainReceive.sendPort,
        debugName: 'jma_map_analyzer',
      );
      workerSendPort = await workerPortCompleter.future;
    } on Object {
      await subscription.cancel();
      mainReceive.close();
      rethrow;
    }

    return JmaMapIsolate._(
      isolate: isolate,
      mainReceive: mainReceive,
      workerSendPort: workerSendPort,
      subscription: subscription,
      pending: pending,
      jmaMap: jmaMap,
    );
  }

  Future<MapDataItem?> calculateNearestElement({
    required double latitude,
    required double longitude,
    required JmaMapType type,
  }) {
    final mapData = _jmaMap[type]!;
    final bytes = mapData.writeToBuffer();

    final id = _nextId++;
    final completer = Completer<MapDataItem?>();
    _pending[id] = completer;
    _workerSendPort.send(
      JmaMapCalculateMessage(
        id: id,
        mapDataBytes: bytes,
        lat: latitude,
        lng: longitude,
      ),
    );
    return completer.future;
  }

  Future<void> dispose() async {
    _workerSendPort.send(const JmaMapShutdownMessage());
    await _subscription.cancel();
    _mainReceive.close();
    _isolate.kill(priority: Isolate.immediate);
  }
}

@Riverpod(keepAlive: true)
Future<JmaMapIsolate> jmaMapIsolate(Ref ref) async {
  final jmaMap = await ref.watch(jmaMapProvider.future);
  final isolate = await JmaMapIsolate.spawn(jmaMap: jmaMap);
  ref.onDispose(isolate.dispose);
  return isolate;
}
