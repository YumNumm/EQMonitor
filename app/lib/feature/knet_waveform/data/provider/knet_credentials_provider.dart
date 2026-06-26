import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'knet_credentials_provider.g.dart';

const _knetUserIdKey = 'knet_bosai_user_id';
const _knetPasswordKey = 'knet_bosai_password';

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
    final storage = await ref.watch(secureStorageProvider.future);
    final userId = await storage.read(key: _knetUserIdKey);
    final password = await storage.read(key: _knetPasswordKey);
    if (userId == null || password == null) {
      return null;
    }
    return KnetCredentials(userId: userId, password: password);
  }

  Future<void> save({
    required String userId,
    required String password,
  }) async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.write(key: _knetUserIdKey, value: userId);
    await storage.write(key: _knetPasswordKey, value: password);
    state = AsyncData(KnetCredentials(userId: userId, password: password));
  }

  Future<void> clear() async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.delete(key: _knetUserIdKey);
    await storage.delete(key: _knetPasswordKey);
    state = const AsyncData(null);
  }
}
