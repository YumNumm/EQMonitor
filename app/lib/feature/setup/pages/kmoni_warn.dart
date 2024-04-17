import 'package:eqmonitor/core/component/button/action_button.dart';
import 'package:eqmonitor/core/component/widget/kmoni_caution.dart';
import 'package:eqmonitor/core/provider/kmoni/viewmodel/kmoni_settings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KmoniWarnPage extends ConsumerWidget {
  const KmoniWarnPage({required this.onNext, super.key});
  final void Function() onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return CustomScrollView(
      physics: const RangeMaintainingScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: SafeArea(
            child: Column(
              children: [
                // 画面上部のタイトル
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '強震モニタを利用しますか?',
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'EQMonitorでは、国立研究開発法人防災科学技術研究所(防災科研)が運用する強震モニタを利用できます。\n'
                    '以下の注意事項をご確認いただき、利用可否を選択してください。',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const KmoniCautionWidget(),
                const Spacer(),
                UseKmoniButton(
                  onDisabled: () {
                    ref.read(kmoniSettingsProvider.notifier).setUseKmoni(
                          value: false,
                        );
                    onNext();
                  },
                  onEnabled: () {
                    ref.read(kmoniSettingsProvider.notifier).setUseKmoni(
                          value: true,
                        );
                    onNext();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class UseKmoniButton extends StatelessWidget {
  const UseKmoniButton({
    super.key,
    required this.onDisabled,
    required this.onEnabled,
  });

  final void Function() onDisabled;
  final void Function() onEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ActionButton.text(
              context: context,
              accentColor: Colors.grey[800],
              text: '利用しない',
              onPressed: onDisabled,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ActionButton.text(
              context: context,
              text: '利用する',
              onPressed: onEnabled,
            ),
          ),
        ],
      ),
    );
  }
}
