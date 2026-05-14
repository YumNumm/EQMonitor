import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/live_activity/data/notifier/live_activity_test_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

const _eewScenarios = <(api.Scenario, String, String)>[
  (
    api.Scenario.noto4reports,
    '能登 4 報',
    '震度4 → 5+ → 6+ → 7（警報級まで成長）',
  ),
  (
    api.Scenario.onePointGrowth,
    '1点検知成長',
    '1点検知 → 通常 → 通常 → 確定（小規模）',
  ),
];

const _shakeScenarios = <(api.Scenario, String, String)>[
  (
    api.Scenario.shakeGrowth,
    'レベル成長',
    'Weak → Medium → Strong → Stronger',
  ),
  (
    api.Scenario.shakeWarning,
    '警報級継続',
    'Strong → Stronger → Stronger → Strong',
  ),
];

class LiveActivityTestPage extends ConsumerWidget {
  const LiveActivityTestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(liveActivityTestProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Live Activity デバッグ')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          const _IntroCard(),
          const SizedBox(height: 16),
          _EewScenarioCard(eewScenario: state.eewScenario),
          if (state.lastEewResult case final result?)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: _LastResultCard(
                title: 'EEW シナリオ最終実行',
                result: result,
              ),
            ),
          const SizedBox(height: 24),
          _ShakeScenarioCard(shakeScenario: state.shakeScenario),
          if (state.lastShakeResult case final result?)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: _LastResultCard(
                title: '揺れ検知 シナリオ最終実行',
                result: result,
              ),
            ),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('動作確認の流れ', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              '実機の APNs (LIVE_ACTIVITY_START トークン) に向けて 4 報シーケンスを送信します。 '
              '1 報目で Live Activity が起動した後、サーバが update トークンの登録を最大 15 秒待機し、 '
              '4 秒間隔で残り 3 報を update として配信します。',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _EewScenarioCard extends ConsumerWidget {
  const _EewScenarioCard({required this.eewScenario});

  final api.Scenario eewScenario;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mutationState = ref.watch(LiveActivityTestNotifier.runEewMutation);
    final isPending = mutationState is MutationPending;

    ref.listen<MutationState<api.LiveActivityTestScenarioResponse>>(
      LiveActivityTestNotifier.runEewMutation,
      (_, next) {
        switch (next) {
          case MutationError(:final error):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('EEW シナリオ送信に失敗: $error')),
            );
          case MutationSuccess(:final value):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'EEW シナリオを起動しました (${value.reportsPlanned} 報)',
                ),
              ),
            );
          case _:
            break;
        }
      },
    );

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('EEW シナリオ', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              '緊急地震速報の 4 報シーケンスを送信します',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            RadioGroup<api.Scenario>(
              groupValue: eewScenario,
              onChanged: (value) {
                if (isPending || value == null) {
                  return;
                }
                ref
                    .read(liveActivityTestProvider.notifier)
                    .selectEewScenario(value);
              },
              child: Column(
                children: [
                  for (final entry in _eewScenarios)
                    RadioListTile<api.Scenario>(
                      value: entry.$1,
                      title: Text(entry.$2),
                      subtitle: Text(entry.$3),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: isPending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.flash_on),
                label: const Text('EEW シナリオを実行'),
                onPressed: isPending
                    ? null
                    : () async {
                        await LiveActivityTestNotifier.runEewMutation.run(
                          ref,
                          (tsx) async => tsx
                              .get(liveActivityTestProvider.notifier)
                              .runEewScenario(),
                        );
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShakeScenarioCard extends ConsumerWidget {
  const _ShakeScenarioCard({required this.shakeScenario});

  final api.Scenario shakeScenario;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mutationState = ref.watch(LiveActivityTestNotifier.runShakeMutation);
    final isPending = mutationState is MutationPending;

    ref.listen<MutationState<api.LiveActivityTestScenarioResponse>>(
      LiveActivityTestNotifier.runShakeMutation,
      (_, next) {
        switch (next) {
          case MutationError(:final error):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('揺れ検知シナリオ送信に失敗: $error')),
            );
          case MutationSuccess(:final value):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '揺れ検知シナリオを起動しました (${value.reportsPlanned} 報)',
                ),
              ),
            );
          case _:
            break;
        }
      },
    );

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('揺れ検知 シナリオ', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              '揺れ検知レベルが変化する 4 報シーケンスを送信します',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            RadioGroup<api.Scenario>(
              groupValue: shakeScenario,
              onChanged: (value) {
                if (isPending || value == null) {
                  return;
                }
                ref
                    .read(liveActivityTestProvider.notifier)
                    .selectShakeScenario(value);
              },
              child: Column(
                children: [
                  for (final entry in _shakeScenarios)
                    RadioListTile<api.Scenario>(
                      value: entry.$1,
                      title: Text(entry.$2),
                      subtitle: Text(entry.$3),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: isPending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.sensors_rounded),
                label: const Text('揺れ検知シナリオを実行'),
                onPressed: isPending
                    ? null
                    : () async {
                        await LiveActivityTestNotifier.runShakeMutation.run(
                          ref,
                          (tsx) async => tsx
                              .get(liveActivityTestProvider.notifier)
                              .runShakeScenario(),
                        );
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LastResultCard extends StatelessWidget {
  const _LastResultCard({required this.title, required this.result});

  final String title;
  final api.LiveActivityTestScenarioResponse result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleSmall),
            const SizedBox(height: 12),
            _ResultRow(label: 'event_id', value: result.eventId),
            const SizedBox(height: 8),
            _ResultRow(label: 'live_activity_id', value: result.liveActivityId),
            const SizedBox(height: 8),
            _ResultRow(
              label: 'reports_planned',
              value: result.reportsPlanned.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 132,
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () async => Clipboard.setData(ClipboardData(text: value)),
            child: Text(
              value,
              style: const TextStyle(fontFamily: FontFamily.googleSansCode),
            ),
          ),
        ),
      ],
    );
  }
}
