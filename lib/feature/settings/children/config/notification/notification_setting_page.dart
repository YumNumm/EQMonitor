import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/config/notification/fcm_topic_manager.dart';
import 'package:eqmonitor/core/provider/config/permission/permission_status_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/settings/children/config/notification/children/earthquake/earthquake_notification_settings_view_model.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame
            .then((_) => ref.read(permissionProvider.notifier).initialize());
        return null;
      },
      [],
    );
    final status = ref.watch(permissionProvider.select((v) => v.notification));
    if (status) {
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
            subtitle: const Text(
              'Unimplemented',
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
            value: true,
            onChanged: (value) {},
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
            value: true,
            onChanged: (value) {},
            title: const Text('お知らせ'),
            subtitle: const Text('アップデート情報や開発者からのお知らせをお伝えします'),
          ),
        ],
      );
    } else {
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
}
