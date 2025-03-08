import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'map_plugin_method_channel.dart';

abstract class MapPluginPlatform extends PlatformInterface {
  /// Constructs a MapPluginPlatform.
  MapPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MapPluginPlatform _instance = MethodChannelMapPlugin();

  /// The default instance of [MapPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMapPlugin].
  static MapPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MapPluginPlatform] when
  /// they register themselves.
  static set instance(MapPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
