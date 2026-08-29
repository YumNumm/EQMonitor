import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/data_source/kyoshin_monitor_web_api_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_time_sample.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart' hide Result;
import 'package:clock/clock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_repository.g.dart';

@Riverpod(keepAlive: true)
KyoshinMonitorRepository kyoshinMonitorRepository(Ref ref) =>
    KyoshinMonitorRepository(
      kmoni: ref.watch(kyoshinMonitorWebApiDataSourceProvider),
      lpgm: ref.watch(lpgmKyoshinMonitorWebApiDataSourceProvider),
    );

class KyoshinMonitorRepository {
  const new({
    required this.kmoni,
    required this.lpgm,
  });

  final KyoshinMonitorWebApiDataSource kmoni;
  final LpgmKyoshinMonitorWebApiDataSource lpgm;

  Future<Result<KyoshinMonitorTimeSample, Exception>> fetchLatestTime({
    required KyoshinMonitorSource source,
  }) => Result.capture(() async {
    final sentAt = clock.now();
    final dataTime = switch (source) {
      KyoshinMonitorSource.kmoni => await kmoni.getLatestDataTime(),
      KyoshinMonitorSource.lmoni => await lpgm.getLatestDataTime(),
    };
    final receivedAt = clock.now();
    return KyoshinMonitorTimeSample(
      sentAt: sentAt,
      receivedAt: receivedAt,
      latestTime: dataTime.latestTime,
    );
  });

  Future<List<int>> fetchRealtimeImage({
    required KyoshinMonitorSource source,
    required RealtimeDataType type,
    required RealtimeLayer layer,
    required DateTime dateTime,
  }) => switch (source) {
    KyoshinMonitorSource.lmoni => lpgm.getRealtimeImageData(
      type: type,
      layer: layer,
      dateTime: dateTime,
    ),
    KyoshinMonitorSource.kmoni => kmoni.getRealtimeImageData(
      type: type,
      layer: layer,
      dateTime: dateTime,
    ),
  };

  Future<MaintenanceMessage> fetchMaintenanceMessage() =>
      kmoni.getMaintenanceMessage();
}
