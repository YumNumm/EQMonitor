import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class KyoshinMonitorStatusCard extends ConsumerWidget {
  const KyoshinMonitorStatusCard({this.onTap, super.key});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestTime =
        ref
            .watch(
              kyoshinMonitorNotifierProvider.select(
                (v) => v.valueOrNull?.lastUpdatedAt,
              ),
            )
            ?.toLocal();
    final status =
        ref.watch(
          kyoshinMonitorNotifierProvider.select((v) => v.valueOrNull?.status),
        ) ??
        KyoshinMonitorStatus.stopped;

    final theme = Theme.of(context);
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
    final dateTextStyle = theme.textTheme.bodyMedium!.copyWith(
      letterSpacing: -0.5,
      fontFamily: FontFamily.jetBrainsMono,
      fontFamilyFallback: [FontFamily.notoSansJP],
    );

    return Card.outlined(
      color: theme.colorScheme.surfaceContainerHighest,
      elevation: 0,
      child: Tooltip(
        message: '強震モニタ',
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: DefaultTextStyle(
              style: dateTextStyle,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 現在時刻
                  ...switch (status) {
                    KyoshinMonitorStatus.stopped => [
                      const Icon(Icons.access_time_rounded, size: 16),
                      const SizedBox(width: 4),
                      const Flexible(child: Text('強震モニタ 取得停止中')),
                    ],
                    _
                        when latestTime != null &&
                            status == KyoshinMonitorStatus.delayed =>
                      [
                        Flexible(
                          child: Text(
                            DateFormat(
                              'yyyy/MM/dd HH:mm:ss',
                            ).format(latestTime),
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    _ when latestTime != null => [
                      Flexible(child: Text(dateFormat.format(latestTime))),
                    ],
                    _ => [
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ],
                  },
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
