import 'package:eqmonitor/feature/debug/data/provider/debug_menu_availability_provider.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_focus_bounds_debug_provider.g.dart';

@riverpod
bool isMapFocusBoundsDebugEnabled(Ref ref) =>
    ref.watch(
      homeConfigurationProvider.select(
        (configuration) =>
            configuration.value?.debugOverlay.focusBounds ?? false,
      ),
    ) &&
    ref.watch(isDebugMenuAvailableProvider);
