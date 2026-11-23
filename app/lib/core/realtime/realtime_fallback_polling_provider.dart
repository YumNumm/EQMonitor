import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/connectivity/connectivity_provider.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'realtime_fallback_polling_provider.g.dart';

@Riverpod(keepAlive: true)
bool isRealtimeFallbackPollingActive(Ref ref) =>
    ref.watch(appLifecycleProvider) == AppLifecycleState.resumed &&
    ref.watch(isNetworkConnectedProvider) &&
    ref.watch(eqMonitorWsStatusProvider).phase != WsPhase.connected;
