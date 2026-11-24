import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/repository/earthquake_archive_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_archive_list_notifier.g.dart';

@riverpod
class EarthquakeArchiveListNotifier extends _$EarthquakeArchiveListNotifier {
  @override
  Future<EarthquakeArchivePage> build() async {
    final repository = await ref.watch(
      earthquakeArchiveRepositoryProvider.future,
    );
    return (await repository.list()).unwrap();
  }

  static final loadMoreMutation = Mutation<void>();

  Future<void> loadMore() async {
    final current = await future;
    final cursor = current.nextCursor;
    if (cursor == null) {
      return;
    }
    final repository = await ref.read(
      earthquakeArchiveRepositoryProvider.future,
    );
    final next = (await repository.list(cursor: cursor)).unwrap();
    state = AsyncData(
      EarthquakeArchivePage(
        items: [...current.items, ...next.items],
        nextCursor: next.nextCursor,
      ),
    );
  }
}
