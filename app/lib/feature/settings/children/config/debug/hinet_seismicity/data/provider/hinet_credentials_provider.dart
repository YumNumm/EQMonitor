import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hinet_credentials_provider.g.dart';

const _hinetUserIdKey = 'hinet_bosai_user_id';
const _hinetPasswordKey = 'hinet_bosai_password';

/// Hi-net(BOSAI)認証情報(ユーザーID + パスワード)。
///
/// **注意**: 値そのものをコード・ログ・fixtureへ書き出さないこと。
class HinetCredentials {
  const HinetCredentials({required this.userId, required this.password});

  final String userId;
  final String password;
}

/// SecureStorage から Hi-net 認証情報を読み書きするNotifier。
///
/// [KnetCredentialsNotifier](`app/lib/feature/knet_waveform/data/provider/knet_credentials_provider.dart`)
/// と同じ Mutation パターンに従う。
@Riverpod(keepAlive: true, name: 'hinetCredentialsNotifierProvider')
class HinetCredentialsNotifier extends _$HinetCredentialsNotifier {
  static final saveMutation = Mutation<void>();
  static final clearMutation = Mutation<void>();

  @override
  Future<HinetCredentials?> build() async {
    final storage = await ref.watch(secureStorageProvider.future);
    final userId = await storage.read(key: _hinetUserIdKey);
    final password = await storage.read(key: _hinetPasswordKey);
    if (userId == null || password == null) {
      return null;
    }
    return HinetCredentials(userId: userId, password: password);
  }

  Future<void> save({required String userId, required String password}) async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.write(key: _hinetUserIdKey, value: userId);
    await storage.write(key: _hinetPasswordKey, value: password);
    state = AsyncData(HinetCredentials(userId: userId, password: password));
  }

  Future<void> clear() async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.delete(key: _hinetUserIdKey);
    await storage.delete(key: _hinetPasswordKey);
    state = const AsyncData(null);
  }
}
