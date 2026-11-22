import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/repository/kyoshin_monitor_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ApiClient;
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart' hide Result;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_kyoshin_archive_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ReplayKyoshinArchiveRepository> replayKyoshinArchiveRepository(
  Ref ref,
) async => ReplayKyoshinArchiveRepository(
  apiClient: await ref.watch(apiClientProvider.future),
  kyoshinMonitor: ref.watch(kyoshinMonitorRepositoryProvider),
);

class ReplayKyoshinArchiveRepository({
  required final ApiClient apiClient,
  required final KyoshinMonitorRepository kyoshinMonitor,
}) {
  final _images = <int, Uint8List>{};

  Future<Result<List<ReplayData>, Exception>> fetchEewFrames({
    required String eventId,
  }) => Result.capture(() async {
    final response = await apiClient.eew.getV2EewEventId(eventId: eventId);
    return [
      for (final item in response.data.items.sorted(
        (a, b) => switch (a.reportTime.compareTo(b.reportTime)) {
          0 => a.serialNo.compareTo(b.serialNo),
          final order => order,
        },
      ))
        EqMonitorEewReplayData(
          type: ReplayDataType.eqMonitorEew,
          time: item.reportTime.toUtc(),
          json: jsonEncode(item.toJson()),
        ),
    ];
  });

  Future<Result<Uint8List?, Exception>> fetchShindoImage({
    required KyoshinMonitorSource source,
    required DateTime time,
  }) => Result.capture(() async {
    final key = time.millisecondsSinceEpoch;
    final cached = _images[key];
    if (cached != null) {
      return cached;
    }
    try {
      final image = Uint8List.fromList(
        await kyoshinMonitor.fetchRealtimeImage(
          source: source,
          type: RealtimeDataType.shindo,
          layer: RealtimeLayer.surface,
          dateTime: time,
        ),
      );
      _images[key] = image;
      return image;
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  });

  void clear() => _images.clear();
}
