import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/config/notification/fcm_topic_manager.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/children/config/notification/children/eew/eew_notification_settings_view_model.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EewNotificationSettingsPage extends ConsumerWidget {
  const EewNotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choices = EewNotificationsSettingsViewModel.choices;
    final state = ref.watch(eewNotificationsSettingsViewModelProvider);

    Future<void> onSwitchChanged({required bool value}) async {
      showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (_) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ).ignore();
      final Result<void, Exception> result;
      if (value) {
        // しない -> すべて
        result = await ref
            .read(
              eewNotificationsSettingsViewModelProvider.notifier,
            )
            .registerToTopic(const FcmEewAllTopic());
      } else {
        // 任意のTopic -> しない
        result = await ref
            .read(
              eewNotificationsSettingsViewModelProvider.notifier,
            )
            .unregisterFromTopic();
      }
      if (!context.mounted) {
        return;
      }
      if (result case Failure(:final exception, :final stackTrace)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '通知設定の変更に失敗しました: $exception',
            ),
          ),
        );
        ref.read(talkerProvider).error(exception, exception, stackTrace);
      }
      if (context.mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('緊急地震速報 通知設定'),
      ),
      body: Column(
        children: [
          BorderedContainer(
            elevation: 1,
            padding: EdgeInsets.zero,
            child: SwitchListTile.adaptive(
              value: state != null,
              onChanged: (value) => onSwitchChanged(value: value),
              title: const Text('地震情報の通知を受信する'),
            ),
          ),
          const _InformationCard(
            icon: Icon(Icons.info),
            title: '緊急地震速報通知についての注意',
            description: '現在、重大な通知には対応していません。\n'
                'また、現在地に基づいた通知などの詳細な通知条件分岐には対応していません。\n'
                '詳しくは、ロードマップをご覧ください。',
          ),
          const Divider(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state == null
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SettingsSectionHeader(
                          text: '予想最大震度',
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: choices.length,
                            itemBuilder: (_, index) {
                              final choice = choices[index];
                              return RadioListTile.adaptive(
                                groupValue: state,
                                value: choice,
                                onChanged: (value) async {
                                  showDialog<void>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) => const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  ).ignore();
                                  final result = await ref
                                      .read(
                                        eewNotificationsSettingsViewModelProvider
                                            .notifier,
                                      )
                                      .registerToTopic(choice);
                                  if (!context.mounted) {
                                    return;
                                  }
                                  if (result
                                      case Failure(
                                        :final exception,
                                        :final stackTrace
                                      )) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '通知設定の変更に失敗しました: $exception',
                                        ),
                                      ),
                                    );
                                    ref.read(talkerProvider).error(
                                          exception,
                                          exception,
                                          stackTrace,
                                        );
                                  }
                                  if (context.mounted &&
                                      Navigator.of(context).canPop()) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                title: Text(
                                  switch (choice) {
                                    FcmEewAllTopic() => 'すべて',
                                    FcmEewIntensityTopic(:final intensity)
                                        when intensity == JmaIntensity.seven =>
                                      '震度7',
                                    FcmEewIntensityTopic(:final intensity) =>
                                      '震度${intensity.type}以上'
                                          .replaceAll('+', '強')
                                          .replaceAll('-', '弱'),
                                    _ => ''
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
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
