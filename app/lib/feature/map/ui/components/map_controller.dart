import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapController extends InheritedWidget {
  const MapController({required super.child, super.key, this.controller});
  final MapLibreMapController? controller;

  static MapLibreMapController? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MapController>()!.controller;

  @override
  bool updateShouldNotify(MapController oldWidget) => false;
}
