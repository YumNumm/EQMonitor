import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_creation_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_replay_files_notifier.g.dart';

@riverpod
class SavedReplayFiles extends _$SavedReplayFiles {
  @override
  Future<List<SavedReplayFile>> build() async {
    final repository = await ref.watch(replayCreationRepositoryProvider.future);
    return repository.list();
  }

  static final deleteMutation = Mutation<void>();

  Future<void> delete({required SavedReplayFile file}) async {
    final repository = await ref.read(replayCreationRepositoryProvider.future);
    await repository.delete(file: file);
    if (ref.mounted) {
      ref.invalidateSelf();
    }
  }
}
