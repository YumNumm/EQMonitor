import 'dart:async';

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/notification/data/model/push_notification_log.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugNotificationDeliveryLogPage extends HookConsumerWidget {
  const DebugNotificationDeliveryLogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshTick = useState(0);
    final items = useState<List<PushNotificationLogEntry>>([]);
    final nextCursor = useState<String?>(null);
    final loading = useState(true);
    final loadingMore = useState(false);
    final error = useState<Object?>(null);

    Future<void> loadFirstPage() async {
      loading.value = true;
      error.value = null;
      items.value = [];
      nextCursor.value = null;
      final deviceId = await ref.read(deviceIdProvider.future);
      final repo = await ref.read(pushNotificationRepositoryProvider.future);
      final result = await repo.getNotificationHistory(
        deviceId: deviceId,
        limit: 50,
      );
      switch (result) {
        case Success(:final value):
          items.value = value.items;
          nextCursor.value = value.nextCursor;
        case Failure(:final exception):
          error.value = exception;
          items.value = [];
          nextCursor.value = null;
      }
      loading.value = false;
    }

    Future<void> loadMore() async {
      final cursor = nextCursor.value;
      if (cursor == null || loadingMore.value) {
        return;
      }
      loadingMore.value = true;
      final deviceId = await ref.read(deviceIdProvider.future);
      final repo = await ref.read(pushNotificationRepositoryProvider.future);
      final result = await repo.getNotificationHistory(
        deviceId: deviceId,
        limit: 50,
        cursor: cursor,
      );
      switch (result) {
        case Success(:final value):
          items.value = [...items.value, ...value.items];
          nextCursor.value = value.nextCursor;
        case Failure(:final exception):
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('追加読み込みに失敗: $exception'),
                backgroundColor: context.designSystem.colorTheme.error,
              ),
            );
          }
      }
      loadingMore.value = false;
    }

    useEffect(() {
      unawaited(loadFirstPage());
      return null;
    }, [refreshTick.value]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('通知配信ログ'),
        actions: [
          if (!loading.value)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => refreshTick.value++,
            ),
        ],
      ),
      body: switch (ref.watch(deviceIdProvider)) {
        AsyncError(:final error) => Center(child: Text('端末 ID 取得エラー: $error')),
        AsyncLoading() => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        AsyncData<String>(:final value) => Builder(
          builder: (context) {
            if (loading.value && items.value.isEmpty && error.value == null) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (error.value != null && items.value.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(error.value.toString(), textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () {
                          refreshTick.value++;
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('再試行'),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (items.value.isEmpty) {
              return RefreshIndicator(
                onRefresh: loadFirstPage,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
                    Center(
                      child: Text(
                        '配信ログはまだありません',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color:
                              context.designSystem.colorTheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: const Text('対象端末 ID'),
                      subtitle: SelectableText(value),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: loadFirstPage,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 24),
                itemCount:
                    items.value.length + (nextCursor.value != null ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == items.value.length) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: loadingMore.value
                            ? const CircularProgressIndicator.adaptive()
                            : TextButton.icon(
                                onPressed: () async {
                                  await loadMore();
                                },
                                icon: const Icon(Icons.expand_more),
                                label: const Text('さらに読み込む'),
                              ),
                      ),
                    );
                  }
                  final item = items.value[index];
                  return _NotificationLogTile(
                    item: item,
                    onTap: () async {
                      await showModalBottomSheet<void>(
                        context: context,
                        showDragHandle: true,
                        isScrollControlled: true,
                        builder: (context) => _LogDetailSheet(item: item),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      },
    );
  }
}

class _NotificationLogTile extends StatelessWidget {
  const _NotificationLogTile({required this.item, required this.onTap});

  final PushNotificationLogEntry item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;
    final ok = item.result == PushNotificationDeliveryResult.ok;
    final resultColor = ok ? colorTheme.primary : colorTheme.error;
    final subtitle = [
      if (item.title != null) item.title,
      if (item.body != null) item.body,
      if (item.errorMessage != null) item.errorMessage,
    ].join(' ');

    return ListTile(
      title: Text(
        item.title ?? '[タイトルなし]',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(item.body ?? '[本文なし]', maxLines: 4, overflow: .ellipsis),
      trailing: Icon(
        ok ? Icons.check_circle_outline : Icons.error_outline,
        color: resultColor,
      ),
      onTap: onTap,
    );
  }

  String _formatCreatedAt(String raw) {
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) {
      return raw;
    }
    final local = parsed.toLocal();
    return '${local.year}/${local.month.toString().padLeft(2, '0')}/${local.day.toString().padLeft(2, '0')} '
        '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}

class _LogDetailSheet extends StatelessWidget {
  const _LogDetailSheet({required this.item});

  final PushNotificationLogEntry item;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'ログ詳細',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    tooltip: 'テキストをコピー',
                    onPressed: () async {},
                    icon: const Icon(Icons.copy),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
