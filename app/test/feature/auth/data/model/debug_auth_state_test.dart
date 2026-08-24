import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
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
  });
}
