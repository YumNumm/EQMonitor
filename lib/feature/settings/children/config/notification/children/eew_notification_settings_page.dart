import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/config/notification/fcm_topic_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EewNotificationSettingsPage extends ConsumerWidget {
  const EewNotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('緊急地震速報 通知設定'),
      ),
      body: ListView(
        children: [
          const _InformationCard(
            icon: Icon(Icons.info),
            title: '緊急地震速報通知についての注意',
            description: '現在、重大な通知には対応していません。マナーモード時には、鳴動しません。\n'
                'また、現在地に基づいた通知・震度4以下の詳細な通知条件分岐には対応していません。\n'
                '詳しくは、ロードマップをご覧ください。',
          ),
          FloatingActionButton.extended(
            onPressed: () async {
              await ref
                  .read(fcmTopicManagerProvider.notifier)
                  .registerToTopic(const FcmEewAllTopic());
            },
            label: const Text('EEW ALLを購読する'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class _InformationCard extends StatelessWidget {
  const _InformationCard({
    required this.title,
    required this.description,
    required this.icon,
  });
  final Widget icon;
  final String title;

  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BorderedContainer(
      elevation: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info,
            color: theme.colorScheme.onSurface,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
