import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/provider/user_jwt_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthSessionNotifier extends _$AuthSessionNotifier {
  @override
  Future<AuthSession> build() async => const AuthSession.signedOut();

  Future<Result<AuthSession, AuthFailure>> restore() async {
    final repository = await ref.read(
      betterAuthSessionRepositoryProvider.future,
    );
    final savedToken = await repository.readSessionToken();
    if (savedToken == null || savedToken.isEmpty) {
      const session = AuthSession.signedOut();
      state = const AsyncData(session);
      return const Success(session);
    }
    final apiClient = await ref.read(betterAuthApiClientProvider.future);
    final sessionResult = await apiClient.getSession();
    switch (sessionResult) {
      case Success(:final value) when value:
        return acceptSignIn();
      case Success():
        await repository.clearSession();
        (await ref.read(userJwtServiceProvider.future)).clearJwt();
        const session = AuthSession.signedOut();
        state = const AsyncData(session);
        return const Success(session);
      case Failure(:final exception, :final stackTrace):
        if (exception.kind == AuthFailureKind.unauthorized) {
          await repository.clearSession();
          (await ref.read(userJwtServiceProvider.future)).clearJwt();
          state = const AsyncData(AuthSession.signedOut());
        }
        return Failure(exception, stackTrace);
    }
  }

  Future<Result<AuthSession, AuthFailure>> acceptSignIn() async {
    final repository = await ref.read(
      betterAuthSessionRepositoryProvider.future,
    );
    final token = await repository.readSessionToken();
    if (token == null || token.isEmpty) {
      const failure = AuthFailure(kind: AuthFailureKind.unauthorized);
      state = const AsyncData(AuthSession.signedOut());
      return const Failure(failure);
    }
    final jwtProvider = await ref.read(userJwtServiceProvider.future);
    final result = await jwtProvider.getValidJwt(forceRefresh: true);
    switch (result) {
      case Success(:final value):
        final session = AuthSession.authenticated(userJwt: value);
        state = AsyncData(session);
        return Success(session);
      case Failure(:final exception, :final stackTrace):
        if (exception.kind == AuthFailureKind.unauthorized) {
          await repository.clearSession();
          jwtProvider.clearJwt();
          state = const AsyncData(AuthSession.signedOut());
        }
        return Failure(exception, stackTrace);
    }
  }

  Future<Result<AuthSession, AuthFailure>> refreshJwt() async {
    final jwtProvider = await ref.read(userJwtServiceProvider.future);
    final result = await jwtProvider.getValidJwt(forceRefresh: true);
    switch (result) {
      case Success(:final value):
        final session = AuthSession.authenticated(userJwt: value);
        state = AsyncData(session);
        return Success(session);
      case Failure(:final exception, :final stackTrace):
        if (exception.kind == AuthFailureKind.unauthorized) {
          final repository = await ref.read(
            betterAuthSessionRepositoryProvider.future,
          );
          await repository.clearSession();
          jwtProvider.clearJwt();
          state = const AsyncData(AuthSession.signedOut());
        }
        return Failure(exception, stackTrace);
    }
  }

  Future<Result<AuthSession, AuthFailure>> signOut() async {
    final apiClient = await ref.read(betterAuthApiClientProvider.future);
    final result = await apiClient.signOut();
    final repository = await ref.read(
      betterAuthSessionRepositoryProvider.future,
    );
    await repository.clearSession();
    (await ref.read(userJwtServiceProvider.future)).clearJwt();
    const session = AuthSession.signedOut();
    state = const AsyncData(session);
    return switch (result) {
      Success() => const Success(session),
      Failure(:final exception, :final stackTrace) => Failure(
        exception,
        stackTrace,
      ),
    };
  }
}
