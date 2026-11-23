import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_access_level_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_library_browser.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_file_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_library_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_library_repository.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/replay_directory_dialog.dart';
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

  /// [directory] が空（最上位を表示中）の場合は、開始時刻の年/月へ追加する。
  Future<void> add(
    WidgetRef ref,
    BuildContext context, {
    required String directory,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final source = await ref.read(replayLibraryRepositoryProvider).pick();
      if (source == null) {
        return;
      }
      final file = await ReplayLibraryNotifier.addMutation.run(
        ref,
        (tsx) => tsx
            .get(replayLibraryProvider.notifier)
            .add(source: source, directory: directory),
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
    required List<String> directories,
  }) async {
    final location = await showDialog<ReplayFileLocation>(
      context: context,
      builder: (context) =>
          ReplayFileLocationDialog(file: file, directories: directories),
    );
    if (location == null || !context.mounted) {
      return;
    }
    await _run(
      context,
      failureLabel: '変更に失敗しました',
      operation: () => ReplayLibraryNotifier.moveMutation.run(
        ref,
        (tsx) => tsx
            .get(replayLibraryProvider.notifier)
            .move(
              file: file,
              name: location.name,
              directory: location.directory,
            ),
      ),
    );
  }

  Future<void> createFolder(
    WidgetRef ref,
    BuildContext context, {
    required String parent,
  }) async {
    final name = await showDialog<String>(
      context: context,
      builder: (context) => const ReplayDirectoryDialog(
        title: '新しいフォルダ',
        initialDirectory: '',
        directories: [],
        helperText: '「/」で区切ると、下位のフォルダもまとめて作成します',
        confirmLabel: '作成',
        isEmptyAllowed: false,
      ),
    );
    if (name == null || !context.mounted) {
      return;
    }
    final browser = ref.read(replayLibraryBrowserProvider);
    await _run(
      context,
      failureLabel: 'フォルダの作成に失敗しました',
      operation: () => ReplayLibraryNotifier.createDirectoryMutation.run(
        ref,
        (tsx) => tsx
            .get(replayLibraryProvider.notifier)
            .createDirectory(
              directory: browser.join(parent: parent, child: name.trim()),
            ),
      ),
    );
  }

  Future<void> renameFolder(
    WidgetRef ref,
    BuildContext context, {
    required String directory,
  }) async {
    final destination = await showDialog<String>(
      context: context,
      builder: (context) => ReplayDirectoryDialog(
        title: 'フォルダの名前と場所を変更',
        initialDirectory: directory,
        directories: const [],
        helperText: '「/」で区切った場所ごと変更できます。中のファイルも一緒に移動します',
        confirmLabel: '保存',
        isEmptyAllowed: false,
      ),
    );
    if (destination == null || !context.mounted) {
      return;
    }
    await _run(
      context,
      failureLabel: 'フォルダの変更に失敗しました',
      operation: () => ReplayLibraryNotifier.moveDirectoryMutation.run(
        ref,
        (tsx) => tsx
            .get(replayLibraryProvider.notifier)
            .moveDirectory(from: directory, to: destination),
      ),
    );
  }

  Future<bool> moveEntries(
    WidgetRef ref,
    BuildContext context, {
    required List<SavedReplayFile> files,
    required List<String> folders,
    required String currentDirectory,
    required List<String> directories,
  }) async {
    if (files.isEmpty && folders.isEmpty) {
      return false;
    }
    final destination = await showDialog<String>(
      context: context,
      builder: (context) => ReplayDirectoryDialog(
        title: '移動先のフォルダ',
        initialDirectory: currentDirectory,
        directories: directories,
        helperText: '無いフォルダは作成します。空欄にすると最上位へ移動します',
        confirmLabel: '移動',
        isEmptyAllowed: true,
      ),
    );
    if (destination == null || !context.mounted) {
      return false;
    }
    return _run(
      context,
      failureLabel: '移動に失敗しました',
      operation: () => ReplayLibraryNotifier.moveEntriesMutation.run(
        ref,
        (tsx) => tsx
            .get(replayLibraryProvider.notifier)
            .moveEntries(
              files: files,
              directories: folders,
              destination: destination,
            ),
      ),
    );
  }

  /// [folderFileCount] は [folders] の中にあるファイルの数。
  Future<bool> delete(
    WidgetRef ref,
    BuildContext context, {
    required List<SavedReplayFile> files,
    required List<String> folders,
    required int folderFileCount,
  }) async {
    if (files.isEmpty && folders.isEmpty) {
      return false;
    }
    final target = [
      if (folders.isNotEmpty)
        '${folders.length}個のフォルダ（中の$folderFileCount件のファイルを含む）',
      if (files.length == 1 && folders.isEmpty) files.single.name,
      if (files.length > 1 || (files.isNotEmpty && folders.isNotEmpty))
        '${files.length}件のファイル',
    ].join('と');
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('削除'),
        content: Text('$targetを削除しますか？'),
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
    if (confirmed != true || !context.mounted) {
      return false;
    }
    return _run(
      context,
      failureLabel: '削除に失敗しました',
      operation: () => ReplayLibraryNotifier.deleteMutation.run(
        ref,
        (tsx) => tsx
            .get(replayLibraryProvider.notifier)
            .delete(files: files, directories: folders),
      ),
    );
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

  Future<bool> _run(
    BuildContext context, {
    required String failureLabel,
    required Future<void> Function() operation,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await operation();
      return true;
    } on ReplayLibraryException catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.failure.message)));
    } on Exception catch (error) {
      messenger.showSnackBar(SnackBar(content: Text('$failureLabel: $error')));
    }
    return false;
  }
}
