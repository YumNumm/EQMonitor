import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IntensityHistoryLoadingOverlay extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(cityMaxIntensityProvider);
    if (!value.isLoading || value.hasValue) {
      return const SizedBox.shrink();
    }

    return const Positioned.fill(
      child: IgnorePointer(
        child: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
