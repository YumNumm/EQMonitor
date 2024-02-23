import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_information.freezed.dart';
part 'app_information.g.dart';

@Deprecated('Use v1 instead')
@freezed
class AppInformation with _$AppInformation {
  const factory AppInformation({
    required String iosLatestVersion,
    required String androidLatestVersion,
    required String? iosMinimumVersion,
    required String? androidMinimumVersion,
    required String? iosDownloadUrl,
    required String? androidDownloadUrl,
    required String? forceUpdateMessage,
  }) = _AppInformation;

  factory AppInformation.fromJson(Map<String, dynamic> json) =>
      _$AppInformationFromJson(json);
}
