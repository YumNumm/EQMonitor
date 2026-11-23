import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_library_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_replay_files_notifier.g.dart';

@riverpod
class SavedReplayFiles extends _$SavedReplayFiles {
  @override
  Future<List<SavedReplayFile>> build() =>
      ref.watch(replayLibraryRepositoryProvider).list();

  static final addMutation = Mutation<SavedReplayFile>();

  Future<SavedReplayFile> add({required Uri source}) async {
    final file = await ref
        .read(replayLibraryRepositoryProvider)
        .add(source: source);
    _refresh();
    return file;
  }

  static final moveMutation = Mutation<SavedReplayFile>();

  Future<SavedReplayFile> move({
    required SavedReplayFile file,
    required String name,
    required String directory,
  }) async {
    final moved = await ref
        .read(replayLibraryRepositoryProvider)
        .move(file: file, name: name, directory: directory);
    _refresh();
    return moved;
  }

  static final deleteMutation = Mutation<void>();

  Future<void> delete({required List<SavedReplayFile> files}) async {
    try {
      await ref.read(replayLibraryRepositoryProvider).delete(files: files);
    } finally {
      _refresh();
    }
  }

  void _refresh() {
    if (ref.mounted) {
      ref.invalidateSelf();
    }
  }
}
