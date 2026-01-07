import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

/// MapLibreのイベントストリームをグローバルに提供するInheritedWidget
class MapLibreEventProvider extends StatefulWidget {
  const MapLibreEventProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  static MapLibreEventProviderState of(BuildContext context) =>
      maybeOf(context) ?? (throw Exception('MapLibreEventProvider not found'));

  static MapLibreEventProviderState? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_InheritedMapLibreEventProvider>()
      ?.state;

  @override
  State<MapLibreEventProvider> createState() => MapLibreEventProviderState();
}

class MapLibreEventProviderState extends State<MapLibreEventProvider> {
  final _eventStreamController = StreamController<MapEvent>.broadcast();

  /// イベントストリームを取得
  Stream<MapEvent> get eventStream => _eventStreamController.stream;

  @override
  void dispose() {
    unawaited(_eventStreamController.close());
    super.dispose();
  }

  void emit(MapEvent event) => _eventStreamController.add(event);

  @override
  Widget build(BuildContext context) {
    return _InheritedMapLibreEventProvider(
      state: this,
      child: widget.child,
    );
  }
}

class _InheritedMapLibreEventProvider extends InheritedWidget {
  const _InheritedMapLibreEventProvider({
    required this.state,
    required super.child,
  });

  final MapLibreEventProviderState state;

  @override
  bool updateShouldNotify(_InheritedMapLibreEventProvider oldWidget) {
    return oldWidget.state != state;
  }
}
