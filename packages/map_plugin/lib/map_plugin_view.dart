import 'dart:io';

import 'package:flutter/material.dart';

class MapPluginView extends StatelessWidget {
  const MapPluginView({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return UiKitView(
        viewType: "plugins.net.yumnumm.map_plugin",
        layoutDirection: TextDirection.ltr,
        onPlatformViewCreated: (id) {
          print("MapPluginView created: $id");

          MapLibreRegistry
        },
      );
    }
    throw UnimplementedError(
      'MapPluginView is not supported on ${Platform.operatingSystem}',
    );
  }
}
