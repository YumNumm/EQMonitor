import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_access_level_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_file_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/saved_replay_files_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_library_repository.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/replay_file_location_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'replay_library_action.g.dart';

@riverpod
ReplayLibraryAction replayLibraryAction(Ref ref) => const ReplayLibraryAction();

class const ReplayLibraryAction() {
  Future<void> play(
    BuildContext context, {
    required SavedReplayFile file,
  }) => ReplayOpenRoute(source: file.uri.toString()).push<void>(context);

  Future<void> add(WidgetRef ref, BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final source = await ref.read(replayLibraryRepositoryProvider).pick();
      if (source == null) {
        return;
      }
      final file = await SavedReplayFiles.addMutation.run(
        ref,
        (tsx) => tsx.get(savedReplayFilesProvider.notifier).add(source: source),
      );
      messenger.showSnackBar(
        SnackBar(content: Text('${file.location} に追加しました')),
      );
    } on ReplayFileException catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.failure.message)));
    } on Exception catch (error) {
      messenger.showSnackBar(SnackBar(content: Text('追加に失敗しました: $error')));
    }
  }

  Future<void> relocate(
    WidgetRef ref,
    BuildContext context, {
    required SavedReplayFile file,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    final location = await showDialog<ReplayFileLocation>(
      context: context,
      builder: (context) => ReplayFileLocationDialog(file: file),
    );
    if (location == null) {
      return;
    }
    try {
      await SavedReplayFiles.moveMutation.run(
        ref,
        (tsx) => tsx
            .get(savedReplayFilesProvider.notifier)
            .move(
              file: file,
              name: location.name,
              directory: location.directory,
            ),
      );
    } on ReplayLibraryException catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.failure.message)));
    } on Exception catch (error) {
      messenger.showSnackBar(SnackBar(content: Text('変更に失敗しました: $error')));
    }
  }

  Future<bool> delete(
    WidgetRef ref,
    BuildContext context, {
    required List<SavedReplayFile> files,
  }) async {
    if (files.isEmpty) {
      return false;
    }
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('リプレイファイルを削除'),
        content: Text(
          files.length == 1
              ? '${files.single.name} を削除しますか？'
              : '${files.length}件のファイルを削除しますか？',
        ),
        actions: [
          M3ETextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          M3EFilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      return false;
    }
    try {
      await SavedReplayFiles.deleteMutation.run(
        ref,
        (tsx) =>
            tsx.get(savedReplayFilesProvider.notifier).delete(files: files),
      );
      return true;
    } on Exception catch (error) {
      messenger.showSnackBar(SnackBar(content: Text('削除に失敗しました: $error')));
      return false;
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
