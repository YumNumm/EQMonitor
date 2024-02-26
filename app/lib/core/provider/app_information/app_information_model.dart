import 'dart:io';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:version/version.dart';

part 'app_information_model.freezed.dart';
part 'app_information_model.g.dart';

@freezed
class AppInformationModel with _$AppInformationModel {
  const factory AppInformationModel({
    @JsonKey(fromJson: versionFromJson, toJson: versionToJson)
    required Version latestVersion,
    @JsonKey(fromJson: versionFromJsonNullable, toJson: versionToJsonNullable)
    required Version? minimumVersion,
    @JsonKey(fromJson: uriFromJsonNullable, toJson: uriToJsonNullable)
    required Uri? downloadUrl,
    required String? forceUpdateMessage,
    required bool hasUpdate,
    required bool hasForceUpdate,
  }) = _AppInformationModel;

  factory AppInformationModel.fromJson(Map<String, dynamic> json) =>
      _$AppInformationModelFromJson(json);
}

Version versionFromJson(String str) => Version.parse(str);

String versionToJson(Version data) => data.toString();

Version? versionFromJsonNullable(String? str) =>
    str == null ? null : Version.parse(str);

String? versionToJsonNullable(Version? data) => data?.toString();

Uri? uriFromJsonNullable(String? str) => str == null ? null : Uri.parse(str);

String? uriToJsonNullable(Uri? data) => data?.toString();

extension AppInformationEx on AppInformation {
  AppInformationModel toModel({
    required Version currentVersion,
  }) {
    if (!kIsWeb && Platform.isIOS) {
      final latestVersion = Version.parse(iosLatestVersion);
      final minimumVersion =
          iosMinimumVersion == null ? null : Version.parse(iosMinimumVersion!);
      return AppInformationModel(
        latestVersion: latestVersion,
        minimumVersion: minimumVersion,
        downloadUrl: iosDownloadUrl == null ? null : Uri.parse(iosDownloadUrl!),
        forceUpdateMessage: forceUpdateMessage,
        hasUpdate: latestVersion > currentVersion,
        hasForceUpdate: minimumVersion != null &&
            minimumVersion > currentVersion &&
            latestVersion > currentVersion,
      );
    }
    if (!kIsWeb && Platform.isAndroid) {
      final latestVersion = Version.parse(androidLatestVersion);
      final minimumVersion = androidMinimumVersion == null
          ? null
          : Version.parse(androidMinimumVersion!);
      return AppInformationModel(
        latestVersion: latestVersion,
        minimumVersion: minimumVersion,
        downloadUrl:
            androidDownloadUrl == null ? null : Uri.parse(androidDownloadUrl!),
        forceUpdateMessage: forceUpdateMessage,
        hasUpdate: latestVersion > currentVersion,
        hasForceUpdate: minimumVersion != null &&
            minimumVersion > currentVersion &&
            latestVersion > currentVersion,
      );
    }
    return AppInformationModel(
      latestVersion: Version.parse('0.0.0'),
      minimumVersion: null,
      downloadUrl: null,
      forceUpdateMessage: 'UNKNOWN PLATFORM',
      hasUpdate: false,
      hasForceUpdate: false,
    );
  }
}
