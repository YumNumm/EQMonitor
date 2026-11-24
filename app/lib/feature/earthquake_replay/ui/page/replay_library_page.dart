import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/byte_size_formatter.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_access_level_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/action/replay_library_action.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_library_browser.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_folder.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_library_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_device_storage_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

enum _FileMenu { relocate, export, delete }

enum _FolderMenu { rename, delete }

class const ReplayLibraryPage({super.key}) extends HookConsumerWidget {
  static const _empty = ReplayLibraryContents(files: [], directories: []);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(replayLibraryProvider);
    final browser = ref.watch(replayLibraryBrowserProvider);
    final action = ref.watch(replayLibraryActionProvider);
    final isAdding =
        ref.watch(ReplayLibraryNotifier.addMutation) is MutationPending;
    final selectedDirectory = useState('');
    final isSelecting = useState(false);
    final selectedFilePaths = useState(const <String>{});
    final selectedFolderPaths = useState(const <String>{});

    final contents = state.value ?? _empty;
    final directory = browser.existingDirectory(
      contents: contents,
      directory: selectedDirectory.value,
    );
    final listing = browser.browse(contents: contents, directory: directory);
    final selectedFiles = [
      for (final file in listing.files)
        if (selectedFilePaths.value.contains(file.path)) file,
    ];
    final selectedFolders = [
      for (final folder in listing.folders)
        if (selectedFolderPaths.value.contains(folder.path)) folder,
    ];
    final selectedCount = selectedFiles.length + selectedFolders.length;

    void endSelection() {
      isSelecting.value = false;
      selectedFilePaths.value = const {};
      selectedFolderPaths.value = const {};
    }

    void toggle(ValueNotifier<Set<String>> selection, String path) {
      isSelecting.value = true;
      selection.value = selection.value.contains(path)
          ? selection.value.difference({path})
          : {...selection.value, path};
    }

    return PopScope(
      canPop: !isSelecting.value && directory.isEmpty,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        if (isSelecting.value) {
          endSelection();
        } else {
          selectedDirectory.value = browser.parent(directory: directory);
        }
      },
      child: Scaffold(
        appBar: isSelecting.value
            ? AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.close_rounded),
                  tooltip: '選択を終了',
                  onPressed: endSelection,
                ),
                title: Text('$selectedCount件を選択'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.select_all_rounded),
                    tooltip: 'すべて選択',
                    onPressed: () {
                      selectedFilePaths.value = {
                        for (final file in listing.files) file.path,
                      };
                      selectedFolderPaths.value = {
                        for (final folder in listing.folders) folder.path,
                      };
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.drive_file_move_outline),
                    tooltip: '選択した項目を移動',
                    onPressed: selectedCount == 0
                        ? null
                        : () async {
                            final isMoved = await action.moveEntries(
                              ref,
                              context,
                              files: selectedFiles,
                              folders: [
                                for (final folder in selectedFolders)
                                  folder.path,
                              ],
                              currentDirectory: directory,
                              directories: contents.directories,
                            );
                            if (isMoved) {
                              endSelection();
                            }
                          },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    tooltip: '選択した項目を削除',
                    onPressed: selectedCount == 0
                        ? null
                        : () async {
                            final isDeleted = await action.delete(
                              ref,
                              context,
                              files: selectedFiles,
                              folders: [
                                for (final folder in selectedFolders)
                                  folder.path,
                              ],
                              folderFileCount: selectedFolders.fold(
                                0,
                                (total, folder) => total + folder.files.length,
                              ),
                            );
                            if (isDeleted) {
                              endSelection();
                            }
                          },
                  ),
                ],
              )
            : AppBar(
                title: Text(directory.isEmpty ? '保存済みのリプレイ' : directory),
                actions: [
                  if (listing.files.isNotEmpty || listing.folders.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.checklist_rounded),
                      tooltip: '選択',
                      onPressed: () => isSelecting.value = true,
                    ),
                  IconButton(
                    icon: const Icon(Icons.create_new_folder_outlined),
                    tooltip: '新しいフォルダ',
                    onPressed: () async =>
                        action.createFolder(ref, context, parent: directory),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_rounded),
                    tooltip: 'ファイルを追加',
                    onPressed: isAdding
                        ? null
                        : () async =>
                              action.add(ref, context, directory: directory),
                  ),
                ],
              ),
        body: switch (state) {
          AsyncValue(value: null, :final error?) => Center(
            child: Text('一覧の取得に失敗しました: $error'),
          ),
          AsyncValue(value: null) => const Center(
            child: AccessibleCircularProgressIndicator(),
          ),
          _ => ListView(
            children: [
              _StorageUsageCard(files: contents.files),
              if (isAdding) const LinearProgressIndicator(),
              if (listing.files.isEmpty && listing.folders.isEmpty)
                ListTile(
                  title: Text(
                    directory.isEmpty ? '保存済みのファイルはありません' : 'このフォルダは空です',
                  ),
                  subtitle: Text(
                    directory.isEmpty
                        ? '右上の「＋」から .eqrp ファイルを追加できます'
                              '追加したファイルは開始時刻の年/月のフォルダに入ります'
                        : '右上の「＋」から、このフォルダへ .eqrp ファイルを追加できます',
                  ),
                ),
              for (final folder in listing.folders)
                _FolderTile(
                  folder: folder,
                  isSelecting: isSelecting.value,
                  isSelected: selectedFolderPaths.value.contains(folder.path),
                  onOpen: () => selectedDirectory.value = folder.path,
                  onToggle: () => toggle(selectedFolderPaths, folder.path),
                ),
              for (final file in listing.files)
                _FileTile(
                  file: file,
                  directories: contents.directories,
                  isSelecting: isSelecting.value,
                  isSelected: selectedFilePaths.value.contains(file.path),
                  onToggle: () => toggle(selectedFilePaths, file.path),
                ),
            ],
          ),
        },
      ),
    );
  }
}

class const _StorageUsageCard({required final List<SavedReplayFile> files})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final colorTheme = designSystem.colorTheme;
    final device = ref.watch(replayDeviceStorageProvider);
    const formatter = ByteSizeFormatter();
    final libraryBytes = files.fold(0, (total, file) => total + file.sizeBytes);

    return Card(
      margin: EdgeInsets.all(spacing.lg),
      elevation: 0,
      color: colorTheme.surfaceContainerHighest,
      child: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text('リプレイファイルの使用量', style: designSystem.typography.labelMedium),
            Text(
              '${formatter.format(libraryBytes)}（${files.length}件）',
              style: designSystem.typography.titleLarge,
            ),
            SizedBox(height: spacing.md),
            switch (device) {
              AsyncValue(:final value?) => Column(
                crossAxisAlignment: .start,
                children: [
                  LinearProgressIndicator(
                    value: (value.usedBytes / value.totalBytes).clamp(0, 1),
                    semanticsLabel: 'デバイスのストレージ使用率',
                  ),
                  SizedBox(height: spacing.sm),
                  Text(
                    'デバイスの空き ${formatter.format(value.usableBytes)}'
                    '・使用中 ${formatter.format(value.usedBytes)}'
                    '／全体 ${formatter.format(value.totalBytes)}',
                    style: designSystem.typography.bodySmall,
                  ),
                ],
              ),
              AsyncValue(isLoading: true) => const LinearProgressIndicator(),
              _ => Text(
                'デバイスの空き容量を取得できませんでした',
                style: designSystem.typography.bodySmall,
              ),
            },
          ],
        ),
      ),
    );
  }
}

class const _FolderTile({
  required final ReplayLibraryFolder folder,
  required final bool isSelecting,
  required final bool isSelected,
  required final VoidCallback onOpen,
  required final VoidCallback onToggle,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final action = ref.watch(replayLibraryActionProvider);
    return ListTile(
      leading: isSelecting
          ? Checkbox(value: isSelected, onChanged: (_) => onToggle())
          : const Icon(Icons.folder_outlined),
      title: Text(folder.name),
      subtitle: Text(
        '${folder.files.length}件・'
        '${const ByteSizeFormatter().format(folder.sizeBytes)}',
      ),
      selected: isSelected,
      onTap: isSelecting ? onToggle : onOpen,
      onLongPress: isSelecting ? null : onToggle,
      trailing: isSelecting
          ? null
          : PopupMenuButton<_FolderMenu>(
              tooltip: 'その他の操作',
              onSelected: (menu) async => switch (menu) {
                .rename => action.renameFolder(
                  ref,
                  context,
                  directory: folder.path,
                ),
                .delete => action.delete(
                  ref,
                  context,
                  files: const [],
                  folders: [folder.path],
                  folderFileCount: folder.files.length,
                ),
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: _FolderMenu.rename,
                  child: Text('名前と場所を変更'),
                ),
                PopupMenuItem(value: _FolderMenu.delete, child: Text('削除')),
              ],
            ),
    );
  }
}

class const _FileTile({
  required final SavedReplayFile file,
  required final List<String> directories,
  required final bool isSelecting,
  required final bool isSelected,
  required final VoidCallback onToggle,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final action = ref.watch(replayLibraryActionProvider);
    final canExport =
        ref.watch(debugAccessLevelProvider) == DebugAccessLevel.full;
    return ListTile(
      leading: isSelecting
          ? Checkbox(value: isSelected, onChanged: (_) => onToggle())
          : const Icon(Icons.play_circle_outline_rounded),
      title: Text(file.name),
      subtitle: Text(
        '${const ByteSizeFormatter().format(file.sizeBytes)}・'
        '${file.modifiedAt.formatWithTz(.yearMonthDayHourMinute)} 保存',
      ),
      selected: isSelected,
      onTap: isSelecting
          ? onToggle
          : () async => action.play(context, file: file),
      onLongPress: isSelecting ? null : onToggle,
      trailing: isSelecting
          ? null
          : PopupMenuButton<_FileMenu>(
              tooltip: 'その他の操作',
              onSelected: (menu) async => switch (menu) {
                .relocate => action.relocate(
                  ref,
                  context,
                  file: file,
                  directories: directories,
                ),
                .export => action.export(ref, context, file: file),
                .delete => action.delete(
                  ref,
                  context,
                  files: [file],
                  folders: const [],
                  folderFileCount: 0,
                ),
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: _FileMenu.relocate,
                  child: Text('名前とフォルダを変更'),
                ),
                if (canExport)
                  const PopupMenuItem(
                    value: _FileMenu.export,
                    child: Text('外部へエクスポート'),
                  ),
                const PopupMenuItem(value: _FileMenu.delete, child: Text('削除')),
              ],
            ),
    );
  }
}
