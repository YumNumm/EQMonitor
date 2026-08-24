import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/native_auth_credential.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'apple_auth_repository.g.dart';

@Riverpod(keepAlive: true)
AppleAuthRepository appleAuthRepository(Ref ref) => AppleAuthRepository(
  plugin: const AppleSignInPluginAdapter(),
  nonceGenerator: CryptographicNonceGenerator(),
);

abstract interface class AppleAuthGateway {
  Future<Result<NativeAuthCredential, AuthFailure>> signIn({
    required WebAuthenticationOptions? webAuthenticationOptions,
  });
}

final class AppleNativeCredential {
  const new({
    required this.identityToken,
    this.email,
    this.firstName,
    this.lastName,
  });

  final String? identityToken;
  final String? email;
  final String? firstName;
  final String? lastName;
}

abstract interface class AppleSignInPlugin {
  Future<AppleNativeCredential> signIn({
    required String nonce,
    required WebAuthenticationOptions? webAuthenticationOptions,
  });
}

final class AppleSignInPluginAdapter implements AppleSignInPlugin {
  const new();

  @override
  Future<AppleNativeCredential> signIn({
    required String nonce,
    required WebAuthenticationOptions? webAuthenticationOptions,
  }) async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: const [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: webAuthenticationOptions,
      nonce: nonce,
    );
    return AppleNativeCredential(
      identityToken: credential.identityToken,
      email: credential.email,
      firstName: credential.givenName,
      lastName: credential.familyName,
    );
  }
}

final class AppleAuthRepository implements AppleAuthGateway {
  new({
    required AppleSignInPlugin plugin,
    required NativeAuthNonceGenerator nonceGenerator,
  }) : _plugin = plugin,
       _nonceGenerator = nonceGenerator;

  final AppleSignInPlugin _plugin;
  final NativeAuthNonceGenerator _nonceGenerator;

  @override
  Future<Result<NativeAuthCredential, AuthFailure>> signIn({
    required WebAuthenticationOptions? webAuthenticationOptions,
  }) async {
    final nonce = _nonceGenerator.generate();
    try {
      final nativeCredential = await _plugin.signIn(
        nonce: nonce.sha256,
        webAuthenticationOptions: webAuthenticationOptions,
      );
      final idToken = nativeCredential.identityToken;
      if (idToken == null || idToken.isEmpty) {
        return const Failure(
          AuthFailure(kind: AuthFailureKind.invalidResponse),
        );
      }
      final appleUser = AppleInitialUser(
        email: nativeCredential.email,
        firstName: nativeCredential.firstName,
        lastName: nativeCredential.lastName,
      );
      return Success(
        NativeAuthCredential(
          provider: NativeAuthProvider.apple,
          idToken: idToken,
          nonce: nonce.raw,
          appleUser: appleUser.hasValue ? appleUser : null,
        ),
      );
    } on SignInWithAppleAuthorizationException catch (exception, stackTrace) {
      final kind = exception.code == AuthorizationErrorCode.canceled
          ? AuthFailureKind.cancelled
          : AuthFailureKind.unknown;
      return Failure(AuthFailure(kind: kind), stackTrace);
    } on SignInWithAppleNotSupportedException catch (_, stackTrace) {
      return Failure(
        const AuthFailure(kind: AuthFailureKind.configuration),
        stackTrace,
      );
    } on Exception catch (_, stackTrace) {
      return Failure(
        const AuthFailure(kind: AuthFailureKind.unknown),
        stackTrace,
      );
    }
  }
}
