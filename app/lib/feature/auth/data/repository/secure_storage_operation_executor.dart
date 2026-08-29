import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';

final class SecureStorageOperationExecutor {
  const new();

  Future<Result<T, AuthFailure>> capture<T>(
    Future<T> Function() operation,
  ) async {
    try {
      return Success(await operation());
    } on Exception catch (_, stackTrace) {
      return Failure(
        const AuthFailure(kind: AuthFailureKind.storage),
        stackTrace,
      );
    }
  }
}
