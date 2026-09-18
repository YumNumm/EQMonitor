import 'package:cache/cache.dart';
import 'package:eqmonitor/core/api/http_cache_size_provider.dart';
import 'package:eqmonitor/core/util/byte_size_formatter.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/http_cache/debug_http_cache_action.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/http_cache/debug_http_cache_entries_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/http_cache/http_cache_key_display.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugHttpCachePage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(debugHttpCacheEntriesProvider);
    final sizeAsync = ref.watch(httpCacheSizeProvider);
    const formatter = ByteSizeFormatter();
    const keyDisplay = HttpCacheKeyDisplay();

    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTPキャッシュ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '再取得',
            onPressed: () {
              ref
                ..invalidate(debugHttpCacheEntriesProvider)
                ..invalidate(httpCacheSizeProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'すべて削除',
            onPressed: () async {
              await ref
                  .read(debugHttpCacheActionProvider)
                  .clearAll(ref, context);
            },
          ),
        ],
      ),
      body: entriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('取得に失敗しました: $error'),
              TextButton(
                onPressed: () => ref.invalidate(debugHttpCacheEntriesProvider),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
        data: (entries) {
          final totalSizeLabel = sizeAsync.when(
            data: formatter.format,
            loading: () => '計算中…',
            error: (_, _) => '取得に失敗しました',
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HttpCacheHeader(
                totalSizeLabel: totalSizeLabel,
                entryCount: entries.length,
              ),
              Expanded(
                child: entries.isEmpty
                    ? const Center(child: Text('キャッシュエントリはありません'))
                    : ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          final entry = entries[index];
                          return _HttpCacheEntryTile(
                            entry: entry,
                            formatter: formatter,
                            keyDisplay: keyDisplay,
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HttpCacheHeader extends StatelessWidget {
  const new({
    required this.totalSizeLabel,
    required this.entryCount,
  });

  final String totalSizeLabel;
  final int entryCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('総容量: $totalSizeLabel'), Text('件数: $entryCount')],
      ),
    );
  }
}

class _HttpCacheEntryTile extends HookConsumerWidget {
  const new({
    required this.entry,
    required this.formatter,
    required this.keyDisplay,
  });

  final HttpCacheEntrySummary entry;
  final ByteSizeFormatter formatter;
  final HttpCacheKeyDisplay keyDisplay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expanded = useState(false);
    final contentType =
        entry.headers['content-type']?.join(', ') ??
        entry.headers['Content-Type']?.join(', ') ??
        'なし';
    final eTagLabel = entry.eTag ?? 'なし';
    final updatedAtLabel = DateTime.fromMillisecondsSinceEpoch(
      entry.updatedAtMs,
    ).formatWithTz(.yearMonthDayHourMinuteSecondMillisecond);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(keyDisplay.urlLabel(key: entry.key)),
          subtitle: Text(
            'HTTP ${entry.statusCode} · ${formatter.format(entry.bodySizeBytes)}',
          ),
          trailing: Icon(
            expanded.value ? Icons.expand_less : Icons.expand_more,
          ),
          onTap: () => expanded.value = !expanded.value,
        ),
        if (expanded.value)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('キー: ${entry.key}'),
                Text('更新: $updatedAtLabel'),
                Text('statusCode: ${entry.statusCode}'),
                Text('responseType: ${entry.responseType}'),
                Text('eTag: $eTagLabel'),
                Text('Content-Type: $contentType'),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () async {
                    await ref
                        .read(debugHttpCacheActionProvider)
                        .deleteEntry(ref, context, key: entry.key);
                  },
                  child: const Text('このエントリを削除'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
