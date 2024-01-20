import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/config/notification/fcm_topic_manager.dart';
import 'package:eqmonitor/core/provider/config/permission/permission_status_provider.dart';
import 'package:eqmonitor/core/provider/notification_token.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/util/fullscreen_loading_overlay.dart';
import 'package:eqmonitor/feature/settings/children/config/notification/children/earthquake/earthquake_notification_settings_view_model.dart';
import 'package:eqmonitor/feature/settings/children/config/notification/children/eew/eew_notification_settings_view_model.dart';
import 'package:eqmonitor/feature/settings/children/config/notification/notifiication_settings_view_model.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知設定'),
      ),
      body: const _NotificationSettingsBody(),
    );
  }
}

class _NotificationSettingsBody extends HookConsumerWidget {
  const _NotificationSettingsBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame
            .then((_) => ref.read(permissionProvider.notifier).initialize());
        return null;
      },
      [],
    );
    final state = ref.watch(notificationSettingsViewModelProvider);
    if (state.isNotificatioonPermissionAllowed) {
      return const _OnNotificationPermissionAllowed();
    } else {
      return const _OnNotificationPermissionDisallowed();
    }
  }
}

class _OnNotificationPermissionAllowed extends ConsumerWidget {
  const _OnNotificationPermissionAllowed();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final state = ref.watch(notificationSettingsViewModelProvider);
    return ListView(
      children: [
        // 通知権限
        BorderedContainer(
          elevation: 1,
          child: Row(
            children: [
              Icon(
                Icons.check,
                color: colorScheme.onSurface,
              ),
              const SizedBox(width: 8),
              Text(
                '通知権限が許可されています',
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SettingsSectionHeader(
          text: '地震情報',
        ),
        ListTile(
          title: const Text('緊急地震速報(予報・警報)'),
          subtitle: Text(
            switch (ref.watch(eewNotificationsSettingsViewModelProvider)) {
              null => '受信しない',
              FcmEewAllTopic() => 'すべて受信する',
              FcmEewIntensityTopic(:final intensity)
                  when intensity == JmaIntensity.seven =>
                '震度7',
              FcmEewIntensityTopic(:final intensity) => '震度${intensity.type}以上'
                  .replaceAll('+', '強')
                  .replaceAll('-', '弱'),
              _ => '',
            },
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () =>
              context.push(const EewNotificationSettingsRoute().location),
        ),
        ListTile(
          title: const Text('震度・震源に関する情報'),
          subtitle: Text(
            switch (
                ref.watch(earthquakeNotificationSettingsViewModelProvider)) {
              null => '受信しない',
              final FcmEarthquakeTopic topic when topic.intensity == null =>
                'すべて受信する',
              final FcmEarthquakeTopic topic
                  when topic.intensity == JmaIntensity.seven =>
                '震度7のみ',
              final FcmEarthquakeTopic topic => '震度${topic.intensity!.type}以上'
                  .replaceAll('-', '弱')
                  .replaceAll('+', '強'),
            },
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () => context
              .push(const EarthquakeNotificationSettingsRoute().location),
        ),
        SwitchListTile.adaptive(
          value: state.isVzse40Subscribed,
          onChanged: (value) async {
            final notifier =
                ref.read(notificationSettingsViewModelProvider.notifier);
            final result = await showFullScreenLoadingOverlay(
              context,
              value
                  ? notifier.registerToVzse40()
                  : notifier.unregisterFromVzse40(),
            );
            if (!context.mounted) {
              return;
            }
            if (result case Failure(:final exception)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '設定の変更中にエラーが発生しました: $exception',
                  ),
                ),
              );
            }
          },
          title: const Text('地震・津波に関するお知らせ'),
          subtitle: const Text(
            '地震・津波の試験・訓練配信のお知らせ、'
            '自治体震度データの入電停止等のお知らせを配信します',
          ),
        ),
        const SettingsSectionHeader(
          text: 'その他',
        ),
        SwitchListTile.adaptive(
          value: state.isNoticeSubscribed,
          onChanged: (value) async {
            final notifier =
                ref.read(notificationSettingsViewModelProvider.notifier);
            final result = await showFullScreenLoadingOverlay(
              context,
              value
                  ? notifier.registerToNotice()
                  : notifier.unregisterFromNotice(),
            );
            if (!context.mounted) {
              return;
            }
            if (result case Failure(:final exception)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '設定の変更中にエラーが発生しました: $exception',
                  ),
                ),
              );
            }
          },
          title: const Text('お知らせ'),
          subtitle: const Text('アップデート情報や開発者からのお知らせをお伝えします'),
        ),
        const SettingsSectionHeader(text: 'FCM DEBUG'),
        Consumer(
          builder: (context, ref, _) {
            final notificationTokenState = ref.watch(notificationTokenProvider);
            return notificationTokenState.when(
              data: (value) => Column(
                children: [
                  ListTile(
                    title: const Text(
                      'FCM デバイストークン',
                      style: TextStyle(
                        fontFamily: FontFamily.jetBrainsMono,
                      ),
                    ),
                    trailing: Text(
                      value.fcmToken?.obfuscate ?? '不明',
                      style: const TextStyle(
                        fontFamily: FontFamily.jetBrainsMono,
                      ),
                    ),
                    onTap: () => Clipboard.setData(
                      ClipboardData(text: value.fcmToken ?? ''),
                    ).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('コピーしました'),
                        ),
                      );
                    }),
                    visualDensity: VisualDensity.compact,
                  ),
                  ListTile(
                    title: const Text(
                      'APNS デバイストークン',
                      style: TextStyle(
                        fontFamily: FontFamily.jetBrainsMono,
                      ),
                    ),
                    trailing: Text(
                      value.apnsToken?.obfuscate ?? '不明',
                      style: const TextStyle(
                        fontFamily: FontFamily.jetBrainsMono,
                      ),
                    ),
                    onTap: () => Clipboard.setData(
                      ClipboardData(text: value.apnsToken ?? ''),
                    ).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('コピーしました'),
                        ),
                      );
                    }),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              error: (error, stackTrace) => Text(
                'エラーが発生しました: $error',
              ),
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _OnNotificationPermissionDisallowed extends ConsumerWidget {
  const _OnNotificationPermissionDisallowed();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      children: [
        BorderedContainer(
          accentColor: Colors.redAccent.withOpacity(0.1),
          elevation: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.error,
                    color: theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '通知権限が許可されていません',
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset: const Offset(8, 8),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                  ),
                  onPressed: () async {
                    await ref
                        .read(permissionProvider.notifier)
                        .requestNotificationPermission();
                  },
                  child: Text(
                    '許可する',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

extension StringEx on String {
  String get obfuscate {
    final length = this.length;
    if (length <= 8) {
      return '****';
    }
    return [
      substring(0, 4),
      '*' * 8,
      substring(length - 4, length),
    ].join();
  }
}
