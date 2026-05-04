// ignore_for_file: do_not_use_environment

import 'package:freezed_annotation/freezed_annotation.dart';

part 'environment.freezed.dart';
part 'environment.g.dart';

@JsonEnum()
enum Flavor { dev, prod }

@freezed
abstract class BuildConfig with _$BuildConfig {
  const factory BuildConfig({
    required String restApiUrl,
    required String appIdSuffix,
    required String appName,
    required String commitInformation,
    required Flavor flavor,
    required String wsApiUrl,
    required String googleIosClientId,
    required String googleAndroidClientId,
    required String buildTimestamp,
    required String buildCommitMessage,
  }) = _BuildConfig;

  factory BuildConfig.fromJson(Map<String, dynamic> json) =>
      _$BuildConfigFromJson(json);

  factory BuildConfig.fromEnvironment() => BuildConfig(
    restApiUrl: const String.fromEnvironment('REST_API_URL'),
    appIdSuffix: const String.fromEnvironment('APP_ID_SUFFIX'),
    appName: const String.fromEnvironment('APP_NAME'),
    commitInformation: const String.fromEnvironment('COMMIT_INFORMATION'),
    flavor: Flavor.values.byName(
      const String.fromEnvironment('FLAVOR'),
    ),
    wsApiUrl: const String.fromEnvironment('WS_API_URL'),
    googleIosClientId: const String.fromEnvironment('GOOGLE_IOS_CLIENT_ID'),
    googleAndroidClientId: const String.fromEnvironment(
      'GOOGLE_ANDROID_CLIENT_ID',
    ),
    buildTimestamp: const String.fromEnvironment('BUILD_TIMESTAMP'),
    buildCommitMessage: const String.fromEnvironment('BUILD_COMMIT_MESSAGE'),
  );

  const BuildConfig._();

  bool get isBetaTesting => const bool.fromEnvironment('IS_BETA_TESTING');
}
