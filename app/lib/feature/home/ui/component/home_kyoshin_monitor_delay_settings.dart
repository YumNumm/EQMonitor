import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_image_request_resolver.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_time_sample_calculator.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_delay.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_offset_adjustment_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_timer_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_delay_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_request_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class HomeKyoshinMonitorDelaySettings extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(kyoshinMonitorSettingsProvider).value;
    if (settings == null || !settings.useKmoni) {
      return const SizedBox.shrink();
    }
    final colorTheme = context.designSystem.colorTheme;

    return Column(
      children: [
        const _DelayAdjustTypeTile(),
        Divider(height: 1, color: colorTheme.outlineVariant),
        const _AutoAdjustmentTile(),
        Divider(height: 1, color: colorTheme.outlineVariant),
        const _CurrentDelayTile(),
        Divider(height: 1, color: colorTheme.outlineVariant),
        const _ManualAdjustmentTile(),
        Divider(height: 1, color: colorTheme.outlineVariant),
        const _DelayAdjustIntervalTile(),
        Divider(height: 1, color: colorTheme.outlineVariant),
        const _MinimumOffsetTile(),
        Divider(height: 1, color: colorTheme.outlineVariant),
        const _MaximumOffsetTile(),
        Divider(height: 1, color: colorTheme.outlineVariant),
        const _ImageFetchIntervalTile(),
      ],
    );
  }
}

class _DelayAdjustTypeTile extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    final selected = switch (settings.api.delayAdjustType) {
      KyoshinMonitorDelayAdjustType.latestJson ||
      KyoshinMonitorDelayAdjustType.latestJsonMultiple =>
        KyoshinMonitorDelayAdjustType.latestJson,
      KyoshinMonitorDelayAdjustType.imageFetch404DeviceTime ||
      KyoshinMonitorDelayAdjustType.imageFetch404Ntp =>
        KyoshinMonitorDelayAdjustType.imageFetch404Ntp,
    };

    return _DelayDropdownField<KyoshinMonitorDelayAdjustType>(
      title: '遅延調整方式',
      subtitle: '画像の公開時刻に合わせる方法を選択します。',
      value: selected,
      entries: const [
        DropdownMenuEntry(
          value: KyoshinMonitorDelayAdjustType.imageFetch404Ntp,
          label: '404 フィードバック（NTP）',
        ),
        DropdownMenuEntry(
          value: KyoshinMonitorDelayAdjustType.latestJson,
          label: 'latest.json の値を使用',
        ),
      ],
      onChanged: (next) async {
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(
              settings.copyWith(
                api: settings.api.copyWith(delayAdjustType: next),
              ),
            );
      },
    );
  }
}

class _AutoAdjustmentTile extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    final api = settings.api;
    final isFeedbackMode = switch (api.delayAdjustType) {
      KyoshinMonitorDelayAdjustType.imageFetch404DeviceTime ||
      KyoshinMonitorDelayAdjustType.imageFetch404Ntp => true,
      KyoshinMonitorDelayAdjustType.latestJson ||
      KyoshinMonitorDelayAdjustType.latestJsonMultiple => false,
    };
    if (!isFeedbackMode) {
      return const SizedBox.shrink();
    }
    final spacing = context.designSystem.spacing;
    final typography = context.designSystem.typography;

    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(
        spacing.xl,
        spacing.sm + 2,
        spacing.lg,
        spacing.sm + 2,
      ),
      title: Text(
        '遅延を自動調整',
        style: typography.titleSmall.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '画像の未公開エラーと取得成功をもとに補正値を学習します。',
        style: typography.bodySmall,
      ),
      trailing: AppSwitch(
        value: api.autoOffsetIncrement,
        onChanged: (next) async {
          await ref
              .read(kyoshinMonitorSettingsProvider.notifier)
              .save(
                settings.copyWith(
                  api: api.copyWith(autoOffsetIncrement: next),
                ),
              );
        },
      ),
      onTap: () async {
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(
              settings.copyWith(
                api: api.copyWith(
                  autoOffsetIncrement: !api.autoOffsetIncrement,
                ),
              ),
            );
      },
    );
  }
}

class _CurrentDelayTile extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = ref.watch(kyoshinMonitorImageRequestProvider);
    final timerState = ref.watch(kyoshinMonitorTimerProvider).value;
    final ntpOffset = ref.watch(ntpProvider).value?.offset ?? Duration.zero;
    final adjustment = ref.watch(
      kyoshinMonitorOffsetAdjustmentProvider.select(
        (value) => value[request.delayProfile] ?? Duration.zero,
      ),
    );
    final imageDelay = ref.watch(kyoshinMonitorImageDelayProvider);
    final publishDelay = timerState == null
        ? null
        : ref
              .read(kyoshinMonitorTimeSampleCalculatorProvider)
              .publishDelay(shift: timerState.shift, ntpOffset: ntpOffset);
    final profileLabel = switch (request.delayProfile) {
      KyoshinMonitorDelayProfile.kmoni => '強震モニタ',
      KyoshinMonitorDelayProfile.lpgm => '長周期地震動',
    };
    final publishDelayLabel = publishDelay == null
        ? '測定中'
        : '${publishDelay.inMilliseconds} ms';
    final imageDelayLabel = imageDelay == null
        ? '測定中'
        : '${imageDelay.inMilliseconds} ms';
    final spacing = context.designSystem.spacing;
    final typography = context.designSystem.typography;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.xl,
        spacing.lg,
        spacing.xl,
        spacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '現在の遅延',
            style: typography.titleSmall.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: spacing.xs),
          Text('対象: $profileLabel', style: typography.bodySmall),
          Text('公開遅延: $publishDelayLabel', style: typography.bodySmall),
          Text(
            '調整値: ${adjustment.inMilliseconds} ms',
            style: typography.bodySmall,
          ),
          Text('適用値: $imageDelayLabel', style: typography.bodySmall),
          SizedBox(height: spacing.sm),
          TextButton.icon(
            onPressed: adjustment == Duration.zero
                ? null
                : () async {
                    await ref
                        .read(
                          kyoshinMonitorOffsetAdjustmentProvider.notifier,
                        )
                        .resetAdjustment(request.delayProfile);
                  },
            icon: const Icon(Icons.restart_alt_rounded),
            label: const Text('調整値をリセット'),
          ),
        ],
      ),
    );
  }
}

class _ManualAdjustmentTile extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    final request = ref.watch(kyoshinMonitorImageRequestProvider);
    final api = settings.api;
    final config = ref
        .watch(kyoshinMonitorImageRequestResolverProvider)
        .delayAdjustConfig(api);
    final adjustment = ref.watch(
      kyoshinMonitorOffsetAdjustmentProvider.select(
        (value) => value[request.delayProfile] ?? Duration.zero,
      ),
    );
    final isFeedbackMode = switch (api.delayAdjustType) {
      KyoshinMonitorDelayAdjustType.imageFetch404DeviceTime ||
      KyoshinMonitorDelayAdjustType.imageFetch404Ntp => true,
      KyoshinMonitorDelayAdjustType.latestJson ||
      KyoshinMonitorDelayAdjustType.latestJsonMultiple => false,
    };
    final canEdit = isFeedbackMode && !api.autoOffsetIncrement;

    return _DurationSliderTile(
      title: '手動調整値',
      subtitle: canEdit ? '正の値ほど古い画像を取得します。' : '自動調整をオフにすると変更できます。',
      valueMilliseconds: adjustment.inMilliseconds.toDouble(),
      minMilliseconds: -config.maxAdjustment.inMilliseconds.toDouble(),
      maxMilliseconds: config.maxAdjustment.inMilliseconds.toDouble(),
      divisions: 100,
      valueLabel: '${adjustment.inMilliseconds} ms',
      onChanged: canEdit
          ? (next) async {
              await ref
                  .read(kyoshinMonitorOffsetAdjustmentProvider.notifier)
                  .setAdjustment(
                    profile: request.delayProfile,
                    adjustment: Duration(milliseconds: next.round()),
                  );
            }
          : null,
    );
  }
}

class _DelayAdjustIntervalTile extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    final seconds = settings.api.delayAdjustInterval.inSeconds;

    return _DurationSliderTile(
      title: '公開時刻の再同期間隔',
      subtitle: 'サーバーの公開遅延を測り直す間隔です。',
      valueMilliseconds: (seconds * 1000).toDouble(),
      minMilliseconds: 10000,
      maxMilliseconds: 300000,
      divisions: 29,
      valueLabel: '$seconds 秒',
      onChanged: (next) async {
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(
              settings.copyWith(
                api: settings.api.copyWith(
                  delayAdjustInterval: Duration(
                    milliseconds: next.round(),
                  ),
                ),
              ),
            );
      },
    );
  }
}

class _MinimumOffsetTile extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    final api = settings.api;
    final milliseconds = api.minOffset.inMilliseconds;

    return _DurationSliderTile(
      title: '公開遅延の下限',
      subtitle: '自動・手動調整で使用する遅延の最小値です。',
      valueMilliseconds: milliseconds.toDouble(),
      minMilliseconds: 200,
      maxMilliseconds: 2000,
      divisions: 18,
      valueLabel: '$milliseconds ms',
      onChanged: (next) async {
        final minOffset = Duration(milliseconds: next.round());
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(
              settings.copyWith(
                api: api.copyWith(
                  minOffset: minOffset,
                  maxOffset: api.maxOffset < minOffset
                      ? minOffset
                      : api.maxOffset,
                ),
              ),
            );
      },
    );
  }
}

class _MaximumOffsetTile extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    final api = settings.api;
    final milliseconds = api.maxOffset.inMilliseconds;

    return _DurationSliderTile(
      title: '公開遅延の上限',
      subtitle: '自動・手動調整で使用する遅延の最大値です。',
      valueMilliseconds: milliseconds.toDouble(),
      minMilliseconds: 1000,
      maxMilliseconds: 10000,
      divisions: 18,
      valueLabel: '$milliseconds ms',
      onChanged: (next) async {
        final maxOffset = Duration(milliseconds: next.round());
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(
              settings.copyWith(
                api: api.copyWith(
                  minOffset: api.minOffset > maxOffset
                      ? maxOffset
                      : api.minOffset,
                  maxOffset: maxOffset,
                ),
              ),
            );
      },
    );
  }
}

class _ImageFetchIntervalTile extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    final seconds = settings.api.imageFetchInterval.inSeconds;

    return _DurationSliderTile(
      title: '画像取得間隔',
      subtitle: '強震モニタ画像を取得する頻度です。',
      valueMilliseconds: (seconds * 1000).toDouble(),
      minMilliseconds: 1000,
      maxMilliseconds: 5000,
      divisions: 4,
      valueLabel: '$seconds 秒',
      onChanged: (next) async {
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(
              settings.copyWith(
                api: settings.api.copyWith(
                  imageFetchInterval: Duration(milliseconds: next.round()),
                ),
              ),
            );
      },
    );
  }
}

class _DelayDropdownField<T> extends StatelessWidget {
  const new({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.entries,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final T value;
  final List<DropdownMenuEntry<T>> entries;
  // ignore: unsafe_variance
  final Future<void> Function(T) onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = context.designSystem.spacing;
    final typography = context.designSystem.typography;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.xl,
        spacing.lg,
        spacing.xl,
        spacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: typography.titleSmall.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: spacing.xs),
          Text(subtitle, style: typography.bodySmall),
          SizedBox(height: spacing.md),
          DropdownMenu<T>(
            width: double.infinity,
            initialSelection: value,
            dropdownMenuEntries: entries,
            onSelected: (next) async {
              if (next != null) {
                await onChanged(next);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _DurationSliderTile extends StatelessWidget {
  const new({
    required this.title,
    required this.subtitle,
    required this.valueMilliseconds,
    required this.minMilliseconds,
    required this.maxMilliseconds,
    required this.divisions,
    required this.valueLabel,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final double valueMilliseconds;
  final double minMilliseconds;
  final double maxMilliseconds;
  final int divisions;
  final String valueLabel;
  final Future<void> Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = context.designSystem.spacing;
    final typography = context.designSystem.typography;
    final onSliderChanged = onChanged;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.xl,
        spacing.lg,
        spacing.xl,
        spacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: typography.titleSmall.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: spacing.xs),
          Text(subtitle, style: typography.bodySmall),
          Slider(
            value: valueMilliseconds
                .clamp(
                  minMilliseconds,
                  maxMilliseconds,
                )
                .toDouble(),
            min: minMilliseconds,
            max: maxMilliseconds,
            divisions: divisions,
            label: valueLabel,
            onChanged: onSliderChanged == null
                ? null
                : (next) async {
                    await onSliderChanged(next);
                  },
          ),
          Text('現在値: $valueLabel', style: typography.bodySmall),
        ],
      ),
    );
  }
}
