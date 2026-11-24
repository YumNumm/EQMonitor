import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/action/earthquake_archive_action.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/notifier/earthquake_archive_list_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class const EarthquakeArchiveLoadMoreButton({super.key})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(
      EarthquakeArchiveListNotifier.loadMoreMutation,
    ) is MutationPending;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: isLoading
            ? const AccessibleCircularProgressIndicator()
            : FilledButton.tonal(
                onPressed: () async => ref
                    .read(earthquakeArchiveActionProvider)
                    .loadMore(ref, context),
                child: const Text('さらに読み込む'),
              ),
      ),
    );
  }
}
