import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_selection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_region_add_action.g.dart';

@riverpod
NotificationRegionAddAction notificationRegionAddAction(Ref ref) =>
    const NotificationRegionAddAction();

final class NotificationRegionAddAction {
  const NotificationRegionAddAction();

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
