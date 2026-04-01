// ignore_for_file: do_not_use_environment

import 'package:freezed_annotation/freezed_annotation.dart';

part 'environment.freezed.dart';
part 'environment.g.dart';

@freezed
abstract class Environment with _$Environment {
  const factory Environment({
    required String restApiUrl,
    required appIdSuffix,
    required String appName,
    required String commitInformation,
  }) = _Environment;
  const Environment._();

  factory Environment.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentFromJson(json);

  factory Environment.fromEnvironment() => const Environment(
    restApiUrl: String.fromEnvironment('REST_API_URL'),
    appIdSuffix: String.fromEnvironment('APP_ID_SUFFIX'),
    appName: String.fromEnvironment('APP_NAME'),
    commitInformation: String.fromEnvironment('COMMIT_INFORMATION'),
  );
}
