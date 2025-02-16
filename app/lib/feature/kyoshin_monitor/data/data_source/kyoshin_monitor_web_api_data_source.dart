import 'package:eqmonitor/feature/kyoshin_monitor/data/api/kyoshin_monitor_web_api_client_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_web_api_data_source.g.dart';

@Riverpod(keepAlive: true)
KyoshinMonitorWebApiDataSource
kyoshinMonitorWebApiDataSource(Ref ref) =>
    KyoshinMonitorWebApiDataSource(
      client: ref.watch(kyoshinMonitorWebApiClientProvider),
    );

@Riverpod(keepAlive: true)
LpgmKyoshinMonitorWebApiDataSource
lpgmKyoshinMonitorWebApiDataSource(Ref ref) =>
    LpgmKyoshinMonitorWebApiDataSource(
      client: ref.watch(
        lpgmKyoshinMonitorWebApiClientProvider,
      ),
    );
