import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/model/debug_auth_state.dart';
import 'package:eqmonitor/feature/auth/ui/model/debug_auth_presentation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DebugAuthUserSummaryParser', () {
    test('user me応答から完全なメールとIDを残さず要約する', () {
      const email = 'private.person@example.com';
      const userId = 'user-1234567890';

      final result = const DebugAuthUserSummaryParser().parse({
        'id': userId,
        'email': email,
      });

      final summary = result.unwrap();
      expect(summary.maskedEmail, 'p***@e***');
      expect(summary.abbreviatedUserId, 'user-1…');
      expect(summary.maskedEmail, isNot(contains(email)));
      expect(summary.abbreviatedUserId, isNot(contains(userId)));
    });

    for (final body in <Map<String, dynamic>>[
      {'id': 'user-1'},
      {'email': 'private.person@example.com'},
      {'id': '', 'email': 'private.person@example.com'},
      {'id': 'user-1', 'email': ''},
      {'id': 1, 'email': 'private.person@example.com'},
    ]) {
      test('不完全なuser me応答をinvalidResponseへ分類する: $body', () {
        final result = const DebugAuthUserSummaryParser().parse(body);

        expect(
          (result as Failure<DebugAuthUserSummary, AuthFailure>).exception.kind,
          AuthFailureKind.invalidResponse,
        );
      });
    }
  });

  test('failure表示は例外本文を受け取らず安全な固定文言へ変換する', () {
    expect(
      DebugAuthFailurePresentation.message(AuthFailureKind.network),
      'ネットワーク接続を確認してください。',
    );
    expect(
      DebugAuthFailurePresentation.message(AuthFailureKind.busy),
      '別の認証処理が進行中です。',
    );
    expect(
      DebugAuthFailurePresentation.message(AuthFailureKind.unknown),
      '認証処理に失敗しました。',
    );
    expect(
      DebugAuthFailurePresentation.code(AuthFailureKind.network),
      'AuthFailureKind.network',
    );
  });

  test('failureはsession statusを推測せずsafe outcomeだけを更新する', () {
    final expiresAt = DateTime.utc(2030);
    final before = const DebugAuthState.idle().signedIn(
      authenticatedProvider: DebugAuthProviderKind.google,
      expiresAt: expiresAt,
      success: DebugAuthSuccessKind.signedIn,
    );

    final after = before.failed(kind: AuthFailureKind.unauthorized);

    expect(after.provider, DebugAuthProviderKind.google);
    expect(after.jwtExpiresAt, expiresAt);
    expect(after.failureKind, AuthFailureKind.unauthorized);
  });

  test('session loadingはsigned outへ畳まず確認中表示にする', () {
    expect(
      DebugAuthPresentation.sessionStatusLabel(
        state: const DebugAuthState.idle(),
        sessionStatus: null,
        sessionFailed: false,
        debugAuthReadiness: DebugAuthNotifierReadiness.ready,
      ),
      'セッション確認中',
    );
  });

  test('session errorは例外本文を使わない安全な失敗表示にする', () {
    expect(
      DebugAuthPresentation.sessionStatusLabel(
        state: const DebugAuthState.idle(),
        sessionStatus: null,
        sessionFailed: true,
        debugAuthReadiness: DebugAuthNotifierReadiness.ready,
      ),
      '失敗: セッション状態を確認できませんでした。',
    );
  });

  for (final testCase in [
    (
      readiness: DebugAuthNotifierReadiness.loading,
      expected: '認証デバッグを初期化中',
    ),
    (
      readiness: DebugAuthNotifierReadiness.failed,
      expected: '失敗: 認証デバッグを初期化できませんでした。',
    ),
  ]) {
    test('debug auth ${testCase.readiness.name}は安全な固定文言を表示する', () {
      expect(
        DebugAuthPresentation.sessionStatusLabel(
          state: const DebugAuthState.idle().withFailure(
            kind: AuthFailureKind.unknown,
          ),
          sessionStatus: AuthSessionStatus.authenticated,
          sessionFailed: false,
          debugAuthReadiness: testCase.readiness,
        ),
        testCase.expected,
      );
      if (testCase.readiness == DebugAuthNotifierReadiness.failed) {
        expect(
          DebugAuthFailurePresentation.code(AuthFailureKind.unknown),
          'AuthFailureKind.unknown',
        );
      }
    });
  }
}
