import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugDeviceAdminPage extends ConsumerWidget {
  const DebugDeviceAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceIdAsync = ref.watch(deviceIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('デバイス管理（デバッグ）'),
      ),
      body: deviceIdAsync.when(
        data: (deviceId) => _DebugDeviceAdminBody(deviceId: deviceId),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (e, _) => _ErrorBody(message: e.toString()),
      ),
    );
  }
}

class _DebugDeviceAdminBody extends HookConsumerWidget {
  const _DebugDeviceAdminBody({required this.deviceId});

  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshTick = useState(0);

    Future<({RegisteredDevice? device, GeneralNotificationSettings? settings})>
    fetch() async {
      final deviceRepository = await ref.read(deviceRepositoryProvider.future);
      final getResult = await deviceRepository.getDevice(deviceId);
      switch (getResult) {
        case Success(:final value):
          final notificationRepository = await ref.read(
            pushNotificationRepositoryProvider.future,
          );
          final settingsResult = await notificationRepository
              .getNotificationSettings(deviceId);
          final settings = switch (settingsResult) {
            Success(:final value) => value,
            Failure(:final exception) => throw exception,
          };
          return (device: value, settings: settings);
        case Failure(:final exception):
          if (_isNotFound(exception)) {
            return (device: null, settings: null);
          }
          throw exception;
      }
    }

    final future = useMemoized(fetch, [deviceId, refreshTick.value]);
    final snapshot = useFuture(future);

    Future<void> reload() async {
      refreshTick.value++;
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 8, top: 4),
            child: IconButton(
              tooltip: '再読み込み',
              onPressed: snapshot.connectionState == ConnectionState.waiting
                  ? null
                  : () async {
                      await reload();
                    },
              icon: const Icon(Icons.refresh),
            ),
          ),
        ),
        Expanded(
          child: switch (snapshot.connectionState) {
            ConnectionState.waiting => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ConnectionState.done => snapshot.hasError
                ? _ErrorBody(message: snapshot.error.toString())
                : _Body(
                    deviceId: deviceId,
                    device: snapshot.data!.device,
                    settings: snapshot.data!.settings,
                    onReload: reload,
                  ),
            _ => const SizedBox.shrink(),
          },
        ),
      ],
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({
    required this.deviceId,
    required this.device,
    required this.settings,
    required this.onReload,
  });

  final String deviceId;
  final RegisteredDevice? device;
  final GeneralNotificationSettings? settings;
  final Future<void> Function() onReload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusy = useState(false);
    final tsunami = useState(settings?.tsunamiEnabled ?? false);
    final training = useState(settings?.trainingEnabled ?? false);

    useEffect(() {
      tsunami.value = settings?.tsunamiEnabled ?? false;
      training.value = settings?.trainingEnabled ?? false;
      return null;
    }, [settings]);

    Future<void> runWithBusy(Future<void> Function() action) async {
      if (isBusy.value) {
        return;
      }
      isBusy.value = true;
      try {
        await action();
      } finally {
        isBusy.value = false;
      }
    }

    Future<void> registerOrRefresh() async {
      await runWithBusy(() async {
        final messenger = ScaffoldMessenger.of(context);
        final repo = await ref.read(deviceRepositoryProvider.future);
        final result = await repo.registerDevice(deviceId);
        if (!context.mounted) {
          return;
        }
        switch (result) {
          case Success():
            messenger.showSnackBar(
              const SnackBar(content: Text('サーバーにデバイスを登録しました')),
            );
            await onReload();
          case Failure(:final exception):
            messenger.showSnackBar(
              SnackBar(
                content: Text('登録に失敗しました: $exception'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
        }
      });
    }

    Future<void> deleteDevice() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('デバイスを削除'),
          content: const Text(
            'この端末 ID に紐づくサーバー上のデバイスと関連データを削除します。よろしいですか？',
          ),
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
      if (confirmed != true || !context.mounted) {
        return;
      }
      await runWithBusy(() async {
        final messenger = ScaffoldMessenger.of(context);
        final repo = await ref.read(deviceRepositoryProvider.future);
        final result = await repo.deleteDevice(deviceId);
        if (!context.mounted) {
          return;
        }
        switch (result) {
          case Success():
            messenger.showSnackBar(
              const SnackBar(content: Text('サーバーからデバイスを削除しました')),
            );
            await onReload();
          case Failure(:final exception):
            messenger.showSnackBar(
              SnackBar(
                content: Text('削除に失敗しました: $exception'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
        }
      });
    }

    Future<void> saveNotificationSettings() async {
      if (device == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('先にデバイスを登録してください')),
        );
        return;
      }
      await runWithBusy(() async {
        final messenger = ScaffoldMessenger.of(context);
        final repo = await ref.read(pushNotificationRepositoryProvider.future);
        final result = await repo.patchNotificationSettings(
          deviceId: deviceId,
          settings: GeneralNotificationSettings(
            tsunamiEnabled: tsunami.value,
            trainingEnabled: training.value,
          ),
        );
        if (!context.mounted) {
          return;
        }
        switch (result) {
          case Success():
            messenger.showSnackBar(
              const SnackBar(content: Text('通知条件を更新しました')),
            );
            await onReload();
          case Failure(:final exception):
            messenger.showSnackBar(
              SnackBar(
                content: Text('更新に失敗しました: $exception'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
        }
      });
    }

    const mono = TextStyle(fontFamily: FontFamily.notoSansMono);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: [
        Text(
          '端末 ID',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        SelectableText(deviceId, style: mono),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: () async =>
                Clipboard.setData(ClipboardData(text: deviceId)),
            icon: const Icon(Icons.copy, size: 18),
            label: const Text('コピー'),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'サーバー上の状態',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        if (device == null)
          Text(
            '未登録（またはこの端末 ID のレコードがありません）',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          )
        else ...[
          _InfoRow(label: 'デバイス ID', value: device!.id),
          _InfoRow(label: 'プラットフォーム', value: device!.platform.displayLabel),
          _InfoRow(label: 'ロケール', value: device!.locale.name),
        ],
        const SizedBox(height: 16),
        Text(
          'デバイスの登録・編集・削除',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        Text(
          'デバイスレコードの更新は API 上 PUT（登録と同じエンドポイント）です。',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.icon(
              onPressed: isBusy.value ? null : () async => registerOrRefresh(),
              icon: isBusy.value
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                    )
                  : const Icon(Icons.cloud_upload_outlined),
              label: Text(device == null ? 'サーバーに登録' : '再登録（PUT）'),
            ),
            FilledButton.tonalIcon(
              onPressed: device == null || isBusy.value
                  ? null
                  : () async => deleteDevice(),
              icon: const Icon(Icons.delete_outline),
              label: const Text('削除'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          '通知条件（全般）',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('津波情報の通知'),
          value: tsunami.value,
          onChanged: device == null || isBusy.value
              ? null
              : (v) {
                  tsunami.value = v;
                },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('訓練報・試験報の通知'),
          value: training.value,
          onChanged: device == null || isBusy.value
              ? null
              : (v) {
                  training.value = v;
                },
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton(
            onPressed: device == null || isBusy.value
                ? null
                : () async => saveNotificationSettings(),
            child: isBusy.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                  )
                : const Text('通知条件をサーバーに反映'),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: const TextStyle(fontFamily: FontFamily.notoSansMono),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

bool _isNotFound(Object e) =>
    e is DioException && e.response?.statusCode == 404;
