// ignore_for_file: avoid_classes_with_only_static_members

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(
  obfuscate: true,
  requireEnvFile: true,
  useConstantCase: true,
)
abstract class Env {
  @EnviedField()
  static final String restApiUrl = _Env.restApiUrl;
  @EnviedField()
  static final String wsApiUrl = _Env.wsApiUrl;
  @EnviedField()
  static final String apiAuthorization = _Env.apiAuthorization;
}
