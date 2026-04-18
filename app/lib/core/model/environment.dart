// ignore_for_file: do_not_use_environment

import 'package:freezed_annotation/freezed_annotation.dart';

part 'environment.freezed.dart';
part 'environment.g.dart';

@JsonEnum()
enum Flavor { dev, prod }

@freezed
abstract class Environment with _$Environment {
  const factory Environment({
    required String restApiUrl,
    required String appIdSuffix,
    required String appName,
    required String commitInformation,
    required Flavor flavor,
    required String wsApiUrl,
    required String googleIosClientId,
    required String googleAndroidClientId,
  }) = _Environment;
  
  const Environment._();

  factory Environment.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentFromJson(json);

  factory Environment.fromEnvironment() => Environment(
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
  );
}
