import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_session_lifecycle.dart';
import 'package:eqmonitor/feature/auth/data/provider/user_jwt_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthSessionNotifier extends _$AuthSessionNotifier {
  var _invalidationEpoch = 0;

  @override
  Future<AuthSession> build() async {
    ref.onDispose(() {
      _invalidationEpoch++;
    });
    return const AuthSession.signedOut();
  }

  Future<Result<AuthSession, AuthFailure>> restore() async {
    if (!ref.read(authSessionLifecycleProvider).allowsSessionRestore) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.unauthorized),
      );
    }
    final operationEpoch = _invalidationEpoch;
    final repository = await ref.read(
      betterAuthSessionRepositoryProvider.future,
    );
    final savedTokenResult = await repository.readSessionToken();
    if (operationEpoch != _invalidationEpoch) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.unauthorized),
      );
    }
    if (savedTokenResult case Failure(:final exception, :final stackTrace)) {
      return Failure(exception, stackTrace);
    }
    final savedToken = savedTokenResult.unwrap();
    if (savedToken == null || savedToken.isEmpty) {
      const session = AuthSession.signedOut();
      state = const AsyncData(session);
      return const Success(session);
    }
    final apiClient = await ref.read(betterAuthApiClientProvider.future);
    final sessionResult = await apiClient.getSession();
    if (operationEpoch != _invalidationEpoch) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.unauthorized),
      );
    }
    switch (sessionResult) {
      case Success(:final value) when value:
        return acceptSignIn();
      case Success():
        return invalidate();
      case Failure(:final exception, :final stackTrace):
        if (exception.kind == AuthFailureKind.unauthorized) {
          await invalidate();
        }
        return Failure(exception, stackTrace);
    }
  }

  Future<Result<AuthSession, AuthFailure>> acceptSignIn() async {
    final operationEpoch = _invalidationEpoch;
    final repository = await ref.read(
      betterAuthSessionRepositoryProvider.future,
    );
    final tokenResult = await repository.readSessionToken();
    if (operationEpoch != _invalidationEpoch) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.unauthorized),
      );
    }
    if (tokenResult case Failure(:final exception, :final stackTrace)) {
      return Failure(exception, stackTrace);
    }
    final token = tokenResult.unwrap();
    if (token == null || token.isEmpty) {
      const failure = AuthFailure(kind: AuthFailureKind.unauthorized);
      await invalidate();
      return const Failure(failure);
    }
    if (!ref.read(authSessionLifecycleProvider).acceptSignIn()) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.unauthorized),
      );
    }
    final jwtProvider = await ref.read(userJwtServiceProvider.future);
    final result = await jwtProvider.getValidJwt(forceRefresh: true);
    if (operationEpoch != _invalidationEpoch) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.unauthorized),
      );
    }
    switch (result) {
      case Success():
        const session = AuthSession.authenticated();
        state = const AsyncData(session);
        return const Success(session);
      case Failure(:final exception, :final stackTrace):
        if (exception.kind == AuthFailureKind.unauthorized) {
          await invalidate();
        }
        return Failure(exception, stackTrace);
    }
  }

  Future<Result<AuthSession, AuthFailure>> refreshJwt() async {
    final operationEpoch = _invalidationEpoch;
    final jwtProvider = await ref.read(userJwtServiceProvider.future);
    final result = await jwtProvider.getValidJwt(forceRefresh: true);
    if (operationEpoch != _invalidationEpoch) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.unauthorized),
      );
    }
    switch (result) {
      case Success():
        const session = AuthSession.authenticated();
        state = const AsyncData(session);
        return const Success(session);
      case Failure(:final exception, :final stackTrace):
        if (exception.kind == AuthFailureKind.unauthorized) {
          await invalidate();
        }
        return Failure(exception, stackTrace);
    }
  }

  Future<Result<AuthSession, AuthFailure>> signOut() async {
    final lifecycle = ref.read(authSessionLifecycleProvider);
    final lifecycleGeneration = lifecycle.beginInvalidation();
    _invalidationEpoch++;
    state = const AsyncData(AuthSession.signedOut());
    final apiClient = await ref.read(betterAuthApiClientProvider.future);
    (await ref.read(userJwtServiceProvider.future)).clearJwt();
    final result = await apiClient.signOut();
    final repository = await ref.read(
      betterAuthSessionRepositoryProvider.future,
    );
    final storageResult = await repository.clearSession();
    final Result<AuthSession, AuthFailure> signOutResult = switch ((
      result,
      storageResult,
    )) {
      (Failure(:final exception, :final stackTrace), _) => Failure(
        exception,
        stackTrace,
      ),
      (Success(), Failure(:final exception, :final stackTrace)) => Failure(
        exception,
        stackTrace,
      ),
      (Success(), Success()) => const Success(AuthSession.signedOut()),
    };
    lifecycle.completeInvalidation(generation: lifecycleGeneration);
    return signOutResult;
  }

  Future<Result<AuthSession, AuthFailure>> invalidate() async {
    final lifecycle = ref.read(authSessionLifecycleProvider);
    final lifecycleGeneration = lifecycle.beginInvalidation();
    _invalidationEpoch++;
    const session = AuthSession.signedOut();
    state = const AsyncData(session);
    (await ref.read(userJwtServiceProvider.future)).clearJwt();
    final apiClient = await ref.read(betterAuthApiClientProvider.future);
    final cookieResult = await apiClient.clearCookies();
    final repository = await ref.read(
      betterAuthSessionRepositoryProvider.future,
    );
    final storageResult = await repository.clearSession();
    final Result<AuthSession, AuthFailure> invalidationResult = switch ((
      cookieResult,
      storageResult,
    )) {
      (Failure(:final exception, :final stackTrace), _) => Failure(
        exception,
        stackTrace,
      ),
      (_, Failure(:final exception, :final stackTrace)) => Failure(
        exception,
        stackTrace,
      ),
      _ => const Success(session),
    };
    lifecycle.completeInvalidation(generation: lifecycleGeneration);
    return invalidationResult;
  }
}
