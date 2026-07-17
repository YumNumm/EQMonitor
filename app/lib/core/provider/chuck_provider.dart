import 'package:chuck_interceptor/chuck_interceptor.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/provider/chuck_build_mode_policy.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chuck_provider.g.dart';

const chuckBuildModePolicy = ChuckBuildModePolicy(isDebugMode: kDebugMode);

@Riverpod(keepAlive: true)
Chuck chuck(Ref ref) => Chuck(
  navigatorKey: App.navigatorKey,
  // ignore: avoid_redundant_argument_values
  showNotification: chuckBuildModePolicy.showNotification,
);
