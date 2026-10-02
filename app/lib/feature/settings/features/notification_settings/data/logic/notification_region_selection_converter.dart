import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_selection.dart';

final class const NotificationRegionSelectionConverter() {
  NotificationRegionSelection convert(RegionOption option) {
    if (option.kind == .region) {
      return NotificationRegionSelection(
        regionCode: option.code,
        regionName: option.name,
      );
    }
    final parentCode = option.parentCode;
    final parentName = option.parentName;
    if (option.kind == .city &&
        option.parentKind == .region &&
        parentCode != null &&
        parentName != null) {
      return NotificationRegionSelection(
        regionCode: parentCode,
        regionName: parentName,
        cityCode: option.code,
        cityName: option.name,
      );
    }
    throw ArgumentError('通知地域には細分区域または親細分区域付きの市区町村が必要です');
  }
}
