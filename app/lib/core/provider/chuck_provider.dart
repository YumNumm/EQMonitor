import 'package:chuck_interceptor/chuck_interceptor.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/provider/chuck_build_mode_policy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chuck_provider.g.dart';

const chuckBuildModePolicy = ChuckBuildModePolicy();

@Riverpod(keepAlive: true)
Chuck chuck(Ref ref) => Chuck(
  navigatorKey: App.navigatorKey,
);
