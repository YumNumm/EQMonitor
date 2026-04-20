import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
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
    final latestTime = ref
        .watch(
          kyoshinMonitorProvider.select(
            (v) => v.value?.lastUpdatedAt,
          ),
        )
        ?.toLocal();
    final status =
        ref.watch(
          kyoshinMonitorProvider.select((v) => v.value?.status),
        ) ??
        KyoshinMonitorStatus.stopped;

    final designSystem = context.designSystem;
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
    final dateTextStyle = designSystem.typography.monoMedium.copyWith(
      letterSpacing: -0.5,
    );

    return Card.outlined(
      color: designSystem.color.surfaceCard.withValues(alpha: 0.92),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(designSystem.shape.md),
        side: BorderSide(color: designSystem.color.outlineSoft),
      ),
      child: Tooltip(
        message: '強震モニタ',
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(designSystem.shape.md),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: designSystem.spacing.sm,
              vertical: designSystem.spacing.xs,
            ),
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
                      Flexible(
                        child: Text(
                          dateFormat.format(
                            latestTime,
                          ),
                          style: dateTextStyle,
                        ),
                      ),
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
