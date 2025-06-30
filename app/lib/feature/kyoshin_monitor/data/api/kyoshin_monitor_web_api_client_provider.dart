import 'package:eqmonitor/feature/kyoshin_monitor/data/api/kyoshin_monitor_dio.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_web_api_client_provider.g.dart';

@Riverpod(keepAlive: true)
KyoshinMonitorWebApiClient kyoshinMonitorWebApiClient(Ref ref) =>
    KyoshinMonitorWebApiClient(
      ref.watch(kyoshinMonitorDioProvider),
      baseUrl:
          ref
              .watch(
                kyoshinMonitorSettingsProvider.select((v) => v.api.endpoint),
              )
              .url,
    );

@Riverpod(keepAlive: true)
LpgmKyoshinMonitorWebApiClient lpgmKyoshinMonitorWebApiClient(Ref ref) =>
    LpgmKyoshinMonitorWebApiClient(ref.watch(kyoshinMonitorDioProvider));
