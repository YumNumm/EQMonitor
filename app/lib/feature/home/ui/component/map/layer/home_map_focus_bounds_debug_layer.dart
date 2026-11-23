import 'package:eqmonitor/feature/home/data/service/home_map_camera_coordinator.dart';
import 'package:eqmonitor/feature/map/data/provider/map_focus_bounds_debug_provider.dart';
import 'package:eqmonitor/feature/map/ui/map_focus_bounds_debug_layer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const HomeMapFocusBoundsDebugLayer({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(isMapFocusBoundsDebugEnabledProvider)) {
      return const SizedBox.shrink();
    }
    return const _HomeMapFocusBoundsDebugLayerBody();
  }
}

class const _HomeMapFocusBoundsDebugLayerBody() extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bounds = useValueListenable(
      ref.watch(homeMapCameraCoordinatorProvider).focusBounds,
    );
    return MapFocusBoundsDebugLayer(bounds: bounds);
  }
}
