import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';

/// MapLibre の map イベントを子ウィジェットツリーに提供する InheritedWidget。
///
/// StatelessWidget + InheritedWidget パターン。
/// StreamController は公開しない。emit のみを提供する。
class const MapLibreEventProvider({
  required final Widget child,
  super.key,
}) extends StatelessWidget {
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
class const MapLibreEventController() {
  void emit(MapEvent event) {}
}

class const _InheritedMapLibreEventProvider({
  required final MapLibreEventController controller,
  required super.child,
}) extends InheritedWidget {
  @override
  bool updateShouldNotify(_InheritedMapLibreEventProvider oldWidget) => false;
}
