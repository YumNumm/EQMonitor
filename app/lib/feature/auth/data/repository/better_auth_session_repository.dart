import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/repository/secure_storage_operation_executor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'better_auth_session_repository.g.dart';

@Riverpod(keepAlive: true)
Future<BetterAuthSessionRepository> betterAuthSessionRepository(Ref ref) async {
  final preferences = await ref.watch(
    securePreferencesDataSourceProvider.future,
  );
  return BetterAuthSessionRepository(preferences: preferences);
}

final class BetterAuthSessionRepository {
  new({
    required PreferencesDataSource<SecureStorageKey> preferences,
    SessionMutationSerializer? mutationSerializer,
  }) : _preferences = preferences,
       _mutationSerializer = mutationSerializer ?? SessionMutationSerializer();

  final PreferencesDataSource<SecureStorageKey> _preferences;
  final SessionMutationSerializer _mutationSerializer;
  var _generation = 0;

  int get generation => _generation;

  Future<Result<String?, AuthFailure>> readSessionToken() =>
      const SecureStorageOperationExecutor().capture(
        () => _preferences.getString(
          key: SecureStorageKey.betterAuthSessionToken,
        ),
      );

  Future<Result<void, AuthFailure>> saveSessionToken({
    required String token,
    int? expectedGeneration,
  }) {
    final operationGeneration = expectedGeneration ?? _generation;
    return _mutationSerializer.run(
      operation: () {
        if (operationGeneration != _generation) {
          return Future.value(const Success(null));
        }
        return const SecureStorageOperationExecutor().capture(
          () => _preferences.setString(
            key: SecureStorageKey.betterAuthSessionToken,
            value: token,
          ),
        );
      },
    );
  }

  Future<Result<void, AuthFailure>> clearSession() {
    _generation++;
    return _mutationSerializer.run(
      operation: () => const SecureStorageOperationExecutor().capture(
        () => _preferences.remove(
          key: SecureStorageKey.betterAuthSessionToken,
        ),
      ),
    );
  }
}

final class SessionMutationSerializer {
  Future<void> _tail = Future.value();

  Future<Result<T, AuthFailure>> run<T>({
    required Future<Result<T, AuthFailure>> Function() operation,
  }) {
    final result = _tail.then((_) => operation());
    _tail = result.then<void>((_) {});
    return result;
  }
}
