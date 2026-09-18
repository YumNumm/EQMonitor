import 'dart:async';

import 'package:eqmonitor/feature/location/data/headless/headless_device_location_dependencies.dart';
import 'package:flutter/widgets.dart';

@pragma('vm:entry-point')
void backgroundLocationCallbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(const HeadlessDeviceLocationDependencies().run());
}
