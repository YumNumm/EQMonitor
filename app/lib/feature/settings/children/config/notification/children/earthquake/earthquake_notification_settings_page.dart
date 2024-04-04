import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/children/config/notification/children/earthquake/earthquake_notification_settings_view_model.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeNotificationSettingsPage extends ConsumerWidget {
  const EarthquakeNotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choices = EarthquakeNotificationSettingsViewModel.choices;
    final state = ref.watch(earthquakeNotificationSettingsViewModelProvider);

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
              earthquakeNotificationSettingsViewModelProvider.notifier,
            )
            .registerToTopic(choices.first);
      } else {
        // 任意のTopic -> しない
        result = await ref
            .read(
              earthquakeNotificationSettingsViewModelProvider.notifier,
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
        title: const Text('地震情報 通知設定'),
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
                          text: '最大震度',
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: choices.length,
                            itemBuilder: (context, index) {
                              final choice = choices[index];
                              return RadioListTile.adaptive(
                                groupValue: state,
                                value: choice,
                                onChanged: (value) async {
                                  unawaited(
                                    showDialog<void>(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) => const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      ),
                                    ),
                                  );
                                  final result = await ref
                                      .read(
                                        earthquakeNotificationSettingsViewModelProvider
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
                                  switch (choice.intensity) {
                                    null => 'すべて',
                                    JmaIntensity.seven => '震度7',
                                    final JmaIntensity intensity =>
                                      '震度${intensity.type}以上',
                                  }
                                      .replaceAll('-', '弱')
                                      .replaceAll('+', '強'),
                                ),
                                visualDensity: VisualDensity.compact,
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
