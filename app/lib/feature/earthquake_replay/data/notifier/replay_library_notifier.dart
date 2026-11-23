import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_folder.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_library_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_library_notifier.g.dart';

@riverpod
class ReplayLibraryNotifier extends _$ReplayLibraryNotifier {
  @override
  Future<ReplayLibraryContents> build() =>
      ref.watch(replayLibraryRepositoryProvider).list();

  static final addMutation = Mutation<SavedReplayFile>();

  Future<SavedReplayFile> add({
    required Uri source,
    required String directory,
  }) => _run(
    () => ref
        .read(replayLibraryRepositoryProvider)
        .add(source: source, directory: directory),
  );

  static final moveMutation = Mutation<SavedReplayFile>();

  Future<SavedReplayFile> move({
    required SavedReplayFile file,
    required String name,
    required String directory,
  }) => _run(
    () => ref
        .read(replayLibraryRepositoryProvider)
        .move(file: file, name: name, directory: directory),
  );

  static final createDirectoryMutation = Mutation<void>();

  Future<void> createDirectory({required String directory}) => _run(
    () => ref
        .read(replayLibraryRepositoryProvider)
        .createDirectory(directory: directory),
  );

  static final moveDirectoryMutation = Mutation<void>();

  Future<void> moveDirectory({required String from, required String to}) =>
      _run(
        () => ref
            .read(replayLibraryRepositoryProvider)
            .moveDirectory(from: from, to: to),
      );

  static final moveEntriesMutation = Mutation<void>();

  Future<void> moveEntries({
    required List<SavedReplayFile> files,
    required List<String> directories,
    required String destination,
  }) => _run(
    () => ref
        .read(replayLibraryRepositoryProvider)
        .moveEntries(
          files: files,
          directories: directories,
          destination: destination,
        ),
  );

  static final deleteMutation = Mutation<void>();

  Future<void> delete({
    required List<SavedReplayFile> files,
    required List<String> directories,
  }) => _run(
    () => ref
        .read(replayLibraryRepositoryProvider)
        .delete(files: files, directories: directories),
  );

  // 複数件の途中で失敗しても、済んだ分を一覧へ反映する。
  Future<T> _run<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } finally {
      if (ref.mounted) {
        ref.invalidateSelf();
      }
    }
  }
}
