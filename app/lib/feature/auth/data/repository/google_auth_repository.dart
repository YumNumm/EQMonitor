import 'dart:async';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/native_auth_credential.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_auth_repository.g.dart';

@Riverpod(keepAlive: true)
GoogleAuthRepository googleAuthRepository(Ref ref) => GoogleAuthRepository(
  plugin: const GoogleSignInPluginAdapter(),
  nonceGenerator: CryptographicNonceGenerator(),
);

abstract interface class GoogleAuthGateway {
  Future<Result<NativeAuthCredential, AuthFailure>> signIn({
    required String clientId,
    required String serverClientId,
  });
}

abstract interface class GoogleSignInPlugin {
  Future<void> initialize({
    required String clientId,
    required String serverClientId,
    required String nonce,
  });

  Future<String?> authenticateIdToken();
}

final class GoogleSignInPluginAdapter implements GoogleSignInPlugin {
  const new();

  @override
  Future<void> initialize({
    required String clientId,
    required String serverClientId,
    required String nonce,
  }) => GoogleSignIn.instance.initialize(
    clientId: clientId,
    serverClientId: serverClientId,
    nonce: nonce,
  );

  @override
  Future<String?> authenticateIdToken() async =>
      (await GoogleSignIn.instance.authenticate()).authentication.idToken;
}

final class GoogleAuthRepository implements GoogleAuthGateway {
  new({
    required GoogleSignInPlugin plugin,
    required NativeAuthNonceGenerator nonceGenerator,
  }) : _plugin = plugin,
       _nonceGenerator = nonceGenerator;

  final GoogleSignInPlugin _plugin;
  final NativeAuthNonceGenerator _nonceGenerator;
  Future<void>? _initialization;
  NativeAuthNonce? _instanceNonce;
  String? _clientId;
  String? _serverClientId;

  @override
  Future<Result<NativeAuthCredential, AuthFailure>> signIn({
    required String clientId,
    required String serverClientId,
  }) async {
    if (!GoogleAuthConfiguration.isClientId(clientId) ||
        !GoogleAuthConfiguration.isClientId(serverClientId)) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.configuration),
      );
    }
    if (_initialization != null &&
        (_clientId != clientId || _serverClientId != serverClientId)) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.configuration),
      );
    }

    final nonce = _instanceNonce ??= _nonceGenerator.generate();
    _clientId ??= clientId;
    _serverClientId ??= serverClientId;
    _initialization ??= _plugin.initialize(
      clientId: clientId,
      serverClientId: serverClientId,
      nonce: nonce.raw,
    );

    try {
      await _initialization;
      final idToken = await _plugin.authenticateIdToken();
      if (idToken == null || idToken.isEmpty) {
        return const Failure(
          AuthFailure(kind: AuthFailureKind.invalidResponse),
        );
      }
      return Success(
        NativeAuthCredential(
          provider: NativeAuthProvider.google,
          idToken: idToken,
          nonce: nonce.raw,
        ),
      );
    } on GoogleSignInException catch (exception, stackTrace) {
      final kind = switch (exception.code) {
        GoogleSignInExceptionCode.canceled => AuthFailureKind.cancelled,
        GoogleSignInExceptionCode.clientConfigurationError ||
        GoogleSignInExceptionCode.providerConfigurationError =>
          AuthFailureKind.configuration,
        _ => AuthFailureKind.unknown,
      };
      return Failure(AuthFailure(kind: kind), stackTrace);
    } on Exception catch (_, stackTrace) {
      return Failure(
        const AuthFailure(kind: AuthFailureKind.unknown),
        stackTrace,
      );
    }
  }
}

final class GoogleAuthConfiguration {
  const new();

  static bool isClientId(String value) {
    const suffix = '.apps.googleusercontent.com';
    if (value.trim() != value || !value.endsWith(suffix)) {
      return false;
    }
    return value.substring(0, value.length - suffix.length).isNotEmpty;
  }
}
