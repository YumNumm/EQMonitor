import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_selection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';

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

  /// 登録済みの通知地域を、地域選択画面で照合できる形へ変換する。
  List<RegionOption> registered(List<NotificationSlot> slots) => [
    for (final slot in slots)
      if (slot.slotType == .region)
        if ((slot.regionId, slot.cityCode, slot.cityName) case (
          final regionId?,
          final cityCode?,
          final cityName?,
        ))
          RegionOption(
            kind: .city,
            code: cityCode,
            name: cityName,
            parentKind: .region,
            parentCode: regionId.toString(),
            parentName: slot.regionName,
          )
        else if (slot.regionId case final regionId? when slot.cityCode == null)
          RegionOption(
            kind: .region,
            code: regionId.toString(),
            name: slot.regionName ?? regionId.toString(),
          ),
  ];
}
