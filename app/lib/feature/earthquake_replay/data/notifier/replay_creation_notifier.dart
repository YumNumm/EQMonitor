import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_request.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/saved_replay_files_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_creation_repository.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_request_provider.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_creation_notifier.g.dart';

@riverpod
class ReplayCreationNotifier extends _$ReplayCreationNotifier {
  bool _isCancelRequested = false;

  @override
  ReplayCreationProgress? build() => null;

  static final createMutation = Mutation<SavedReplayFile>();

  Future<SavedReplayFile> create({
    required ReplayCreationRequest request,
  }) async {
    _isCancelRequested = false;
    final repository = await ref.read(replayCreationRepositoryProvider.future);
    try {
      final file = await repository.create(
        request: request,
        source: ref.read(kyoshinMonitorImageRequestProvider).source,
        onProgress: (progress) {
          if (ref.mounted) {
            state = progress;
          }
        },
        isCancelled: () => _isCancelRequested || !ref.mounted,
      );
      if (ref.mounted) {
        ref.invalidate(savedReplayFilesProvider);
      }
      return file;
    } finally {
      if (ref.mounted) {
        state = null;
      }
    }
  }

  void cancel() => _isCancelRequested = true;
}
