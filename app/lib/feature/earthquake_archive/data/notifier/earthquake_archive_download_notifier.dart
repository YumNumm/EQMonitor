import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive_exception.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/repository/earthquake_archive_repository.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_file_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_library_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_library_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_archive_download_notifier.g.dart';

@riverpod
class EarthquakeArchiveDownloadNotifier
    extends _$EarthquakeArchiveDownloadNotifier {
  @override
  void build() {}

  static final downloadMutation = Mutation<SavedReplayFile>();

  Future<SavedReplayFile> download({required EarthquakeArchive archive}) async {
    final repository = await ref.read(
      earthquakeArchiveRepositoryProvider.future,
    );
    final bytes = (await repository.download(
      eventId: archive.eventId,
    )).unwrap();
    try {
      final file = await ref
          .read(replayLibraryRepositoryProvider)
          .saveDownloaded(bytes: bytes, name: archive.fileName);
      ref.invalidate(replayLibraryProvider);
      return file;
    } on ReplayFileException {
      throw const EarthquakeArchiveException(.invalidFile);
    }
  }
}
