import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';

/// MapLibre の map イベントを子ウィジェットツリーに提供する InheritedWidget。
///
/// StatelessWidget + InheritedWidget パターン。
/// StreamController は公開しない。emit のみを提供する。
class MapLibreEventProvider extends StatelessWidget {
  const MapLibreEventProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  static MapLibreEventController of(BuildContext context) =>
      maybeOf(context) ?? (throw Exception('MapLibreEventProvider not found'));

  static MapLibreEventController? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_InheritedMapLibreEventProvider>()
      ?.controller;

  @override
  Widget build(BuildContext context) {
    return _InheritedMapLibreEventProvider(
      controller: const MapLibreEventController(),
      child: child,
    );
  }
}

/// MapLibre イベントを受け取るコントローラ。
///
/// emit は現在 no-op。将来的にイベントをリスナーへ転送する実装に拡張可能。
class MapLibreEventController {
  const MapLibreEventController();

  void emit(MapEvent event) {}
}

class _InheritedMapLibreEventProvider extends InheritedWidget {
  const _InheritedMapLibreEventProvider({
    required this.controller,
    required super.child,
  });

  final MapLibreEventController controller;

  @override
  bool updateShouldNotify(_InheritedMapLibreEventProvider oldWidget) => false;
}
