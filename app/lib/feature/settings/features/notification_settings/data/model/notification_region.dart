import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_region.freezed.dart';

@freezed
abstract class NotificationRegion with _$NotificationRegion {
  const factory NotificationRegion({
    required int regionId,
    required String? regionName,
    required bool isCurrentLocation,
    required JmaIntensity minJmaIntensity,
    // 市区町村コード (NULL = region 単位の通知設定)。
    // EEW 設定では常に NULL (EEW は area_forecast_local_eew コード単位のみ対応)。
    @Default(null) String? cityCode,
    @Default(null) String? cityName,
  }) = _NotificationRegion;
}

extension RegionSettingResponseConverter on api.RegionSettingResponse {
  NotificationRegion get toNotificationRegion => NotificationRegion(
    regionId: regionId.toInt(),
    regionName: regionName,
    cityCode: cityCode,
    cityName: cityName,
    isCurrentLocation: isCurrentLocation,
    minJmaIntensity: minJmaIntensity.toJmaIntensity,
  );
}

extension NotificationRegionToRequest on NotificationRegion {
  api.RegionSettingRequest get toApiRequest => api.RegionSettingRequest(
    regionId: regionId,
    isCurrentLocation: isCurrentLocation,
    minJmaIntensity:
        minJmaIntensity.toApiJmaIntensity ?? api.JmaIntensity.value4,
    regionName: regionName,
    cityCode: cityCode,
    cityName: cityName,
  );
}
