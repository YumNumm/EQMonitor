import 'dart:io';

import 'package:flutter/material.dart';
import 'package:map_plugin/gen/maplibre_ffi.dart';
import 'package:map_plugin/map_plugin_ios.dart';

class MapPluginView extends StatelessWidget {
  const MapPluginView({
    super.key,
    required this.onMapCreated,
    this.onStyleLoaded,
    this.onCameraMoved,
    required this.styleString,
  });

  final void Function(MLNMapView) onMapCreated;
  final VoidCallback? onStyleLoaded;
  final VoidCallback? onCameraMoved;
  final String styleString;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return MapPluginIos(
        key: UniqueKey(),
        onStyleLoaded: onStyleLoaded,
        onCameraMoved: onCameraMoved,
        onMapCreated: onMapCreated,
        styleString: styleString,
      );
    }
    throw UnimplementedError(
      'MapPluginView is not supported on ${Platform.operatingSystem}',
    );
  }
}
