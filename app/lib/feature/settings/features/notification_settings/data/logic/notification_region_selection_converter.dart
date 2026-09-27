import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_selection.dart';

final class const NotificationRegionSelectionConverter() {
  NotificationRegionSelection convert(RegionOption option) {
    if (option.kind == .eewRegion) {
      return NotificationRegionSelection(
        regionCode: option.code,
        regionName: option.name,
      );
    }
    final parentCode = option.parentCode;
    final parentName = option.parentName;
    if (option.kind == .city &&
        option.parentKind == .eewRegion &&
        parentCode != null &&
        parentName != null) {
      return NotificationRegionSelection(
        regionCode: parentCode,
        regionName: parentName,
        cityCode: option.code,
        cityName: option.name,
      );
    }
    throw ArgumentError('通知地域にはEEW区域または親EEW区域付きの市区町村が必要です');
  }
}
