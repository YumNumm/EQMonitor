import 'dart:convert';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/telegram_url_model.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/model/passkey_operation.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_session_notifier.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_environment_provider.dart';
import 'package:eqmonitor/feature/auth/data/provider/native_auth_attempt_coordinator.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_token_manager.dart';
import 'package:passkeys/authenticator.dart';
import 'package:passkeys/exceptions.dart' as passkey;
import 'package:passkeys/types.dart' hide Result;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'passkey_repository.g.dart';

typedef ReadAcceptedSession = bool Function();
typedef AcceptPasskeySignIn =
    Future<Result<AuthSession, AuthFailure>> Function();
typedef InvalidatePasskeySession =
    Future<Result<AuthSession, AuthFailure>> Function();

abstract interface class PasskeyAuthGateway {
  Future<Result<void, AuthFailure>> register();

  Future<Result<AuthSession, AuthFailure>> signIn();
}

@Riverpod(keepAlive: true)
Future<PasskeyAuthGateway> passkeyRepository(Ref ref) async {
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  return PasskeyRepository(
    apiClient: await ref.watch(betterAuthApiClientProvider.future),
    sessionRepository: await ref.watch(
      betterAuthSessionRepositoryProvider.future,
    ),
    authenticator: PasskeyAuthenticator(),
    buildConfig: ref.watch(buildConfigProvider),
    telegramUrl: telegramUrl,
    hasAcceptedSession: () => switch (ref.read(authSessionProvider)) {
      AsyncData(:final value) => value.isAuthenticated,
      _ => false,
    },
    acceptSignIn: () => ref.read(authSessionProvider.notifier).acceptSignIn(),
    invalidateSession: () =>
        ref.read(authSessionProvider.notifier).invalidate(),
    attemptCoordinator: ref.watch(nativeAuthAttemptCoordinatorProvider),
  );
}

final class PasskeyRepository implements PasskeyAuthGateway {
  new({
    required BetterAuthApiClient apiClient,
    required BetterAuthSessionRepository sessionRepository,
    required PasskeyAuthenticatorInterface authenticator,
    required BuildConfig buildConfig,
    required TelegramUrlModel telegramUrl,
    required ReadAcceptedSession hasAcceptedSession,
    required AcceptPasskeySignIn acceptSignIn,
    required InvalidatePasskeySession invalidateSession,
    required NativeAuthAttemptCoordinator attemptCoordinator,
    PasskeyOperationGate? operationGate,
    PasskeyRequestParser? requestParser,
    PasskeyFailureMapper? failureMapper,
  }) : _apiClient = apiClient,
       _sessionRepository = sessionRepository,
       _authenticator = authenticator,
       _buildConfig = buildConfig,
       _telegramUrl = telegramUrl,
       _hasAcceptedSession = hasAcceptedSession,
       _acceptSignIn = acceptSignIn,
       _invalidateSession = invalidateSession,
       _attemptCoordinator = attemptCoordinator,
       _operationGate = operationGate ?? PasskeyOperationGate(),
       _requestParser = requestParser ?? const PasskeyRequestParser(),
       _failureMapper = failureMapper ?? const PasskeyFailureMapper();

  final BetterAuthApiClient _apiClient;
  final BetterAuthSessionRepository _sessionRepository;
  final PasskeyAuthenticatorInterface _authenticator;
  final BuildConfig _buildConfig;
  final TelegramUrlModel _telegramUrl;
  final ReadAcceptedSession _hasAcceptedSession;
  final AcceptPasskeySignIn _acceptSignIn;
  final InvalidatePasskeySession _invalidateSession;
  final NativeAuthAttemptCoordinator _attemptCoordinator;
  final PasskeyOperationGate _operationGate;
  final PasskeyRequestParser _requestParser;
  final PasskeyFailureMapper _failureMapper;

  @override
  Future<Result<void, AuthFailure>> register() async {
    final environmentResult = AuthEnvironment.resolve(
      buildConfig: _buildConfig,
      telegramUrl: _telegramUrl,
    );
    if (environmentResult case Failure(:final exception, :final stackTrace)) {
      return Failure(exception, stackTrace);
    }
    if (!_hasAcceptedSession()) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.sessionRequired),
      );
    }
    final tokenResult = await _sessionRepository.readSessionToken();
    if (tokenResult case Failure(:final exception, :final stackTrace)) {
      return Failure(exception, stackTrace);
    }
    final token = tokenResult.unwrap();
    if (token == null || !const BetterAuthSessionTokenManager().isSafe(token)) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.sessionRequired),
      );
    }
    if (!_operationGate.tryBegin(operation: PasskeyOperation.register)) {
      return const Failure(AuthFailure(kind: AuthFailureKind.busy));
    }
    final nativeAttempt = _attemptCoordinator.tryBegin();
    if (nativeAttempt == null) {
      _operationGate.complete(operation: PasskeyOperation.register);
      return const Failure(AuthFailure(kind: AuthFailureKind.busy));
    }
    try {
      final operationResult = await _apiClient
          .generatePasskeyRegistrationOptions();
      if (operationResult case Failure(
        :final exception,
        :final stackTrace,
      )) {
        if (exception.kind == AuthFailureKind.unauthorized) {
          await _invalidateSession();
        }
        return Failure(exception, stackTrace);
      }
      final operation = operationResult.unwrap();
      final requestResult = _requestParser.registration(
        options: operation.options,
        expectedRpId: environmentResult.unwrap().passkeyRpId,
      );
      if (requestResult case Failure(:final exception, :final stackTrace)) {
        return await operation.abandonWithFailure(
          failure: Failure(exception, stackTrace),
        );
      }
      final nativeResult = await _failureMapper.capture(
        () => _authenticator.register(requestResult.unwrap()),
      );
      if (nativeResult case Failure(:final exception, :final stackTrace)) {
        return await operation.abandonWithFailure(
          failure: Failure(exception, stackTrace),
        );
      }
      final verifyResult = await _apiClient.verifyPasskeyRegistration(
        operation: operation,
        response: nativeResult.unwrap().toJson(),
      );
      if (verifyResult case Failure(:final exception)
          when exception.kind == AuthFailureKind.unauthorized) {
        await _invalidateSession();
      }
      return verifyResult;
    } finally {
      nativeAttempt.release();
      _operationGate.complete(operation: PasskeyOperation.register);
    }
  }

  @override
  Future<Result<AuthSession, AuthFailure>> signIn() async {
    final environmentResult = AuthEnvironment.resolve(
      buildConfig: _buildConfig,
      telegramUrl: _telegramUrl,
    );
    if (environmentResult case Failure(:final exception, :final stackTrace)) {
      return Failure(exception, stackTrace);
    }
    if (!_operationGate.tryBegin(operation: PasskeyOperation.signIn)) {
      return const Failure(AuthFailure(kind: AuthFailureKind.busy));
    }
    final nativeAttempt = _attemptCoordinator.tryBegin();
    if (nativeAttempt == null) {
      _operationGate.complete(operation: PasskeyOperation.signIn);
      return const Failure(AuthFailure(kind: AuthFailureKind.busy));
    }
    try {
      final operationResult = await _apiClient
          .generatePasskeyAuthenticationOptions();
      if (operationResult case Failure(
        :final exception,
        :final stackTrace,
      )) {
        return Failure(exception, stackTrace);
      }
      final operation = operationResult.unwrap();
      final requestResult = _requestParser.authentication(
        options: operation.options,
        expectedRpId: environmentResult.unwrap().passkeyRpId,
      );
      if (requestResult case Failure(:final exception, :final stackTrace)) {
        return await operation.abandonWithFailure(
          failure: Failure(exception, stackTrace),
        );
      }
      final nativeResult = await _failureMapper.capture(
        () => _authenticator.authenticate(requestResult.unwrap()),
      );
      if (nativeResult case Failure(:final exception, :final stackTrace)) {
        return await operation.abandonWithFailure(
          failure: Failure(exception, stackTrace),
        );
      }
      final verifyResult = await _apiClient.verifyPasskeyAuthentication(
        operation: operation,
        response: nativeResult.unwrap().toJson(),
      );
      if (verifyResult case Failure(:final exception, :final stackTrace)) {
        return Failure(exception, stackTrace);
      }
      final sessionAcceptance = verifyResult.unwrap();
      try {
        final acceptanceResult = await _acceptSignIn();
        return switch (acceptanceResult) {
          Success(:final value) when value.isAuthenticated => Success(value),
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
    } finally {
      nativeAttempt.release();
      _operationGate.complete(operation: PasskeyOperation.signIn);
    }
  }
}

final class PasskeyRequestParser {
  const new({
    PasskeyOptionsSchemaValidator schemaValidator =
        const PasskeyOptionsSchemaValidator(),
  }) : _schemaValidator = schemaValidator;

  final PasskeyOptionsSchemaValidator _schemaValidator;

  Result<RegisterRequestType, AuthFailure> registration({
    required Map<String, dynamic> options,
    required String expectedRpId,
  }) {
    final normalizedOptions = _schemaValidator.normalizeRegistration(
      options: options,
    );
    if (normalizedOptions == null) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.invalidResponse),
      );
    }
    try {
      final request = RegisterRequestType.fromJson(normalizedOptions);
      final parameters = request.pubKeyCredParams;
      if (!isValidChallenge(request.challenge) ||
          request.relyingParty.id != expectedRpId ||
          request.relyingParty.name.isEmpty ||
          request.user.id.isEmpty ||
          request.user.name.isEmpty ||
          request.user.displayName.isEmpty ||
          parameters == null ||
          parameters.isEmpty) {
        return const Failure(
          AuthFailure(kind: AuthFailureKind.invalidResponse),
        );
      }
      return Success(request);
    } on FormatException catch (_, stackTrace) {
      return Failure(
        const AuthFailure(kind: AuthFailureKind.invalidResponse),
        stackTrace,
      );
    } on TypeError catch (_, stackTrace) {
      return Failure(
        const AuthFailure(kind: AuthFailureKind.invalidResponse),
        stackTrace,
      );
    }
  }

  Result<AuthenticateRequestType, AuthFailure> authentication({
    required Map<String, dynamic> options,
    required String expectedRpId,
  }) {
    final normalizedOptions = _schemaValidator.normalizeAuthentication(
      options: options,
    );
    if (normalizedOptions == null) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.invalidResponse),
      );
    }
    try {
      final request = AuthenticateRequestType.fromJson(normalizedOptions);
      if (!isValidChallenge(request.challenge) ||
          request.relyingPartyId != expectedRpId) {
        return const Failure(
          AuthFailure(kind: AuthFailureKind.invalidResponse),
        );
      }
      return Success(request);
    } on FormatException catch (_, stackTrace) {
      return Failure(
        const AuthFailure(kind: AuthFailureKind.invalidResponse),
        stackTrace,
      );
    } on TypeError catch (_, stackTrace) {
      return Failure(
        const AuthFailure(kind: AuthFailureKind.invalidResponse),
        stackTrace,
      );
    }
  }

  bool isValidChallenge(String value) {
    if (value.isEmpty || !_passkeyBase64UrlPattern.hasMatch(value)) {
      return false;
    }
    try {
      return base64Url.decode(base64Url.normalize(value)).isNotEmpty;
    } on FormatException {
      return false;
    }
  }
}

final class PasskeyOptionsSchemaValidator {
  const new({
    PasskeyBase64UrlValidator base64UrlValidator =
        const PasskeyBase64UrlValidator(),
  }) : _base64UrlValidator = base64UrlValidator;

  final PasskeyBase64UrlValidator _base64UrlValidator;

  static const _knownTransports = <String>{
    'ble',
    'bluetooth',
    'cable',
    'hybrid',
    'internal',
    'nfc',
    'smart-card',
    'usb',
  };

  Map<String, dynamic>? normalizeRegistration({
    required Map<String, dynamic> options,
  }) {
    final Object? challenge = options['challenge'];
    final Object? rp = options['rp'];
    final Object? user = options['user'];
    final Object? parameters = options['pubKeyCredParams'];
    if (challenge is! String ||
        !_base64UrlValidator.isValid(challenge) ||
        rp is! Map<String, dynamic> ||
        user is! Map<String, dynamic> ||
        parameters is! List<Object?> ||
        parameters.isEmpty) {
      return null;
    }
    final normalizedCredentials = normalizeCredentialList(
      value: options['excludeCredentials'],
    );
    if (!hasRequiredRegistrationIdentity(rp: rp, user: user) ||
        !hasValidPublicKeyParameters(parameters: parameters) ||
        !normalizedCredentials.isValid) {
      return null;
    }
    return {
      ...options,
      'excludeCredentials': normalizedCredentials.credentials,
    };
  }

  Map<String, dynamic>? normalizeAuthentication({
    required Map<String, dynamic> options,
  }) {
    final Object? challenge = options['challenge'];
    final Object? rpId = options['rpId'];
    if (challenge is! String ||
        !_base64UrlValidator.isValid(challenge) ||
        rpId is! String ||
        rpId.isEmpty) {
      return null;
    }
    final normalizedCredentials = normalizeCredentialList(
      value: options['allowCredentials'],
    );
    if (!normalizedCredentials.isValid) {
      return null;
    }
    return {
      ...options,
      'allowCredentials': normalizedCredentials.credentials,
    };
  }

  bool hasRequiredRegistrationIdentity({
    required Map<String, dynamic> rp,
    required Map<String, dynamic> user,
  }) {
    final Object? rpId = rp['id'];
    final Object? rpName = rp['name'];
    final Object? userId = user['id'];
    final Object? userName = user['name'];
    final Object? displayName = user['displayName'];
    return rpId is String &&
        rpId.isNotEmpty &&
        rpName is String &&
        rpName.isNotEmpty &&
        userId is String &&
        _base64UrlValidator.isValid(userId) &&
        userName is String &&
        userName.isNotEmpty &&
        displayName is String &&
        displayName.isNotEmpty;
  }

  bool hasValidPublicKeyParameters({required List<Object?> parameters}) =>
      parameters.every(
        (parameter) =>
            parameter is Map<String, dynamic> &&
            parameter['type'] == 'public-key' &&
            parameter['alg'] is int,
      );

  ({bool isValid, List<Map<String, dynamic>> credentials})
  normalizeCredentialList({required Object? value}) {
    if (value == null) {
      return (isValid: true, credentials: <Map<String, dynamic>>[]);
    }
    if (value is! List<Object?>) {
      return (isValid: false, credentials: <Map<String, dynamic>>[]);
    }
    final normalizedCredentials = <Map<String, dynamic>>[];
    for (final credential in value) {
      if (credential is! Map<String, dynamic>) {
        return (isValid: false, credentials: <Map<String, dynamic>>[]);
      }
      final Object? credentialId = credential['id'];
      final normalizedTransports = normalizeTransports(
        value: credential['transports'],
      );
      if (credential['type'] != 'public-key' ||
          credentialId is! String ||
          !_base64UrlValidator.isValid(credentialId) ||
          !normalizedTransports.isValid) {
        return (isValid: false, credentials: <Map<String, dynamic>>[]);
      }
      normalizedCredentials.add({
        ...credential,
        'transports': normalizedTransports.transports,
      });
    }
    return (isValid: true, credentials: normalizedCredentials);
  }

  ({bool isValid, List<String> transports}) normalizeTransports({
    required Object? value,
  }) {
    if (value == null) {
      return (isValid: true, transports: <String>[]);
    }
    if (value is! List<Object?>) {
      return (isValid: false, transports: <String>[]);
    }
    if (value.isEmpty || (value.length == 1 && value.single == '')) {
      return (isValid: true, transports: <String>[]);
    }
    final normalized = <String>[];
    for (final transport in value) {
      if (transport is! String || !_knownTransports.contains(transport)) {
        return (isValid: false, transports: <String>[]);
      }
      normalized.add(transport);
    }
    return (isValid: true, transports: normalized);
  }
}

final class PasskeyBase64UrlValidator {
  const new();

  bool isValid(String value) {
    if (value.isEmpty || !_passkeyBase64UrlPattern.hasMatch(value)) {
      return false;
    }
    try {
      return base64Url.decode(base64Url.normalize(value)).isNotEmpty;
    } on FormatException {
      return false;
    }
  }
}

final class PasskeyFailureMapper {
  const new();

  Future<Result<T, AuthFailure>> capture<T>(
    Future<T> Function() operation,
  ) async {
    try {
      return Success(await operation());
    } on passkey.AuthenticatorException catch (exception, stackTrace) {
      return Failure(map(exception), stackTrace);
    } on Exception catch (_, stackTrace) {
      return Failure(
        const AuthFailure(kind: AuthFailureKind.unknown),
        stackTrace,
      );
    }
  }

  AuthFailure map(passkey.AuthenticatorException exception) => AuthFailure(
    kind: switch (exception) {
      passkey.PasskeyAuthCancelledException() => AuthFailureKind.cancelled,
      passkey.TimeoutException() => AuthFailureKind.timeout,
      passkey.DeviceNotSupportedException() ||
      passkey.PasskeyUnsupportedException() =>
        AuthFailureKind.passkeyUnsupported,
      passkey.DomainNotAssociatedException() =>
        AuthFailureKind.passkeyDomainAssociation,
      passkey.NoCredentialsAvailableException() ||
      passkey.MissingGoogleSignInException() ||
      passkey.SyncAccountNotAvailableException() ||
      passkey.ExcludeCredentialsCanNotBeRegisteredException() ||
      passkey.NoCreateOptionException() =>
        AuthFailureKind.passkeyCredentialUnavailable,
      passkey.MalformedBase64Url() => AuthFailureKind.invalidResponse,
      passkey.UnhandledAuthenticatorException() => AuthFailureKind.unknown,
    },
  );
}

final _passkeyBase64UrlPattern = RegExp(r'^[A-Za-z0-9_-]+$');
