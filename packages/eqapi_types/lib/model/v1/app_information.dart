import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_information.freezed.dart';
part 'app_information.g.dart';

@freezed
class AppInformation with _$AppInformation {
  const factory AppInformation({
    required PlatformAppInformation ios,
    required PlatformAppInformation android,
  }) = _AppInformation;

  factory AppInformation.fromJson(Map<String, dynamic> json) =>
      _$AppInformationFromJson(json);
}

@freezed
class PlatformAppInformation with _$PlatformAppInformation {
  const factory PlatformAppInformation({
    required AppVersion? latest,
    required AppVersion? minimum,
    required String? downloadUrl,
  }) = _PlatformAppInformation;

  factory PlatformAppInformation.fromJson(Map<String, dynamic> json) =>
      _$PlatformAppInformationFromJson(json);
}

@freezed
class AppVersion with _$AppVersion {
  const factory AppVersion({
    required String version,
    required String? message,
  }) = _AppVersion;

  factory AppVersion.fromJson(Map<String, dynamic> json) =>
      _$AppVersionFromJson(json);
}
