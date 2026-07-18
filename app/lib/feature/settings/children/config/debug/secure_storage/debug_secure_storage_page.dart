import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/secure_storage/debug_secure_storage_action.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/secure_storage/debug_secure_storage_entries_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugSecureStoragePage extends HookConsumerWidget {
  const DebugSecureStoragePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(debugSecureStorageEntriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SecureStorage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '再取得',
            onPressed: () => ref.invalidate(debugSecureStorageEntriesProvider),
          ),
        ],
      ),
      body: _EntriesList(entries: entries),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog<void>(
            context: context,
            builder: (context) => const _AddDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _EntriesList extends HookConsumerWidget {
  const _EntriesList({required this.entries});

  final AsyncValue<List<({String key, String value})>> entries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revealedKeys = useState<Set<String>>({});

    return entries.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('エラー: $error')),
      data: (list) {
        if (list.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(debugSecureStorageEntriesProvider);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 200),
                Center(child: Text('エントリがありません')),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(debugSecureStorageEntriesProvider);
          },
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final entry = list[index];
              final isRevealed = revealedKeys.value.contains(entry.key);
              final preview = isRevealed
                  ? entry.value
                  : '•••••••• (${entry.value.length})';

              return ListTile(
                title: Text(entry.key),
                subtitle: Text(
                  preview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: FontFamily.googleSansCode),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        isRevealed
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      tooltip: isRevealed ? 'マスク' : '表示',
                      onPressed: () {
                        final next = {...revealedKeys.value};
                        if (isRevealed) {
                          next.remove(entry.key);
                        } else {
                          next.add(entry.key);
                        }
                        revealedKeys.value = next;
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: '削除',
                      onPressed: () async {
                        final action = ref.read(
                          debugSecureStorageActionProvider,
                        );
                        await action.remove(ref, key: entry.key);
                      },
                    ),
                  ],
                ),
                onTap: () async {
                  await showDialog<void>(
                    context: context,
                    builder: (context) => _EditDialog(entry: entry),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _EditDialog extends HookConsumerWidget {
  const _EditDialog({required this.entry});

  final ({String key, String value}) entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: entry.value);

    return AlertDialog(
      title: Text(entry.key),
      content: TextField(
        controller: controller,
        maxLines: 8,
        minLines: 1,
        style: const TextStyle(fontFamily: FontFamily.googleSansCode),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: () async {
            final action = ref.read(debugSecureStorageActionProvider);
            await action.write(ref, key: entry.key, value: controller.text);
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}

class _AddDialog extends HookConsumerWidget {
  const _AddDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyController = useTextEditingController();
    final valueController = useTextEditingController();

    return AlertDialog(
      title: const Text('新規追加'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keyController,
              decoration: const InputDecoration(labelText: 'キー名'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(labelText: '値'),
              maxLines: 8,
              minLines: 1,
              style: const TextStyle(fontFamily: FontFamily.googleSansCode),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: () async {
            final key = keyController.text.trim();
            if (key.isEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('キー名を入力してください')));
              return;
            }

            final action = ref.read(debugSecureStorageActionProvider);
            await action.write(ref, key: key, value: valueController.text);
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
