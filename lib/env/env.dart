// ignore_for_file: avoid_classes_with_only_static_members

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(
  obfuscate: true,
  requireEnvFile: true,
)
abstract class Env {
  @EnviedField(varName: 'REST_API_URL')
  static final String restApiUrl = _Env.restApiUrl;
  @EnviedField(varName: 'WS_API_URL')
  static final String wsApiUrl = _Env.wsApiUrl;
  @EnviedField(varName: 'API_AUTHORIZATION')
  static final String apiAuthorization = _Env.apiAuthorization;
}
