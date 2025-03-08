import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'map_plugin_platform_interface.dart';

/// An implementation of [MapPluginPlatform] that uses method channels.
class MethodChannelMapPlugin extends MapPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('map_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
