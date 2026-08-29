import 'dart:async';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/model/debug_auth_state.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_session_notifier.dart';
import 'package:eqmonitor/feature/auth/data/notifier/debug_auth_action.dart';
import 'package:eqmonitor/feature/auth/data/notifier/debug_auth_notifier.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_environment_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/native_social_auth_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/passkey_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/user_api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  for (final testCase
      in <
        ({
          String name,
          Future<void> Function(DebugAuthNotifier notifier) invoke,
          AuthFailureKind expectedFailure,
        })
      >[
        (
          name: 'social',
          invoke: (notifier) => notifier.signInWithGoogle(),
          expectedFailure: AuthFailureKind.unauthorized,
        ),
        (
          name: 'Passkey',
          invoke: (notifier) => notifier.signInWithPasskey(),
          expectedFailure: AuthFailureKind.server,
        ),
      ]) {
    test(
      '既存session上の${testCase.name} failureでもsessionを推測してsigned outにしない',
      () async {
        final fixture = DebugAuthNotifierFixture(
          initialSession: const AuthSession.authenticated(),
          googleAction: () async => const Failure(
            AuthFailure(kind: AuthFailureKind.unauthorized),
          ),
          passkeySignInAction: () async => const Failure(
            AuthFailure(kind: AuthFailureKind.server),
          ),
        );
        addTearDown(fixture.dispose);
        await fixture.start();

        await testCase.invoke(fixture.notifier);

        expect(fixture.sessionState.status, AuthSessionStatus.authenticated);
        expect(fixture.state.failureKind, testCase.expectedFailure);
        expect(fixture.state.jwtExpiresAt, restoredExpiry);
      },
    );
  }

  test('外部logoutは過去provider、expiry、user summary、outcomeを消去する', () async {
    late final DebugAuthNotifierFixture fixture;
    fixture = DebugAuthNotifierFixture(
      googleAction: () async {
        fixture.sessionNotifier.replaceSession(
          const AuthSession.authenticated(),
        );
        return const Success(null);
      },
      userMeAction: () async => const Success({
        'id': 'user-1234567890',
        'email': 'private.person@example.com',
      }),
    );
    addTearDown(fixture.dispose);
    await fixture.start();
    await fixture.notifier.signInWithGoogle();
    await fixture.notifier.verifyUserMe();
    expect(fixture.state.provider, DebugAuthProviderKind.google);
    expect(fixture.state.userSummary, isNotNull);

    fixture.sessionNotifier.replaceSession(const AuthSession.signedOut());
    await fixture.container.pump();

    expect(fixture.sessionState.status, AuthSessionStatus.signedOut);
    expect(fixture.state.provider, isNull);
    expect(fixture.state.jwtExpiresAt, isNull);
    expect(fixture.state.userSummary, isNull);
    expect(fixture.state.successKind, isNull);
    expect(fixture.state.failureKind, isNull);
  });

  test('user API 401がTask 5境界でinvalidateしたsessionを表示の正本にする', () async {
    late final DebugAuthNotifierFixture fixture;
    fixture = DebugAuthNotifierFixture(
      initialSession: const AuthSession.authenticated(),
      userMeAction: () async {
        fixture.sessionNotifier.replaceSession(const AuthSession.signedOut());
        return const Failure(
          AuthFailure(kind: AuthFailureKind.unauthorized),
        );
      },
    );
    addTearDown(fixture.dispose);
    await fixture.start();

    await fixture.notifier.verifyUserMe();

    expect(fixture.sessionState.status, AuthSessionStatus.signedOut);
    expect(fixture.state.provider, isNull);
    expect(fixture.state.jwtExpiresAt, isNull);
    expect(fixture.state.userSummary, isNull);
    expect(fixture.state.failureKind, isNull);
  });

  test('page dispose後のlate successはJWT metadataもpresentationも更新しない', () async {
    final socialResult = Completer<Result<void, AuthFailure>>();
    var expiryReadCount = 0;
    final fixture = DebugAuthNotifierFixture(
      googleAction: () => socialResult.future,
      expiryAction: () async {
        expiryReadCount++;
        return restoredExpiry;
      },
    );
    await fixture.start();
    final operation = fixture.notifier.signInWithGoogle();
    await fixture.social.googleStarted.future;
    expect(fixture.social.googleCalls, 1);

    fixture.closePage();
    await fixture.container.pump();
    socialResult.complete(const Success(null));

    await expectLater(operation, completes);
    expect(expiryReadCount, 0);
    fixture.container.dispose();
  });

  test('environment provider再構築後の旧operation successは新しいstateへ書き戻さない', () async {
    final socialResult = Completer<Result<void, AuthFailure>>();
    var environmentBuilds = 0;
    late final DebugAuthNotifierFixture fixture;
    fixture = DebugAuthNotifierFixture(
      environmentAction: () async {
        environmentBuilds++;
        return environmentBuilds == 1
            ? const Success(AuthEnvironment.develop)
            : const Failure(
                AuthFailure(kind: AuthFailureKind.environmentMismatch),
              );
      },
      googleAction: () async {
        final result = await socialResult.future;
        if (result is Success<void, AuthFailure>) {
          fixture.sessionNotifier.replaceSession(
            const AuthSession.authenticated(),
          );
        }
        return result;
      },
    );
    addTearDown(fixture.dispose);
    await fixture.start();
    final operation = fixture.notifier.signInWithGoogle();
    await fixture.container.pump();

    fixture.container.invalidate(authEnvironmentProvider);
    await fixture.container.pump();
    await fixture.container.read(debugAuthProvider.future);
    expect(environmentBuilds, 2);
    expect(
      fixture.state.failureKind,
      AuthFailureKind.environmentMismatch,
    );
    socialResult.complete(const Success(null));
    await operation;
    await fixture.container.pump();

    expect(environmentBuilds, 2);
    expect(fixture.state.provider, isNull);
    expect(fixture.state.successKind, isNot(DebugAuthSuccessKind.signedIn));
  });

  test(
    'sign-in success後のJWT metadata待機中に外部logoutしたらlate expiryを破棄する',
    () async {
      final expiryResult = Completer<DateTime?>();
      final expiryReadStarted = Completer<void>();
      late final DebugAuthNotifierFixture fixture;
      fixture = DebugAuthNotifierFixture(
        googleAction: () async {
          fixture.sessionNotifier.replaceSession(
            const AuthSession.authenticated(),
          );
          return const Success(null);
        },
        expiryAction: () {
          if (!expiryReadStarted.isCompleted) {
            expiryReadStarted.complete();
          }
          return expiryResult.future;
        },
      );
      addTearDown(fixture.dispose);
      await fixture.start();

      final operation = fixture.notifier.signInWithGoogle();
      await expiryReadStarted.future;
      fixture.sessionNotifier.replaceSession(const AuthSession.signedOut());
      await fixture.container.pump();
      expiryResult.complete(DateTime.utc(2040));
      await operation;

      expect(fixture.sessionState.status, AuthSessionStatus.signedOut);
      expect(fixture.state.provider, isNull);
      expect(fixture.state.jwtExpiresAt, isNull);
      expect(fixture.state.successKind, isNull);
    },
  );

  test('外部invalidation後のlate failureはpresentationへ反映しない', () async {
    final socialResult = Completer<Result<void, AuthFailure>>();
    final fixture = DebugAuthNotifierFixture(
      initialSession: const AuthSession.authenticated(),
      googleAction: () => socialResult.future,
    );
    addTearDown(fixture.dispose);
    await fixture.start();

    final operation = fixture.notifier.signInWithGoogle();
    await fixture.container.pump();
    fixture.sessionNotifier.replaceSession(const AuthSession.signedOut());
    await fixture.container.pump();
    socialResult.complete(
      const Failure(AuthFailure(kind: AuthFailureKind.server)),
    );
    await operation;

    expect(fixture.state.failureKind, isNull);
    expect(fixture.state.operation, isNull);
  });

  test('sign-in待機中の外部authenticated変更後はlate failureを反映しない', () async {
    final socialResult = Completer<Result<void, AuthFailure>>();
    final fixture = DebugAuthNotifierFixture(
      googleAction: () => socialResult.future,
    );
    addTearDown(fixture.dispose);
    await fixture.start();

    final operation = fixture.notifier.signInWithGoogle();
    await fixture.container.pump();
    fixture.sessionNotifier.replaceSession(
      const AuthSession.authenticated(),
    );
    await fixture.container.pump();
    socialResult.complete(
      const Failure(AuthFailure(kind: AuthFailureKind.server)),
    );
    await operation;

    expect(fixture.sessionState.status, AuthSessionStatus.authenticated);
    expect(fixture.state.failureKind, isNull);
    expect(fixture.state.operation, isNull);
    expect(fixture.state.provider, isNull);
    expect(fixture.state.jwtExpiresAt, isNull);
  });

  test('JWT更新待機中の外部authenticated変更後はlate failureを反映しない', () async {
    final refreshResult = Completer<Result<AuthSession, AuthFailure>>();
    final fixture = DebugAuthNotifierFixture(
      initialSession: const AuthSession.authenticated(),
      refreshAction: () => refreshResult.future,
    );
    addTearDown(fixture.dispose);
    await fixture.start();

    final operation = fixture.notifier.refreshJwt();
    await fixture.container.pump();
    fixture.sessionNotifier.replaceSession(
      const AuthSession.authenticated(),
    );
    await fixture.container.pump();
    refreshResult.complete(
      const Failure(AuthFailure(kind: AuthFailureKind.server)),
    );
    await operation;

    expect(fixture.sessionState.status, AuthSessionStatus.authenticated);
    expect(fixture.state.failureKind, isNull);
    expect(fixture.state.operation, isNull);
    expect(fixture.state.jwtExpiresAt, isNull);
  });

  test('sign-out待機中の外部invalidationはlate outcomeを反映しない', () async {
    final signOutResult = Completer<Result<AuthSession, AuthFailure>>();
    final fixture = DebugAuthNotifierFixture(
      initialSession: const AuthSession.authenticated(),
      signOutAction: () => signOutResult.future,
    );
    addTearDown(fixture.dispose);
    await fixture.start();

    final operation = fixture.notifier.signOut();
    await fixture.container.pump();
    fixture.sessionNotifier.replaceSession(const AuthSession.signedOut());
    await fixture.container.pump();
    signOutResult.complete(
      const Failure(AuthFailure(kind: AuthFailureKind.server)),
    );
    await operation;

    expect(fixture.sessionState.status, AuthSessionStatus.signedOut);
    expect(fixture.state.failureKind, isNull);
    expect(fixture.state.operation, isNull);
    expect(fixture.state.successKind, isNull);
    expect(fixture.state.jwtExpiresAt, isNull);
  });

  test('restore待機中の外部sign-out後はlate unauthorizedを反映しない', () async {
    final restoreResult = Completer<Result<AuthSession, AuthFailure>>();
    final restoreStarted = Completer<void>();
    final fixture = DebugAuthNotifierFixture(
      initialSession: const AuthSession.authenticated(),
      restoreAction: () {
        restoreStarted.complete();
        return restoreResult.future;
      },
    );
    addTearDown(fixture.dispose);

    final restore = fixture.beginStart();
    await restoreStarted.future;
    fixture.sessionNotifier.replaceSession(const AuthSession.signedOut());
    await fixture.container.pump();
    restoreResult.complete(
      const Failure(AuthFailure(kind: AuthFailureKind.unauthorized)),
    );
    await restore;

    expect(fixture.sessionState.status, AuthSessionStatus.signedOut);
    expect(fixture.state.failureKind, isNull);
    expect(fixture.state.operation, isNull);
    expect(fixture.state.provider, isNull);
    expect(fixture.state.jwtExpiresAt, isNull);
  });

  test('sign-inのsession更新後にexpiry取得がthrowしても旧stateを復活させない', () async {
    final expiryResult = Completer<DateTime?>();
    final expiryStarted = Completer<void>();
    late final DebugAuthNotifierFixture fixture;
    fixture = DebugAuthNotifierFixture(
      googleAction: () async {
        fixture.sessionNotifier.replaceSession(
          const AuthSession.authenticated(),
        );
        return const Success(null);
      },
      expiryAction: () {
        expiryStarted.complete();
        return expiryResult.future;
      },
    );
    addTearDown(fixture.dispose);
    await fixture.start();

    final operation = fixture.notifier.signInWithGoogle();
    await expiryStarted.future;
    expiryResult.completeError(Exception('expiry unavailable'));
    await operation;

    expect(fixture.sessionState.status, AuthSessionStatus.authenticated);
    expect(fixture.state.failureKind, isNull);
    expect(fixture.state.operation, isNull);
    expect(fixture.state.provider, isNull);
    expect(fixture.state.jwtExpiresAt, isNull);
  });

  test('JWT更新のsession更新後にexpiry取得がthrowしても旧stateを復活させない', () async {
    var expiryReads = 0;
    final expiryResult = Completer<DateTime?>();
    final expiryStarted = Completer<void>();
    final fixture = DebugAuthNotifierFixture(
      initialSession: const AuthSession.authenticated(),
      expiryAction: () {
        expiryReads++;
        if (expiryReads == 1) {
          return Future.value(restoredExpiry);
        }
        expiryStarted.complete();
        return expiryResult.future;
      },
    );
    addTearDown(fixture.dispose);
    await fixture.start();

    final operation = fixture.notifier.refreshJwt();
    await expiryStarted.future;
    expiryResult.completeError(Exception('expiry unavailable'));
    await operation;

    expect(fixture.sessionState.status, AuthSessionStatus.authenticated);
    expect(fixture.state.failureKind, isNull);
    expect(fixture.state.operation, isNull);
    expect(fixture.state.provider, isNull);
    expect(fixture.state.jwtExpiresAt, isNull);
  });

  for (final initialSession in const [
    AuthSession.signedOut(),
    AuthSession.authenticated(),
  ]) {
    for (final testCase
        in <
          ({
            String name,
            Future<void> Function(DebugAuthNotifier notifier) invoke,
          })
        >[
          (
            name: 'Google sign-in',
            invoke: (notifier) => notifier.signInWithGoogle(),
          ),
          (
            name: 'Apple sign-in',
            invoke: (notifier) => notifier.signInWithApple(),
          ),
          (
            name: 'Passkey sign-in',
            invoke: (notifier) => notifier.signInWithPasskey(),
          ),
          (
            name: 'Passkey registration',
            invoke: (notifier) => notifier.registerPasskey(),
          ),
        ]) {
      test(
        '${initialSession.status.name}の${testCase.name} cancelは開始前stateへ戻す',
        () async {
          final fixture = DebugAuthNotifierFixture(
            initialSession: initialSession,
            googleAction: cancelledVoidAction,
            appleAction: cancelledVoidAction,
            passkeySignInAction: cancelledSessionAction,
            passkeyRegisterAction: cancelledVoidAction,
          );
          addTearDown(fixture.dispose);
          final before = await fixture.start();

          await testCase.invoke(fixture.notifier);

          final after = fixture.state;
          expect(after.operation, before.operation);
          expect(after.provider, before.provider);
          expect(after.jwtExpiresAt, before.jwtExpiresAt);
          expect(after.userSummary, same(before.userSummary));
          expect(after.successKind, before.successKind);
          expect(after.failureKind, before.failureKind);
        },
      );
    }
  }

  test('cancelは既存provider、expiry、summary、safe outcomeを保持する', () async {
    late final DebugAuthNotifierFixture fixture;
    fixture = DebugAuthNotifierFixture(
      googleAction: () async {
        fixture.sessionNotifier.replaceSession(
          const AuthSession.authenticated(),
        );
        return const Success(null);
      },
      appleAction: cancelledVoidAction,
      userMeAction: () async => const Success({
        'id': 'user-1234567890',
        'email': 'private.person@example.com',
      }),
    );
    addTearDown(fixture.dispose);
    await fixture.start();
    await fixture.notifier.signInWithGoogle();
    await fixture.notifier.verifyUserMe();
    final before = fixture.state;

    await fixture.notifier.signInWithApple();

    final after = fixture.state;
    expect(after.provider, DebugAuthProviderKind.google);
    expect(after.jwtExpiresAt, before.jwtExpiresAt);
    expect(after.userSummary, same(before.userSummary));
    expect(after.successKind, DebugAuthSuccessKind.userMeVerified);
    expect(after.failureKind, isNull);
  });

  test('二重tapは同じoperationを一度だけ開始する', () async {
    final socialResult = Completer<Result<void, AuthFailure>>();
    final fixture = DebugAuthNotifierFixture(
      googleAction: () => socialResult.future,
    );
    addTearDown(fixture.dispose);
    await fixture.start();

    final first = fixture.notifier.signInWithGoogle();
    await fixture.container.pump();
    final second = fixture.notifier.signInWithGoogle();
    await second;

    expect(fixture.social.googleCalls, 1);
    expect(fixture.state.operation, DebugAuthOperation.googleSignIn);
    socialResult.complete(await cancelledVoidAction());
    await first;
  });
}

Future<Result<void, AuthFailure>> cancelledVoidAction() async => const Failure(
  AuthFailure(kind: AuthFailureKind.cancelled),
);

Future<Result<AuthSession, AuthFailure>> cancelledSessionAction() async =>
    const Failure(AuthFailure(kind: AuthFailureKind.cancelled));

final restoredExpiry = DateTime.utc(2035, 1, 1);

final class DebugAuthNotifierFixture {
  new({
    AuthSession initialSession = const AuthSession.signedOut(),
    Future<Result<AuthEnvironment, AuthFailure>> Function()? environmentAction,
    Future<Result<void, AuthFailure>> Function()? googleAction,
    Future<Result<void, AuthFailure>> Function()? appleAction,
    Future<Result<AuthSession, AuthFailure>> Function()? passkeySignInAction,
    Future<Result<void, AuthFailure>> Function()? passkeyRegisterAction,
    Future<Result<Map<String, dynamic>, AuthFailure>> Function()? userMeAction,
    Future<DateTime?> Function()? expiryAction,
    Future<Result<AuthSession, AuthFailure>> Function()? refreshAction,
    Future<Result<AuthSession, AuthFailure>> Function()? signOutAction,
    Future<Result<AuthSession, AuthFailure>> Function()? restoreAction,
  }) {
    sessionNotifier = ControlledAuthSessionNotifier(
      initialSession: initialSession,
      refreshAction: refreshAction,
      signOutAction: signOutAction,
      restoreAction: restoreAction,
    );
    social = ControlledNativeSocialAuthGateway(
      googleAction: googleAction ?? cancelledVoidAction,
      appleAction: appleAction ?? cancelledVoidAction,
    );
    passkey = ControlledPasskeyAuthGateway(
      signInAction: passkeySignInAction ?? cancelledSessionAction,
      registerAction: passkeyRegisterAction ?? cancelledVoidAction,
    );
    userApi = ControlledUserApiGateway(
      action:
          userMeAction ??
          () async => const Failure(
            AuthFailure(kind: AuthFailureKind.invalidResponse),
          ),
    );
    final resolvedEnvironmentAction =
        environmentAction ?? () async => const Success(AuthEnvironment.develop);
    final resolvedExpiryAction = expiryAction ?? () async => restoredExpiry;
    container = ProviderContainer(
      overrides: [
        authSessionProvider.overrideWith(() => sessionNotifier),
        authEnvironmentProvider.overrideWith(
          (ref) => resolvedEnvironmentAction(),
        ),
        nativeSocialAuthRepositoryProvider.overrideWith(
          (ref) async => social,
        ),
        passkeyRepositoryProvider.overrideWith((ref) async => passkey),
        userApiClientProvider.overrideWith((ref) async => userApi),
        debugAuthJwtExpiryProvider.overrideWith(
          (ref) async => resolvedExpiryAction,
        ),
      ],
    );
  }

  late final ControlledAuthSessionNotifier sessionNotifier;
  late final ControlledNativeSocialAuthGateway social;
  late final ControlledPasskeyAuthGateway passkey;
  late final ControlledUserApiGateway userApi;
  late final ProviderContainer container;
  ProviderSubscription<AsyncValue<DebugAuthState>>? subscription;

  DebugAuthNotifier get notifier => container.read(debugAuthProvider.notifier);

  DebugAuthState get state => switch (container.read(debugAuthProvider)) {
    AsyncData(:final value) => value,
    _ => throw StateError('Debug auth state is not ready'),
  };

  AuthSession get sessionState => switch (container.read(authSessionProvider)) {
    AsyncData(:final value) => value,
    _ => throw StateError('Auth session is not ready'),
  };

  Future<DebugAuthState> start() async {
    return beginStart();
  }

  Future<DebugAuthState> beginStart() {
    subscription = container.listen(debugAuthProvider, (_, _) {});
    return container.read(debugAuthProvider.future);
  }

  void closePage() {
    subscription?.close();
    subscription = null;
  }

  void dispose() {
    closePage();
    container.dispose();
  }
}

final class ControlledAuthSessionNotifier extends AuthSessionNotifier {
  new({
    required this.initialSession,
    this.refreshAction,
    this.signOutAction,
    this.restoreAction,
  });

  final AuthSession initialSession;
  final Future<Result<AuthSession, AuthFailure>> Function()? refreshAction;
  final Future<Result<AuthSession, AuthFailure>> Function()? signOutAction;
  final Future<Result<AuthSession, AuthFailure>> Function()? restoreAction;

  @override
  Future<AuthSession> build() async => initialSession;

  @override
  Future<Result<AuthSession, AuthFailure>> restore() async {
    final action = restoreAction;
    if (action != null) {
      return action();
    }
    state = AsyncData(initialSession);
    ref.read(authSessionRevisionProvider.notifier).advance();
    return Success(initialSession);
  }

  @override
  Future<Result<AuthSession, AuthFailure>> refreshJwt() async {
    final action = refreshAction;
    if (action != null) {
      return action();
    }
    const session = AuthSession.authenticated();
    state = const AsyncData(session);
    ref.read(authSessionRevisionProvider.notifier).advance();
    return const Success(session);
  }

  @override
  Future<Result<AuthSession, AuthFailure>> signOut() async {
    const session = AuthSession.signedOut();
    state = const AsyncData(session);
    ref.read(authSessionRevisionProvider.notifier).advance();
    final action = signOutAction;
    if (action != null) {
      return action();
    }
    return const Success(session);
  }

  @override
  Future<Result<AuthSession, AuthFailure>> invalidate() async {
    const session = AuthSession.signedOut();
    state = const AsyncData(session);
    ref.read(authSessionRevisionProvider.notifier).advance();
    return const Success(session);
  }

  void replaceSession(AuthSession session) {
    state = AsyncData(session);
    ref.read(authSessionRevisionProvider.notifier).advance();
  }
}

final class ControlledNativeSocialAuthGateway
    implements NativeSocialAuthGateway {
  new({
    required this.googleAction,
    required this.appleAction,
  });

  final Future<Result<void, AuthFailure>> Function() googleAction;
  final Future<Result<void, AuthFailure>> Function() appleAction;
  var googleCalls = 0;
  var appleCalls = 0;
  final googleStarted = Completer<void>();

  @override
  Future<Result<void, AuthFailure>> signInWithGoogle() {
    googleCalls++;
    if (!googleStarted.isCompleted) {
      googleStarted.complete();
    }
    return googleAction();
  }

  @override
  Future<Result<void, AuthFailure>> signInWithApple() {
    appleCalls++;
    return appleAction();
  }
}

final class ControlledPasskeyAuthGateway implements PasskeyAuthGateway {
  new({
    required this.signInAction,
    required this.registerAction,
  });

  final Future<Result<AuthSession, AuthFailure>> Function() signInAction;
  final Future<Result<void, AuthFailure>> Function() registerAction;

  @override
  Future<Result<AuthSession, AuthFailure>> signIn() => signInAction();

  @override
  Future<Result<void, AuthFailure>> register() => registerAction();
}

final class ControlledUserApiGateway implements UserApiGateway {
  new({required this.action});

  final Future<Result<Map<String, dynamic>, AuthFailure>> Function() action;

  @override
  Future<Result<Map<String, dynamic>, AuthFailure>> getJson({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) => action();
}
