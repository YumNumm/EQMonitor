import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/telegram_url_model.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_environment_provider.g.dart';

enum AuthEnvironment {
  develop(
    flavor: Flavor.dev,
    appIdSuffix: '.dev',
    baseUrl: 'https://dev.v2.api.eqmonitor.app',
  ),
  production(
    flavor: Flavor.prod,
    appIdSuffix: '',
    baseUrl: 'https://v2.api.eqmonitor.app',
  );

  new({
    required this.flavor,
    required this.appIdSuffix,
    required this.baseUrl,
  });

  final Flavor flavor;
  final String appIdSuffix;
  final String baseUrl;

  Uri get appleAndroidCallbackUri =>
      Uri.parse('$baseUrl/api/auth/apple/android/callback');

  bool isCompatible({
    required BuildConfig buildConfig,
    required TelegramUrlModel telegramUrl,
  }) =>
      buildConfig.flavor == flavor &&
      buildConfig.appIdSuffix == appIdSuffix &&
      AuthEnvironmentUrlMatcher.isExactBaseUrl(
        value: buildConfig.restApiUrl,
        expected: baseUrl,
      ) &&
      AuthEnvironmentUrlMatcher.isExactBaseUrl(
        value: telegramUrl.restApiUrl,
        expected: baseUrl,
      );

  static Result<AuthEnvironment, AuthFailure> resolve({
    required BuildConfig buildConfig,
    required TelegramUrlModel telegramUrl,
  }) {
    final environment = switch (buildConfig.flavor) {
      Flavor.dev => AuthEnvironment.develop,
      Flavor.prod => AuthEnvironment.production,
    };
    if (!environment.isCompatible(
      buildConfig: buildConfig,
      telegramUrl: telegramUrl,
    )) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.environmentMismatch),
      );
    }
    return Success(environment);
  }
}

final class AuthEnvironmentUrlMatcher {
  const new();

  static bool isExactBaseUrl({
    required String value,
    required String expected,
  }) {
    final uri = Uri.tryParse(value);
    final expectedUri = Uri.parse(expected);
    return uri != null &&
        uri.scheme == 'https' &&
        uri.userInfo.isEmpty &&
        !uri.hasPort &&
        uri.host == expectedUri.host &&
        (uri.path.isEmpty || uri.path == '/') &&
        uri.query.isEmpty &&
        uri.fragment.isEmpty;
  }
}

@riverpod
Future<Result<AuthEnvironment, AuthFailure>> authEnvironment(Ref ref) async {
  final buildConfig = ref.watch(buildConfigProvider);
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  return AuthEnvironment.resolve(
    buildConfig: buildConfig,
    telegramUrl: telegramUrl,
  );
}
