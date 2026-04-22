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
  }) = _NotificationRegion;
}

extension RegionSettingResponseConverter on api.RegionSettingResponse {
  NotificationRegion get toNotificationRegion => NotificationRegion(
    regionId: regionId.toInt(),
    regionName: regionName,
    isCurrentLocation: isCurrentLocation,
    minJmaIntensity: minJmaIntensity.toJmaIntensity,
  );
}

extension NotificationRegionToRequest on NotificationRegion {
  api.RegionSettingRequest get toApiRequest => api.RegionSettingRequest(
    regionId: regionId,
    isCurrentLocation: isCurrentLocation,
    minJmaIntensity: minJmaIntensity.toApiJmaIntensity ?? api.JmaIntensity.value4,
    regionName: regionName,
  );
}
