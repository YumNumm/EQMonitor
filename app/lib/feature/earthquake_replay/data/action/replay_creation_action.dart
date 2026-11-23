import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_request.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_creation_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_creation_action.g.dart';

@riverpod
ReplayCreationAction replayCreationAction(Ref ref) =>
    const ReplayCreationAction();

class const ReplayCreationAction() {
  Future<void> create(
    WidgetRef ref,
    BuildContext context, {
    required ReplayCreationRequest request,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final file = await ReplayCreationNotifier.createMutation.run(
        ref,
        (tsx) =>
            tsx.get(replayCreationProvider.notifier).create(request: request),
      );
      messenger.showSnackBar(
        SnackBar(content: Text('${file.location} を作成しました')),
      );
    } on ReplayCreationException catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.failure.message)));
    } on ReplayLibraryException catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.failure.message)));
    } on Exception catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('リプレイファイルの作成に失敗しました: $error')),
      );
    }
  }
}
