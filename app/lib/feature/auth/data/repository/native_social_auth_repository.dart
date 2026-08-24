import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/telegram_url_model.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_environment_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/apple_auth_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:eqmonitor/feature/auth/data/repository/google_auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'native_social_auth_repository.g.dart';

@Riverpod(keepAlive: true)
Future<NativeSocialAuthRepository> nativeSocialAuthRepository(Ref ref) async {
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  final apiClient = await ref.watch(betterAuthApiClientProvider.future);
  return NativeSocialAuthRepository(
    apiClient: apiClient,
    googleAuthRepository: ref.watch(googleAuthRepositoryProvider),
    appleAuthRepository: ref.watch(appleAuthRepositoryProvider),
    buildConfig: ref.watch(buildConfigProvider),
    telegramUrl: telegramUrl,
    platform: NativeAuthConfiguration.currentPlatform(),
  );
}

enum NativeAuthPlatform { ios, android, unsupported }

final class NativeSocialAuthRepository {
  new({
    required BetterAuthApiClient apiClient,
    required GoogleAuthGateway googleAuthRepository,
    required AppleAuthGateway appleAuthRepository,
    required BuildConfig buildConfig,
    required TelegramUrlModel telegramUrl,
    required NativeAuthPlatform platform,
  }) : _apiClient = apiClient,
       _googleAuthRepository = googleAuthRepository,
       _appleAuthRepository = appleAuthRepository,
       _buildConfig = buildConfig,
       _telegramUrl = telegramUrl,
       _platform = platform;

  final BetterAuthApiClient _apiClient;
  final GoogleAuthGateway _googleAuthRepository;
  final AppleAuthGateway _appleAuthRepository;
  final BuildConfig _buildConfig;
  final TelegramUrlModel _telegramUrl;
  final NativeAuthPlatform _platform;
  var _isSignInInProgress = false;

  Future<Result<void, AuthFailure>> signInWithGoogle() async {
    final environmentResult = AuthEnvironment.resolve(
      buildConfig: _buildConfig,
      telegramUrl: _telegramUrl,
    );
    if (environmentResult case Failure(:final exception, :final stackTrace)) {
      return Failure(exception, stackTrace);
    }
    if (!_buildConfig.isNativeSocialAuthEnabled) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.configuration),
      );
    }
    final clientId = switch (_platform) {
      NativeAuthPlatform.ios => _buildConfig.googleIosClientId,
      NativeAuthPlatform.android => _buildConfig.googleAndroidClientId,
      NativeAuthPlatform.unsupported => '',
    };
    if (!GoogleAuthConfiguration.isClientId(clientId) ||
        !GoogleAuthConfiguration.isClientId(
          _buildConfig.googleServerClientId,
        ) ||
        (_platform == NativeAuthPlatform.ios &&
            !NativeAuthConfiguration.isMatchingGoogleReversedClientId(
              clientId: clientId,
              reversedClientId: _buildConfig.googleIosReversedClientId,
            ))) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.configuration),
      );
    }
    if (_isSignInInProgress) {
      return const Failure(AuthFailure(kind: AuthFailureKind.busy));
    }
    _isSignInInProgress = true;
    try {
      final credentialResult = await _googleAuthRepository.signIn(
        clientId: clientId,
        serverClientId: _buildConfig.googleServerClientId,
      );
      switch (credentialResult) {
        case Failure(:final exception, :final stackTrace):
          return Failure(exception, stackTrace);
        case Success(:final value):
          return await _apiClient.signInSocial(
            provider: value.provider.name,
            idToken: value.idToken,
            nonce: value.nonce,
            user: value.appleUser?.toBetterAuthUser(),
          );
      }
    } finally {
      _isSignInInProgress = false;
    }
  }

  Future<Result<void, AuthFailure>> signInWithApple() async {
    final environmentResult = AuthEnvironment.resolve(
      buildConfig: _buildConfig,
      telegramUrl: _telegramUrl,
    );
    if (environmentResult case Failure(:final exception, :final stackTrace)) {
      return Failure(exception, stackTrace);
    }
    if (!_buildConfig.isNativeSocialAuthEnabled) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.configuration),
      );
    }
    final environment = environmentResult.unwrap();
    final WebAuthenticationOptions? webAuthenticationOptions;
    switch (_platform) {
      case NativeAuthPlatform.ios:
        webAuthenticationOptions = null;
      case NativeAuthPlatform.android:
        if (!NativeAuthConfiguration.isAppleServiceId(
          _buildConfig.appleServiceId,
        )) {
          return const Failure(
            AuthFailure(kind: AuthFailureKind.configuration),
          );
        }
        webAuthenticationOptions = WebAuthenticationOptions(
          clientId: _buildConfig.appleServiceId,
          redirectUri: environment.appleAndroidCallbackUri,
        );
      case NativeAuthPlatform.unsupported:
        return const Failure(
          AuthFailure(kind: AuthFailureKind.configuration),
        );
    }
    if (_isSignInInProgress) {
      return const Failure(AuthFailure(kind: AuthFailureKind.busy));
    }
    _isSignInInProgress = true;
    try {
      final credentialResult = await _appleAuthRepository.signIn(
        webAuthenticationOptions: webAuthenticationOptions,
      );
      switch (credentialResult) {
        case Failure(:final exception, :final stackTrace):
          return Failure(exception, stackTrace);
        case Success(:final value):
          return await _apiClient.signInSocial(
            provider: value.provider.name,
            idToken: value.idToken,
            nonce: value.nonce,
            user: value.appleUser?.toBetterAuthUser(),
          );
      }
    } finally {
      _isSignInInProgress = false;
    }
  }
}

final class NativeAuthConfiguration {
  const new();

  static NativeAuthPlatform currentPlatform() {
    if (kIsWeb) {
      return NativeAuthPlatform.unsupported;
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => NativeAuthPlatform.ios,
      TargetPlatform.android => NativeAuthPlatform.android,
      _ => NativeAuthPlatform.unsupported,
    };
  }

  static bool isAppleServiceId(String value) {
    if (value.trim() != value) {
      return false;
    }
    final segments = value.split('.');
    return segments.length >= 2 &&
        segments.every((segment) => segment.isNotEmpty);
  }

  static bool isMatchingGoogleReversedClientId({
    required String clientId,
    required String reversedClientId,
  }) {
    const suffix = '.apps.googleusercontent.com';
    if (!clientId.endsWith(suffix)) {
      return false;
    }
    final oauthId = clientId.substring(0, clientId.length - suffix.length);
    return reversedClientId == 'com.googleusercontent.apps.$oauthId';
  }
}
