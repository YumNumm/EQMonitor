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
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/saved_replay_files_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_device_storage_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

enum _FileMenu { relocate, export, delete }

class const ReplayLibraryPage({super.key}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(savedReplayFilesProvider);
    final browser = ref.watch(replayLibraryBrowserProvider);
    final action = ref.watch(replayLibraryActionProvider);
    final isAdding = ref.watch(SavedReplayFiles.addMutation) is MutationPending;
    final selectedDirectory = useState('');
    final isSelecting = useState(false);
    final selectedPaths = useState(const <String>{});

    final files = state.value ?? const <SavedReplayFile>[];
    final directory = browser.existingDirectory(
      files: files,
      directory: selectedDirectory.value,
    );
    final listing = browser.browse(files: files, directory: directory);
    final visibleFiles = browser.filesUnder(files: files, directory: directory);
    final selectedFiles = [
      for (final file in files)
        if (selectedPaths.value.contains(file.path)) file,
    ];

    void endSelection() {
      isSelecting.value = false;
      selectedPaths.value = const {};
    }

    void toggle(List<SavedReplayFile> targets) {
      final paths = {for (final file in targets) file.path};
      isSelecting.value = true;
      selectedPaths.value = selectedPaths.value.containsAll(paths)
          ? selectedPaths.value.difference(paths)
          : selectedPaths.value.union(paths);
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
                title: Text('${selectedFiles.length}件を選択'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.select_all_rounded),
                    tooltip: 'すべて選択',
                    onPressed: () => selectedPaths.value = {
                      ...selectedPaths.value,
                      for (final file in visibleFiles) file.path,
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    tooltip: '選択したファイルを削除',
                    onPressed: selectedFiles.isEmpty
                        ? null
                        : () async {
                            final isDeleted = await action.delete(
                              ref,
                              context,
                              files: selectedFiles,
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
                  if (files.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.checklist_rounded),
                      tooltip: '選択',
                      onPressed: () => isSelecting.value = true,
                    ),
                  IconButton(
                    icon: const Icon(Icons.add_rounded),
                    tooltip: 'ファイルを追加',
                    onPressed: isAdding
                        ? null
                        : () async => action.add(ref, context),
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
              _StorageUsageCard(files: files),
              if (isAdding) const LinearProgressIndicator(),
              if (files.isEmpty)
                const ListTile(
                  title: Text('保存済みのファイルはありません'),
                  subtitle: Text('右上の「＋」から .eqrp ファイルを追加できます'),
                ),
              for (final folder in listing.folders)
                _FolderTile(
                  folder: folder,
                  isSelecting: isSelecting.value,
                  selectedPaths: selectedPaths.value,
                  onOpen: () => selectedDirectory.value = folder.path,
                  onToggle: () => toggle(folder.files),
                ),
              for (final file in listing.files)
                _FileTile(
                  file: file,
                  isSelecting: isSelecting.value,
                  isSelected: selectedPaths.value.contains(file.path),
                  onToggle: () => toggle([file]),
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
                    semanticsLabel: '端末のストレージ使用率',
                  ),
                  SizedBox(height: spacing.sm),
                  Text(
                    '端末の空き ${formatter.format(value.usableBytes)}'
                    '・使用中 ${formatter.format(value.usedBytes)}'
                    '／全体 ${formatter.format(value.totalBytes)}',
                    style: designSystem.typography.bodySmall,
                  ),
                ],
              ),
              AsyncValue(isLoading: true) => const LinearProgressIndicator(),
              _ => Text(
                '端末の空き容量を取得できませんでした',
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
  required final Set<String> selectedPaths,
  required final VoidCallback onOpen,
  required final VoidCallback onToggle,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedCount = folder.files
        .where((file) => selectedPaths.contains(file.path))
        .length;
    return ListTile(
      leading: isSelecting
          ? Checkbox(
              tristate: true,
              value: selectedCount == 0
                  ? false
                  : selectedCount == folder.files.length
                  ? true
                  : null,
              onChanged: (_) => onToggle(),
            )
          : const Icon(Icons.folder_outlined),
      title: Text(folder.name),
      subtitle: Text(
        '${folder.files.length}件・'
        '${const ByteSizeFormatter().format(folder.sizeBytes)}',
      ),
      trailing: isSelecting ? null : const Icon(Icons.chevron_right_rounded),
      onTap: isSelecting ? onToggle : onOpen,
      onLongPress: isSelecting ? null : onToggle,
    );
  }
}

class const _FileTile({
  required final SavedReplayFile file,
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
                .relocate => action.relocate(ref, context, file: file),
                .export => action.export(ref, context, file: file),
                .delete => action.delete(ref, context, files: [file]),
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
                const PopupMenuItem(
                  value: _FileMenu.delete,
                  child: Text('削除'),
                ),
              ],
            ),
    );
  }
}
