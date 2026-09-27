import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_selection_request.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_selection_converter.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_selection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_region_add_action.g.dart';

@riverpod
NotificationRegionAddAction notificationRegionAddAction(Ref ref) =>
    const NotificationRegionAddAction();

final class const NotificationRegionAddAction() {
  Future<void> pickAndAdd({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final selected = await RegionSelectionRoute(
      $extra: const RegionSelectionRequest(
        title: '通知する地域を選択',
        kinds: [.eewRegion, .city],
        notification: true,
      ),
    ).push<List<RegionOption>>(context);
    final option = selected?.firstOrNull;
    if (option == null || !context.mounted) {
      return;
    }
    await add(
      ref: ref,
      selection: const NotificationRegionSelectionConverter().convert(option),
    );
  }

  Future<void> add({
    required WidgetRef ref,
    required NotificationRegionSelection selection,
  }) async {
    await NotificationSlotsNotifier.addRegionMutation.run(ref, (tsx) async {
      final regionId = int.tryParse(selection.regionCode);
      if (regionId == null) {
        throw const FormatException('Invalid notification region code');
      }
      await tsx
          .get(notificationSlotsProvider.notifier)
          .addRegion(
            regionId: regionId,
            regionName: selection.regionName,
            cityCode: selection.cityCode,
            cityName: selection.cityName,
          );
    });
  }
}
