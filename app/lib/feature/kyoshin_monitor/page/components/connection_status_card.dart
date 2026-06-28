import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/connectivity/connectivity_provider.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConnectionStatusCard extends ConsumerWidget {
  const ConnectionStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = ref.watch(isNetworkConnectedProvider);
    final wsPhase = ref.watch(
      eqMonitorWsStatusProvider.select((s) => s.phase),
    );

    final designSystem = context.designSystem;
    final palette = designSystem.palette;

    final (IconData icon, String label, Color color) = switch ((
      isConnected,
      wsPhase,
    )) {
      (false, _) => (
        Icons.wifi_off_rounded,
        'ネットワーク未接続',
        palette.statusDanger,
      ),
      (true, .connected) => (
        Icons.cell_tower_rounded,
        'リアルタイム 接続',
        palette.statusSuccess,
      ),
      (true, _) => (
        Icons.warning_amber_rounded,
        'リアルタイム 接続',
        palette.statusWarning,
      ),
    };

    return Card.outlined(
      color: designSystem.color.surfaceCard.withValues(alpha: 0.92),
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(designSystem.shape.md),
        side: BorderSide(color: designSystem.color.outlineSoft),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: designSystem.spacing.sm,
          vertical: designSystem.spacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: designSystem.typography.monoMedium.copyWith(
                color: color,
                fontSize: 12,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
