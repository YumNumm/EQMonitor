import 'package:eqmonitor/core/api/http_cache_size_provider.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/http_cache/debug_http_cache_entries_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_http_cache_action.g.dart';

@riverpod
DebugHttpCacheAction debugHttpCacheAction(Ref ref) => DebugHttpCacheAction();

class DebugHttpCacheAction {
  Future<void> deleteEntry(
    WidgetRef ref,
    BuildContext context, {
    required String key,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('エントリを削除'),
        content: const Text('このキャッシュエントリを削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      return;
    }
    try {
      final store = await ref.read(httpCacheStoreProvider.future);
      await store.evict(key);
      ref
        ..invalidate(debugHttpCacheEntriesProvider)
        ..invalidate(httpCacheSizeProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('エントリを削除しました')),
        );
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('削除に失敗しました: $e')),
        );
      }
    }
  }

  Future<void> clearAll(WidgetRef ref, BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('すべて削除'),
        content: const Text('HTTPキャッシュをすべて削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      return;
    }
    try {
      final store = await ref.read(httpCacheStoreProvider.future);
      await store.clearAll();
      await store.vacuum();
      ref
        ..invalidate(debugHttpCacheEntriesProvider)
        ..invalidate(httpCacheSizeProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('HTTPキャッシュを削除しました')),
        );
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('削除に失敗しました: $e')),
        );
      }
    }
  }
}
