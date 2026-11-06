import 'dart:async';
import 'dart:isolate';

import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/repository/kyoshin_monitor_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/shake_detection/data/data_source/native_shake_engine.dart';
import 'package:eqmonitor/feature/shake_detection/data/data_source/native_shake_model_builder.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/native_shake_snapshot.dart';
import 'package:flutter/services.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

class NativeShakeRepository {
  new({
    required this.engine,
    required this.catalog,
    required this.images,
  });
  static const enabled = bool.fromEnvironment('EQMONITOR_LOCAL_SHAKE');
  static const libraryPath = String.fromEnvironment(
    'EQMONITOR_NATIVE_SHAKE_LIBRARY',
    defaultValue: 'libeqmonitor_shake_ffi.so',
  );
  final NativeShakeEngine engine;
  final KyoshinObservationPointsParameter catalog;
  final KyoshinMonitorRepository images;
  final updates = StreamController<NativeShakeSnapshot>.broadcast();
  var disposed = false;
  var fetching = false;
  var eewRevision = 0;
  var lastTarget = -1;
  var sequence = 0;
  var applied = 0;

  static Future<NativeShakeRepository> create({
    required KyoshinObservationPointsParameter catalog,
    required KyoshinMonitorRepository images,
    required DateTime now,
  }) async {
    final engine = await NativeShakeEngine.create(
      libraryPath: libraryPath,
      config: {
        'schema_version': 1,
        'session_id': 'local:${now.microsecondsSinceEpoch}',
        'catalog_version': catalog.metadata.sha256,
        'stations': [
          for (final p in catalog.points)
            if (p.point case final pixel?)
              {
                'id': p.code,
                'latitude': p.location.lat,
                'longitude': p.location.lon,
                'pixel_x': pixel.center.x.toInt(),
                'pixel_y': pixel.center.y.toInt(),
                'independent_sample_id': p.code,
                'enabled': !p.isSuspended,
                'layer': 'surface',
              },
        ],
      },
    );
    return NativeShakeRepository(
      engine: engine,
      catalog: catalog,
      images: images,
    );
  }

  Future<void> loadModel(DateTime now) async {
    final csv = await rootBundle.loadString('assets/tjma2001.csv');
    final sites = {
      for (final p in catalog.points)
        if (p.arv400 case final double arv
            when arv.isFinite && arv > 0 && arv <= 100)
          p.code: arv,
    };
    final hash = catalog.metadata.sha256;
    final model = await Isolate.run(
      () => const NativeShakeModelBuilder().build(
        csv: csv,
        sites: sites,
        catalogHash: hash,
      ),
    );
    if (disposed) return;
    await publish(
      engine.request({
        'op': 'load_model',
        ...model,
        'now': now.millisecondsSinceEpoch,
      }),
    );
  }

  Future<void> publish(Future<Map<String, dynamic>> operation) async {
    final id = ++sequence;
    try {
      final value = await operation;
      if (disposed || id < applied) return;
      applied = id;
      updates.add(NativeShakeSnapshot.fromJson(json: value, catalog: catalog));
    } on Object catch (error, stack) {
      if (!disposed) updates.addError(error, stack);
    }
  }

  Future<void> image({
    required KyoshinMonitorState value,
    required KyoshinMonitorSource source,
    required DateTime now,
  }) async {
    final target = value.lastImageFetchTargetTime;
    final bytes = value.currentImageRaw;
    if (disposed ||
        fetching ||
        target == null ||
        bytes == null ||
        value.status == KyoshinMonitorStatus.playback ||
        target.millisecondsSinceEpoch <= lastTarget)
      return;
    fetching = true;
    try {
      final surface =
          value.currentRealtimeDataType == RealtimeDataType.shindo &&
          value.currentRealtimeLayer == RealtimeLayer.surface;
      final input = surface
          ? bytes
          : await images.fetchRealtimeImage(
              source: source,
              type: RealtimeDataType.shindo,
              layer: RealtimeLayer.surface,
              dateTime: target,
            );
      if (disposed) return;
      lastTarget = target.millisecondsSinceEpoch;
      await publish(
        engine.analyzeGif(
          bytes: Uint8List.fromList(input),
          metadata: {
            'target_time': lastTarget,
            'received_time': now.millisecondsSinceEpoch,
            'now': now.millisecondsSinceEpoch,
            'kind': 'surface_shindo',
            'catalog_version': catalog.metadata.sha256,
          },
        ),
      );
    } on Object catch (error, stack) {
      if (!disposed) updates.addError(error, stack);
    } finally {
      fetching = false;
    }
  }

  Future<void> eews({
    required List<EewTelegramItem> items,
    required DateTime now,
  }) async {
    final latest = <String, EewTelegramItem>{};
    for (final eew in items.where((e) => e.status == TelegramStatus.normal)) {
      final previous = latest[eew.eventId];
      if (previous == null ||
          eew.serialNo > previous.serialNo ||
          eew.reportTime.isAfter(previous.reportTime))
        latest[eew.eventId] = eew;
    }
    await publish(
      engine.request({
        'op': 'update_eews',
        'now': now.millisecondsSinceEpoch,
        'snapshot': {
          'revision': ++eewRevision,
          'events': [
            for (final e in latest.values)
              {
                'id': e.eventId,
                'revision':
                    e.reportTime.millisecondsSinceEpoch * 1000 + e.serialNo,
                'report_time': e.reportTime.millisecondsSinceEpoch,
                'origin_time': e.originTime?.millisecondsSinceEpoch,
                'hypocenter':
                    e.hypocenter?.latitude != null &&
                        e.hypocenter?.longitude != null
                    ? {
                        'latitude': e.hypocenter?.latitude,
                        'longitude': e.hypocenter?.longitude,
                      }
                    : null,
                'depth_km': e.hypocenter?.depth,
                'magnitude': e.hypocenter?.magnitude,
                'cancelled': e.isCanceled,
                'final_report': e.isLastInfo,
                'quality': e.isPlum
                    ? 'plum'
                    : e.isLowPreciseHypocenter
                    ? 'low_accuracy'
                    : 'hypocenter',
                'display_until': e.reportTime
                    .add(const Duration(seconds: 180))
                    .millisecondsSinceEpoch,
              },
          ],
        },
      }),
    );
  }

  Future<void> tick(DateTime now) => publish(
    engine.request({'op': 'poll', 'now': now.millisecondsSinceEpoch}),
  );
  Future<void> dispose() async {
    if (disposed) return;
    disposed = true;
    await engine.dispose();
    await updates.close();
  }
}
