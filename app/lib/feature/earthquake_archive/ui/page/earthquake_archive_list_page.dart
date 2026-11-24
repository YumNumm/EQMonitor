import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive_exception.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/notifier/earthquake_archive_list_notifier.dart';
import 'package:eqmonitor/feature/earthquake_archive/ui/components/earthquake_archive_error_view.dart';
import 'package:eqmonitor/feature/earthquake_archive/ui/components/earthquake_archive_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_archive/ui/components/earthquake_archive_load_more_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const EarthquakeArchiveListPage({super.key}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageAsync = ref.watch(earthquakeArchiveListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('地震アーカイブ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '再取得',
            onPressed: () => ref.invalidate(earthquakeArchiveListProvider),
          ),
        ],
      ),
      body: switch (pageAsync) {
        AsyncData(:final value) => _ArchiveList(page: value),
        AsyncError(:final error) => EarthquakeArchiveErrorView(
          message: switch (error) {
            EarthquakeArchiveException(:final failure) => failure.message,
            _ => EarthquakeArchiveFailure.unknown.message,
          },
          onRetry: () => ref.invalidate(earthquakeArchiveListProvider),
        ),
        _ => const Center(child: AccessibleCircularProgressIndicator()),
      },
    );
  }
}

class const _ArchiveList({required final EarthquakeArchivePage page})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (page.items.isEmpty) {
      return const Center(child: Text('アーカイブはまだありません'));
    }
    final hasMore = page.nextCursor != null;
    return ListView.builder(
      itemCount: page.items.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) => index < page.items.length
          ? EarthquakeArchiveListTile(archive: page.items[index])
          : const EarthquakeArchiveLoadMoreButton(),
    );
  }
}
