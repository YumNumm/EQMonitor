import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_access_level_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_request.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_creation_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/saved_replay_files_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

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
        SnackBar(content: Text('${file.name} を作成しました')),
      );
    } on ReplayCreationException catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.failure.message)));
    } on Exception catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('リプレイファイルの作成に失敗しました: $error')),
      );
    }
  }

  Future<void> play(
    BuildContext context, {
    required SavedReplayFile file,
  }) => ReplayOpenRoute(source: file.uri.toString()).push<void>(context);

  Future<void> delete(
    WidgetRef ref,
    BuildContext context, {
    required SavedReplayFile file,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('リプレイファイルを削除'),
        content: Text('${file.name} を削除しますか？'),
        actions: [
          M3ETextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          M3EFilledButton(
            onPressed: () =>
                HapticUtil.medium(() => Navigator.of(context).pop(true)),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      return;
    }
    try {
      await SavedReplayFiles.deleteMutation.run(
        ref,
        (tsx) => tsx.get(savedReplayFilesProvider.notifier).delete(file: file),
      );
    } on Exception catch (error) {
      messenger.showSnackBar(SnackBar(content: Text('削除に失敗しました: $error')));
    }
  }

  Future<void> export(
    WidgetRef ref,
    BuildContext context, {
    required SavedReplayFile file,
  }) async {
    if (ref.read(debugAccessLevelProvider) != DebugAccessLevel.full) {
      return;
    }
    final box = context.findRenderObject();
    await SharePlus.instance.share(
      ShareParams(
        subject: file.name,
        files: [XFile(file.path, name: file.name)],
        sharePositionOrigin: box is RenderBox && box.hasSize
            ? box.localToGlobal(Offset.zero) & box.size
            : null,
      ),
    );
  }
}
