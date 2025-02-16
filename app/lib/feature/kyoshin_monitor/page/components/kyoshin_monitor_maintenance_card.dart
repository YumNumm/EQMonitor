import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_maintenance_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

class KyoshinMonitorMaintenanceCardnceCard extends ConsumerWidget {
  const KyoshinMonitorMaintenanceCardnceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(kyoshinMonitorSettingsProvider.select((v) => v.useKmoni))) {
      return const SizedBox.shrink();
    }
    final state = ref.watch(kyoshinMonitorMaintenanceProvider);
    return state.maybeWhen(
      data:
          (data) => switch (data.type) {
            MaintenanceMessageType.non => const SizedBox.shrink(),
            _ => BorderedContainer(
              accentColor:
                  data.type == MaintenanceMessageType.highLight
                      ? Colors.orangeAccent.withValues(alpha: 0.2)
                      : null,
              elevation: 1,
              margin:
                  const EdgeInsets.symmetric(horizontal: 12) +
                  const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                children: [
                  const SheetHeader(title: '強震モニタからのお知らせ'),
                  Html(shrinkWrap: true, data: data.message),
                ],
              ),
            ),
          },
      orElse: SizedBox.shrink,
    );
  }
}
