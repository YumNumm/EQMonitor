import 'package:flutter/widgets.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapLibreInherited extends InheritedWidget {
  const MapLibreInherited({
    required super.child,
    MapLibreMapController? controller,
    super.key,
  }) : _controller = controller;

  final MapLibreMapController? _controller;

  static MapLibreMapController of(BuildContext context) {
    final inheritedController =
        context.dependOnInheritedWidgetOfExactType<MapLibreInherited>();
    if (inheritedController == null) {
      throw Exception('MapLibreInheritedController not found');
    }
    return inheritedController._controller!;
  }

  @override
  bool updateShouldNotify(MapLibreInherited oldWidget) => false;
}
