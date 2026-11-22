import 'dart:io';

import 'package:eqmonitor/core/provider/api_user_agent_builder.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_user_agent_provider.g.dart';

@Riverpod(keepAlive: true)
String apiUserAgent(Ref ref) => const ApiUserAgentBuilder().build(
  packageInfo: ref.watch(packageInfoProvider),
  androidDeviceInfo: Platform.isAndroid
      ? ref.watch(androidDeviceInfoProvider)
      : null,
  iosDeviceInfo: Platform.isIOS ? ref.watch(iosDeviceInfoProvider) : null,
);
