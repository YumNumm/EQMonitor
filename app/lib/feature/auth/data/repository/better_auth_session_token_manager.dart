import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';

final class BetterAuthSessionTokenManager {
  const new();

  Future<void> persist<T>({
    required Response<T> response,
    required BetterAuthSessionRepository sessionRepository,
    required int expectedGeneration,
  }) async {
    final tokenHeaders = response.headers.map['set-auth-token'];
    if (tokenHeaders == null || tokenHeaders.length != 1) {
      return;
    }
    final token = tokenHeaders.single;
    if (isSafe(token)) {
      final saveResult = await sessionRepository.saveSessionToken(
        token: token,
        expectedGeneration: expectedGeneration,
      );
      if (saveResult case Failure(:final exception)) {
        throw exception;
      }
    }
  }

  bool isSafe(String token) {
    if (token.isEmpty || token.trim() != token) {
      return false;
    }
    return !token.codeUnits.any((unit) => unit < 0x21 || unit == 0x7f);
  }
}
