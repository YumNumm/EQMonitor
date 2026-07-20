import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'knet_credentials_provider.g.dart';

/// BOSAI 認証情報（ユーザーID + パスワード）
class KnetCredentials {
  const KnetCredentials({required this.userId, required this.password});

  final String userId;
  final String password;
}

/// SecureStorage から BOSAI 認証情報を読み書きする Notifier
@Riverpod(keepAlive: true)
class KnetCredentialsNotifier extends _$KnetCredentialsNotifier {
  static final saveMutation = Mutation<void>();
  static final clearMutation = Mutation<void>();

  @override
  Future<KnetCredentials?> build() async {
    final ds = await ref.watch(securePreferencesDataSourceProvider.future);
    final userId = await ds.getString(key: SecureStorageKey.knetBosaiUserId);
    final password = await ds.getString(
      key: SecureStorageKey.knetBosaiPassword,
    );
    if (userId == null || password == null) {
      return null;
    }
    return KnetCredentials(userId: userId, password: password);
  }

  Future<void> save({
    required String userId,
    required String password,
  }) async {
    final ds = await ref.read(securePreferencesDataSourceProvider.future);
    await ds.setString(key: SecureStorageKey.knetBosaiUserId, value: userId);
    await ds.setString(
      key: SecureStorageKey.knetBosaiPassword,
      value: password,
    );
    state = AsyncData(KnetCredentials(userId: userId, password: password));
  }

  Future<void> clear() async {
    final ds = await ref.read(securePreferencesDataSourceProvider.future);
    await ds.remove(key: SecureStorageKey.knetBosaiUserId);
    await ds.remove(key: SecureStorageKey.knetBosaiPassword);
    state = const AsyncData(null);
  }
}
