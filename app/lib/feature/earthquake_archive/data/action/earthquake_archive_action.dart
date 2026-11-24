import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive_exception.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/notifier/earthquake_archive_download_notifier.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/notifier/earthquake_archive_list_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_archive_action.g.dart';

@riverpod
EarthquakeArchiveAction earthquakeArchiveAction(Ref ref) =>
    const EarthquakeArchiveAction();

class const EarthquakeArchiveAction() {
  Future<void> openDetail(
    BuildContext context, {
    required EarthquakeArchive archive,
  }) => DebugEarthquakeArchiveDetailRoute(
    eventId: archive.eventId,
  ).push<void>(context);

  Future<void> loadMore(WidgetRef ref, BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await EarthquakeArchiveListNotifier.loadMoreMutation.run(
        ref,
        (tsx) => tsx.get(earthquakeArchiveListProvider.notifier).loadMore(),
      );
    } on EarthquakeArchiveException catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.failure.message)));
    }
  }

  Future<void> download(
    WidgetRef ref,
    BuildContext context, {
    required EarthquakeArchive archive,
    required bool play,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final file = await EarthquakeArchiveDownloadNotifier.downloadMutation.run(
        ref,
        (tsx) => tsx
            .get(earthquakeArchiveDownloadProvider.notifier)
            .download(archive: archive),
      );
      if (!context.mounted) {
        return;
      }
      if (play) {
        await ReplayOpenRoute(source: file.uri.toString()).push<void>(context);
        return;
      }
      messenger.showSnackBar(
        SnackBar(content: Text('${file.location} に保存しました')),
      );
    } on EarthquakeArchiveException catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.failure.message)));
    }
  }
}
