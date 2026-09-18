import 'dart:async';

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/model/device_notification_webhook.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

class DebugNotificationWebhookPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webhooks = useState<List<DeviceNotificationWebhook>>([]);
    final loading = useState(true);
    final issuing = useState(false);
    final error = useState<Exception?>(null);

    Future<void> load() async {
      loading.value = true;
      error.value = null;
      final repository = await ref.read(deviceRepositoryProvider.future);
      final result = await repository.getNotificationWebhooks();
      switch (result) {
        case Success(:final value):
          webhooks.value = value;
        case Failure(:final exception):
          webhooks.value = [];
          error.value = exception;
      }
      loading.value = false;
    }

    Future<void> issue() async {
      issuing.value = true;
      final repository = await ref.read(deviceRepositoryProvider.future);
      final result = await repository.createNotificationWebhook();
      if (!context.mounted) {
        return;
      }
      switch (result) {
        case Success():
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Webhookを発行しました')),
          );
          await load();
        case Failure(:final exception):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Webhookの発行に失敗しました: $exception'),
              backgroundColor: context.designSystem.colorTheme.error,
            ),
          );
      }
      issuing.value = false;
    }

    useEffect(() {
      unawaited(load());
      return null;
      // load はローカル関数で毎ビルド識別子が変わるため keys に含めない。
      // ignore_keys: load
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('通知Webhook'),
        actions: [
          IconButton(
            tooltip: '再読み込み',
            onPressed: loading.value ? null : load,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: issuing.value ? null : issue,
        icon: issuing.value
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              )
            : const Icon(Icons.add_link),
        label: Text(issuing.value ? '発行中' : 'Webhookを発行'),
      ),
      body: switch ((loading.value, error.value, webhooks.value)) {
        (true, _, []) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        (_, final exception?, []) => _ErrorBody(
          exception: exception,
          onRetry: load,
        ),
        (_, _, []) => RefreshIndicator(
          onRefresh: load,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
              const Center(child: Text('発行済みWebhookはありません')),
            ],
          ),
        ),
        _ => RefreshIndicator(
          onRefresh: load,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 96),
            itemCount: webhooks.value.length,
            itemBuilder: (context, index) => _WebhookTile(
              webhook: webhooks.value[index],
            ),
          ),
        ),
      },
    );
  }
}

class _WebhookTile extends StatelessWidget {
  const new({required this.webhook});

  final DeviceNotificationWebhook webhook;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
    final expiresAt = webhook.expiresAt;
    final url = webhook.webhookUrl;
    return ListTile(
      leading: Icon(
        webhook.approved ? Icons.check_circle_outline : Icons.schedule,
      ),
      title: Text(webhook.approved ? '承認済み' : '承認待ち'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(webhook.id),
          Text('発行: ${dateFormat.format(webhook.createdAt.toLocal())}'),
          Text(
            expiresAt == null
                ? '期限: なし'
                : '期限: ${dateFormat.format(expiresAt.toLocal())}',
          ),
          if (url != null) SelectableText(url),
        ],
      ),
      trailing: url == null
          ? null
          : IconButton(
              tooltip: 'URLをコピー',
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: url));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Webhook URLをコピーしました')),
                  );
                }
              },
              icon: const Icon(Icons.copy),
            ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const new({required this.exception, required this.onRetry});

  final Exception exception;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Webhook一覧を取得できませんでした'),
            const SizedBox(height: 8),
            SelectableText(exception.toString(), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('再試行'),
            ),
          ],
        ),
      ),
    );
  }
}
