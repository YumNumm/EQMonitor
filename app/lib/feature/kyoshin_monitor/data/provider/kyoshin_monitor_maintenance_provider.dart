import 'package:eqmonitor/feature/kyoshin_monitor/data/data_source/kyoshin_monitor_web_api_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart'
    as kmoni_api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_maintenance_provider.g.dart';

@Riverpod(keepAlive: true)
Future<kmoni_api.MaintenanceMessage>
kyoshinMonitorMaintenance(Ref ref) {
  final dataSource = ref.watch(
    kyoshinMonitorWebApiDataSourceProvider,
  );
  return dataSource.getMaintenanceMessage();
}
