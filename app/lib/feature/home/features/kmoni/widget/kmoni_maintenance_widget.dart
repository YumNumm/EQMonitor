import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:eqmonitor/feature/home/features/kmoni/model/kmoni_maintenance_message_model.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_maintenance_view_model.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KmoniMaintenanceWidget extends ConsumerWidget {
  const KmoniMaintenanceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(kmoniSettingsProvider.select((v) => v.useKmoni))) {
      return const SizedBox.shrink();
    }
    final state = ref.watch(kmoniMaintenanceViewModelProvider);
    return state.maybeWhen(
      data: (data) => switch (data.type) {
        KmoniMaintenanceMessageType.non => const SizedBox.shrink(),
        _ => BorderedContainer(
            accentColor: data.type == KmoniMaintenanceMessageType.highLight
                ? Colors.orangeAccent.withOpacity(0.2)
                : null,
            elevation: 1,
            margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                ) +
                const EdgeInsets.only(
                  bottom: 8,
                ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            child: Column(
              children: [
                const SheetHeader(title: '強震モニタからのお知らせ'),
                Html(
                  shrinkWrap: true,
                  data: data.message,
                ),
              ],
            ),
          ),
      },
      orElse: SizedBox.shrink,
    );
  }
}
