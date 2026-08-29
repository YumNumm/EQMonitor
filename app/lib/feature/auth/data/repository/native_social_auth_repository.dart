import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/telegram_url_model.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_session_notifier.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_environment_provider.dart';
import 'package:eqmonitor/feature/auth/data/provider/native_auth_attempt_coordinator.dart';
import 'package:eqmonitor/feature/auth/data/repository/apple_auth_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:eqmonitor/feature/auth/data/repository/google_auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'native_social_auth_repository.g.dart';

@Riverpod(keepAlive: true)
Future<NativeSocialAuthGateway> nativeSocialAuthRepository(Ref ref) async {
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  final apiClient = await ref.watch(betterAuthApiClientProvider.future);
  return NativeSocialAuthRepository(
    apiClient: apiClient,
    googleAuthRepository: ref.watch(googleAuthRepositoryProvider),
    appleAuthRepository: ref.watch(appleAuthRepositoryProvider),
    buildConfig: ref.watch(buildConfigProvider),
    telegramUrl: telegramUrl,
    platform: NativeAuthConfiguration.currentPlatform(),
    attemptCoordinator: ref.watch(nativeAuthAttemptCoordinatorProvider),
    acceptSignIn: () => ref.read(authSessionProvider.notifier).acceptSignIn(),
  );
}

enum NativeAuthPlatform { ios, android, unsupported }

typedef AcceptNativeSocialSignIn =
    Future<Result<AuthSession, AuthFailure>> Function();

abstract interface class NativeSocialAuthGateway {
  Future<Result<void, AuthFailure>> signInWithGoogle();

  Future<Result<void, AuthFailure>> signInWithApple();
}

final class NativeSocialAuthRepository implements NativeSocialAuthGateway {
  new({
    required BetterAuthApiClient apiClient,
    required GoogleAuthGateway googleAuthRepository,
    required AppleAuthGateway appleAuthRepository,
    required BuildConfig buildConfig,
    required TelegramUrlModel telegramUrl,
    required NativeAuthPlatform platform,
    required NativeAuthAttemptCoordinator attemptCoordinator,
    required AcceptNativeSocialSignIn acceptSignIn,
  }) : _apiClient = apiClient,
       _googleAuthRepository = googleAuthRepository,
       _appleAuthRepository = appleAuthRepository,
       _buildConfig = buildConfig,
       _telegramUrl = telegramUrl,
       _platform = platform,
       _attemptCoordinator = attemptCoordinator,
       _acceptSignIn = acceptSignIn;

  final BetterAuthApiClient _apiClient;
  final GoogleAuthGateway _googleAuthRepository;
  final AppleAuthGateway _appleAuthRepository;
  final BuildConfig _buildConfig;
  final TelegramUrlModel _telegramUrl;
  final NativeAuthPlatform _platform;
  final NativeAuthAttemptCoordinator _attemptCoordinator;
  final AcceptNativeSocialSignIn _acceptSignIn;

  @override
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
    final nativeAttempt = _attemptCoordinator.tryBegin();
    if (nativeAttempt == null) {
      return const Failure(AuthFailure(kind: AuthFailureKind.busy));
    }
    try {
      final credentialResult = await _googleAuthRepository.signIn(
        clientId: clientId,
        serverClientId: _buildConfig.googleServerClientId,
      );
      switch (credentialResult) {
        case Failure(:final exception, :final stackTrace):
          return Failure(exception, stackTrace);
        case Success(:final value):
          final sessionResult = await _apiClient.signInSocial(
            provider: value.provider.name,
            idToken: value.idToken,
            nonce: value.nonce,
            user: value.appleUser?.toBetterAuthUser(),
          );
          if (sessionResult case Failure(
            :final exception,
            :final stackTrace,
          )) {
            return Failure(exception, stackTrace);
          }
          final sessionAcceptance = sessionResult.unwrap();
          try {
            final acceptanceResult = await _acceptSignIn();
            return switch (acceptanceResult) {
              Success(:final value) when value.isAuthenticated => const Success(
                null,
              ),
              Success() => const Failure(
                AuthFailure(kind: AuthFailureKind.invalidResponse),
              ),
              Failure(:final exception, :final stackTrace) => Failure(
                exception,
                stackTrace,
              ),
            };
          } finally {
            sessionAcceptance.release();
          }
      }
    } finally {
      nativeAttempt.release();
    }
  }

  @override
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
    final nativeAttempt = _attemptCoordinator.tryBegin();
    if (nativeAttempt == null) {
      return const Failure(AuthFailure(kind: AuthFailureKind.busy));
    }
    try {
      final credentialResult = await _appleAuthRepository.signIn(
        webAuthenticationOptions: webAuthenticationOptions,
      );
      switch (credentialResult) {
        case Failure(:final exception, :final stackTrace):
          return Failure(exception, stackTrace);
        case Success(:final value):
          final sessionResult = await _apiClient.signInSocial(
            provider: value.provider.name,
            idToken: value.idToken,
            nonce: value.nonce,
            user: value.appleUser?.toBetterAuthUser(),
          );
          if (sessionResult case Failure(
            :final exception,
            :final stackTrace,
          )) {
            return Failure(exception, stackTrace);
          }
          final sessionAcceptance = sessionResult.unwrap();
          try {
            final acceptanceResult = await _acceptSignIn();
            return switch (acceptanceResult) {
              Success(:final value) when value.isAuthenticated => const Success(
                null,
              ),
              Success() => const Failure(
                AuthFailure(kind: AuthFailureKind.invalidResponse),
              ),
              Failure(:final exception, :final stackTrace) => Failure(
                exception,
                stackTrace,
              ),
            };
          } finally {
            sessionAcceptance.release();
          }
      }
    } finally {
      nativeAttempt.release();
    }
  }
}

final class NativeAuthConfiguration {
  const new();

  static final _appleServiceIdSegmentPattern = RegExp(
    r'^[A-Za-z0-9][A-Za-z0-9-]*$',
  );

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
        segments.every(_appleServiceIdSegmentPattern.hasMatch);
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
