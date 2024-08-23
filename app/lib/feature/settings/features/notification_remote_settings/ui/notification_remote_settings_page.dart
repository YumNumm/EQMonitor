import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:eqmonitor/core/component/widget/error_widget.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/util/fullscreen_loading_overlay.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/model/notification_remote_settings_state.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings_saved_state.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/service/notification_remote_settings_migrate_service.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/ui/components/earthquake_status_widget.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/ui/components/eew_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> _save(
  BuildContext context,
  NotificationRemoteSettingsNotifier notifier,
) async {
  await showFullScreenLoadingOverlay(
    context,
    notifier.save(),
  );
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('通知条件を保存しました'),
      ),
    );
  }
}

class NotificationRemoteSettingsPage extends HookConsumerWidget {
  const NotificationRemoteSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasChanged =
        ref.watch(notificationRemoteSettingsHasChangedFromSavedStateProvider);
    final initialSetup =
        ref.watch(notificationRemoteSettingsInitialSetupNotifierProvider);

    if (initialSetup case AsyncLoading()) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    if (initialSetup case AsyncError(:final error)) {
      return ErrorInfoWidget(
        error: error,
        onRefresh: () =>
            ref.refresh(notificationRemoteSettingsInitialSetupNotifierProvider),
      );
    }

    return PopScope(
      canPop: !hasChanged,
      onPopInvokedWithResult: (value, _) async {
        if (!value) {
          // 保存しなくてよいか確認
          final result = await showOkCancelAlertDialog(
            context: context,
            title: '通知条件設定',
            message: '通知条件が変更されています。変更を保存しますか?',
            okLabel: '保存する',
            cancelLabel: 'キャンセル',
          );
          final _ = switch (result) {
            OkCancelResult.cancel => () {
                if (context.mounted) {
                  ref.invalidate(notificationRemoteSettingsNotifierProvider);
                  Navigator.of(context).pop();
                }
              }(),
            OkCancelResult.ok => () async {
                final notifier = ref
                    .read(notificationRemoteSettingsNotifierProvider.notifier);
                await _save(context, notifier);
                if (context.mounted) {
                  ref.invalidate(notificationRemoteSettingsNotifierProvider);
                  Navigator.of(context).pop();
                }
              }(),
          };
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('通知条件設定'),
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationRemoteSettingsNotifierProvider);

    return switch (state) {
      AsyncLoading() => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              SizedBox(height: 16),
              Text(
                '設定を読み込んでいます...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      AsyncError(:final error) => ErrorInfoWidget(
          error: error,
          onRefresh: () =>
              ref.refresh(notificationRemoteSettingsNotifierProvider),
        ),
      AsyncData(:final value) => _Data(
          state: value,
        ),
    };
  }
}

class _Data extends StatelessWidget {
  const _Data({
    required this.state,
  });
  final NotificationRemoteSettingsState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          EarthquakeStatusWidget(
            earthquake: state.earthquake,
            action: () =>
                const NotificationEarthquakeRoute().push<void>(context),
          ),
          const SizedBox(height: 16),
          EewStatusWidget(
            eew: state.eew,
            action: () => const NotificationEewRoute().push<void>(context),
          ),
        ],
      ),
    );
  }
}
