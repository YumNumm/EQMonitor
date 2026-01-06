import 'package:freezed_annotation/freezed_annotation.dart';

part 'region_setting.freezed.dart';
part 'region_setting.g.dart';

/// デバイス設定用JMA震度
/// API用に震度0を含む
@JsonEnum(valueField: 'value')
enum DeviceJmaIntensity {
  @JsonValue('0')
  zero('0'),
  @JsonValue('1')
  one('1'),
  @JsonValue('2')
  two('2'),
  @JsonValue('3')
  three('3'),
  @JsonValue('4')
  four('4'),
  @JsonValue('!5-')
  unknownFiveLower('!5-'),
  @JsonValue('5-')
  fiveLower('5-'),
  @JsonValue('5+')
  fiveUpper('5+'),
  @JsonValue('6-')
  sixLower('6-'),
  @JsonValue('6+')
  sixUpper('6+'),
  @JsonValue('7')
  seven('7')
  ;

  const DeviceJmaIntensity(this.value);
  final String value;

  String get displayName {
    switch (this) {
      case DeviceJmaIntensity.zero:
        return '震度0';
      case DeviceJmaIntensity.one:
        return '震度1';
      case DeviceJmaIntensity.two:
        return '震度2';
      case DeviceJmaIntensity.three:
        return '震度3';
      case DeviceJmaIntensity.four:
        return '震度4';
      case DeviceJmaIntensity.unknownFiveLower:
        return '震度5弱以上と推定';
      case DeviceJmaIntensity.fiveLower:
        return '震度5弱';
      case DeviceJmaIntensity.fiveUpper:
        return '震度5強';
      case DeviceJmaIntensity.sixLower:
        return '震度6弱';
      case DeviceJmaIntensity.sixUpper:
        return '震度6強';
      case DeviceJmaIntensity.seven:
        return '震度7';
    }
  }
}

/// リージョン設定
@freezed
abstract class RegionSetting with _$RegionSetting {
  const factory RegionSetting({
    required int regionId,
    String? regionName,
    required bool isCurrentLocation,
    required DeviceJmaIntensity minJmaIntensity,
    required String createdAt,
    required String updatedAt,
  }) = _RegionSetting;

  factory RegionSetting.fromJson(Map<String, dynamic> json) =>
      _$RegionSettingFromJson(json);
}

/// リージョン設定リクエスト
@freezed
abstract class RegionSettingRequest with _$RegionSettingRequest {
  const factory RegionSettingRequest({
    required int regionId,
    String? regionName,
    required bool isCurrentLocation,
    required DeviceJmaIntensity minJmaIntensity,
  }) = _RegionSettingRequest;

  factory RegionSettingRequest.fromJson(Map<String, dynamic> json) =>
      _$RegionSettingRequestFromJson(json);
}

/// リージョン設定更新リクエスト
@freezed
abstract class RegionSettingPatchRequest with _$RegionSettingPatchRequest {
  const factory RegionSettingPatchRequest({
    String? regionName,
    bool? isCurrentLocation,
    DeviceJmaIntensity? minJmaIntensity,
  }) = _RegionSettingPatchRequest;

  factory RegionSettingPatchRequest.fromJson(Map<String, dynamic> json) =>
      _$RegionSettingPatchRequestFromJson(json);
}
