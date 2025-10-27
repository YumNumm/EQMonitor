import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';

/// Wrapper for backward compatibility with old maplibre_gl API
class MapLibreInherited extends InheritedWidget {
  const MapLibreInherited({
    required super.child,
    MapController? controller,
    super.key,
  }) : _controller = controller;

  final MapController? _controller;

  static MapController of(BuildContext context) {
    // Try to get from the new MapLibre API first
    final controller = MapController.maybeOf(context);
    if (controller != null) {
      return controller;
    }
    
    // Fallback to legacy InheritedWidget
    final inheritedController =
        context.dependOnInheritedWidgetOfExactType<MapLibreInherited>();
    if (inheritedController == null) {
      throw Exception('MapLibreInheritedController not found');
    }
    return inheritedController._controller!;
  }

  @override
  bool updateShouldNotify(MapLibreInherited oldWidget) => 
      _controller != oldWidget._controller;
}
